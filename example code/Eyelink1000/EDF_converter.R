convert_edf <- function(data_dir = "data") {
  library(processx)
  # Get all subdirectories
  all_dirs <- list.dirs(data_dir, recursive = TRUE, full.names = TRUE)
  
  for (dir in all_dirs) {
    edf_files <- list.files(dir, pattern = "\\.EDF$", ignore.case = TRUE, full.names = TRUE)
    asc_files <- list.files(dir, pattern = "\\.asc$", ignore.case = TRUE, full.names = TRUE)
    
    if (length(edf_files) > 0 && length(asc_files) == 0) {
      message("Converting in: ", dir)
      for (edf in edf_files) {
        # Use system call to convert
        cmd <- sprintf('"%s" -y "%s"', "edf2asc", edf)
        system(cmd)
      }
    } else if (length(edf_files) > 0 && length(asc_files) > 0) {
      message("Skipping (ASC already exists): ", dir)
    }
  }
}

transform_asc = function(asc_lines,blink_index,reference_index,downsample){
  library(tidyverse)
  
  downsampled_asc <- asc_lines[seq(1, length(asc_lines), by = downsample)]
  
  
  samples <- grep("^\\d+", asc_lines, value = TRUE)  # lines starting with timestamps
  messages <- grep("^MSG", asc_lines, value = TRUE)  # all event messages
  
  
  extract_condition <- function(line) {
    parts <- strsplit(line, " ")[[1]]
    as.numeric(parts[which(parts == "LUMINANCE") + 1])
  }
  
  trials_start <- grep("trialID", messages, value = TRUE)  # all event messages
  
  trial_end = grep("trial_result",messages, value = TRUE)
  
  lums = as.character(sapply(trials_start, extract_condition))
  
  #lums =  as.numeric(sub(".*[lL]UMIANCE\\s+", "", lums))
  
  trial_starts = match(asc_lines, trials_start)
  trial_ends = match(asc_lines, trial_end)
  
  idx_start = which(!is.na(trial_starts))
  idx_end = which(!is.na(trial_ends))
  
  
  before_preprocessing_plot = 
    data.frame(Text = asc_lines) %>% 
    separate(Text, into = c("time", "x", "y", "pupil"), sep = "\t", convert = TRUE, fill = "right") %>% 
    mutate(n = 1:n()) %>% 
    filter(n > 65) %>%
    mutate(n = n/1000) %>% 
    mutate(pupil = as.numeric(pupil)) %>% 
    # mutate(flag = ifelse(pupil > 2000,1,0)) %>% 
    drop_na() %>% ggplot(aes(x = n, y = pupil))+
    geom_point(alpha = 0.05)+
    # facet_wrap(~flag, scales = "free", ncol = 1)+
    theme_bw()+
    xlab("seconds")+
    ylab("pupil size")+
    theme(legend.position = "bottom")
  
  
  
  
  data = data.frame()
  for(i in 1:length(idx_start)){
    # print(i)
    
    
    tjek = data.frame(T = asc_lines[idx_start[i]:idx_end[i]]) %>% 
      separate(T, into = c("time", "x", "y", "pupil"), sep = "\t", convert = TRUE, fill = "right")
    
    # skip trial if there is a blink of over 500 ms (actually blink_index)
    if(nrow(tjek %>% filter(pupil == "    0.0")) > blink_index){
      print(paste0("@@@@@@@@@@@@@@@@@@@@@@@@, Big Blink detected in ", folder, " at trial = ", i))
      next
    }
    
    
    ref = data.frame(T = asc_lines[(idx_start[i]):(idx_start[i] + reference_index)]) %>%
      mutate(
        num_fields = lengths(strsplit(T, "\t")),
        is_valid_row = num_fields == 5
      ) %>%
      separate(T, into = c("time", "x", "y", "pupil"), sep = "\t", convert = TRUE, fill = "right")  %>% 
      filter(is_valid_row) %>% mutate(pupil = as.numeric(pupil),
                                      time = as.numeric(time)) %>% 
      mutate(pupil = pad_and_interpolate_blinks(time, pupil, pad_ms = 100, sample_rate = 1000))%>% 
      mutate(
        trial = i,
        luminance = lums[i],
        pre_stim = T
      )
    
    ref_sum = ref %>% summarize(mean = mean(pupil), sd = sd(pupil))
    
    
    bb <- data.frame(T = asc_lines[(idx_start[i]+ reference_index):idx_end[i]]) %>%
      mutate(
        num_fields = lengths(strsplit(T, "\t")),
        is_valid_row = num_fields == 5
      ) %>%
      separate(T, into = c("time", "x", "y", "pupil"), sep = "\t", convert = TRUE, fill = "right")  %>% 
      filter(is_valid_row) %>% mutate(pupil = as.numeric(pupil),
                                      time = as.numeric(time)) %>% 
      mutate(pupil = pad_and_interpolate_blinks(time, pupil, pad_ms = 100, sample_rate = 1000)) %>% 
      mutate(
        trial = i,
        luminance = lums[i],
        pre_stim = F
      )
    
    bb = rbind(bb,ref)
    bb$ref_mean = ref_sum$mean
    bb$ref_sd = ref_sum$sd
    
    data = rbind(data,bb)
    
  }
  
  # make sure that the behavioral data and the eyetracking data is the same:
  
  testdata = read.csv(here::here("example code","Eyelink1000",
                                 "Data","Test_subject_1_behavioral_data.csv")) %>% 
    mutate(luminance = as.character(luminance))
  

  data  = inner_join(data, testdata) %>%
    mutate(luminance = as.numeric(luminance)) %>% 
    arrange(time) %>%
    mutate(n = 1:n()/1000)
  
  after_preprocessing_plot = data %>% 
    filter(pre_stim == F) %>% 
    ggplot() +
    geom_point(
      aes(
        x = n,
        y = pupil,
        color = luminance
      ),
      alpha = 0.5
    ) +
    scale_color_gradient(low = "black", high = grey(0.95), guide = "none")+
    geom_point(data = data %>% filter(pre_stim == T) %>% rename(`Before stimulus` = pre_stim), aes(x = n, y = pupil, fill = `Before stimulus`), col = "red")+
    theme_bw()+
    xlab("seconds")+
    ylab("pupil size")+
    theme(legend.position = "bottom")
  
  
  
  after_preprocessing_plot_small = data %>% 
    filter(pre_stim == F & n > 18 & n < 22) %>% 
    ggplot() +
    geom_point(
      aes(
        x = n,
        y = pupil,
        color = luminance
      ),
      alpha = 0.5
    ) +
    scale_color_gradient(low = "black", high = grey(0.95), guide = "none")+
    geom_point(data = data %>% filter(pre_stim == T & n > 18 & n < 22)  %>% rename(`Before stimulus` = pre_stim),
               aes(x = n, y = pupil, fill = `Before stimulus`), col = "red")+
    theme_bw()+
    xlab("seconds")+
    ylab("pupil size")+
    theme(legend.position = "bottom")
  
  
 return(list(after_preprocessing_plot,after_preprocessing_plot_small,before_preprocessing_plot))
  
  
}



pad_and_interpolate_blinks <- function(time, pupil, pad_ms = 100, sample_rate = 1000) {
  
  blink_mask = pupil == 0
  
  n_pad <- round(pad_ms / 1000 * sample_rate)
  
  padded_mask <- rep(FALSE, length(blink_mask))
  blink_indices <- which(blink_mask)
  
  if (length(blink_indices) == 0){
    return(pupil)
  }
  
  for (i in seq_along(blink_indices)) {
    idx <- blink_indices[i]
    start <- max(1, idx - n_pad)
    end   <- min(length(blink_mask), idx + n_pad)
    padded_mask[start:end] <- TRUE
  }
  
  interp_indices <- which(padded_mask)
  valid_indices <- which(!padded_mask)
  
  # Interpolate only if we have enough valid points
  if (length(valid_indices) > 1) {
    interp_pupil <- approx(x = time[valid_indices], y = pupil[valid_indices], xout = time)$y
    pupil[interp_indices] <- interp_pupil[interp_indices]
  }
  
  return(pupil)
}


interpolate_artifacts <- function(time, pupil, sample_rate = 1000,
                                  pad_ms = 100, artifact_sd_thresh = 5) {
  # Ensure numeric
  time <- as.numeric(time)
  pupil <- as.numeric(pupil)
  
  # Step 1: Detect abrupt changes (first derivative)
  pupil_diff <- c(0, diff(pupil))
  threshold <- artifact_sd_thresh * sd(pupil_diff, na.rm = TRUE)
  artifact_mask <- abs(pupil_diff) > threshold
  
  # Step 2: Pad around artifact samples
  n_pad <- round(pad_ms / 1000 * sample_rate)
  padded_mask <- rep(FALSE, length(artifact_mask))
  artifact_indices <- which(artifact_mask)
  
  for (idx in artifact_indices) {
    start <- max(1, idx - n_pad)
    end   <- min(length(artifact_mask), idx + n_pad)
    padded_mask[start:end] <- TRUE
  }
  
  # Step 3: Interpolate
  interp_indices <- which(padded_mask)
  valid_indices <- which(!padded_mask)
  
  interp_pupil <- pupil
  if (length(valid_indices) > 1 && !anyNA(time[valid_indices]) && !anyNA(pupil[valid_indices])) {
    interp_result <- approx(x = time[valid_indices], y = pupil[valid_indices], xout = time, rule = 2)$y
    interp_pupil[interp_indices] <- interp_result[interp_indices]
  } else {
    warning("Too few valid points for interpolation.")
  }
  return(interp_pupil)
  
  
}
