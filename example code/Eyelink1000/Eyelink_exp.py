from psychopy import visual, core, event, monitors
from EyeLinkCoreGraphicsPsychoPy import EyeLinkCoreGraphicsPsychoPy
import numpy as np
import pandas as pd
import os
import pylink
import sys
sys.path.append("Eyelink")
from pylink.eyelink import EyeLink

subject_id = "Test_subject_1"
edf_filename = "EXP.EDF"
results_folder = "results"

# Experiment settings
num_trials = 10  # Number of different luminance levels
stim_duration = 2  # Display each screen for 2 seconds
Time_between_stim = 1 #### Time between stimuli
Time_before_stim = 1 #### Time between stimuli


script_dir = os.path.dirname(os.path.abspath(__file__))


# Create a monitor (optional, avoids warnings)
mon = monitors.Monitor("testMonitor", width=30, distance=60)  # Width in cm, Distance in cm

# Create a PsychoPy window
win = visual.Window(
#    size= (500, 500),
    color=(0, 0, 0),
    units="pix",
    monitor="testMonitor",  # Avoids monitor warnings
    fullscr=True  # Set True if you want fullscreen
)

scn_width, scn_height = win.size

# === Launch iohub with EyeLink ===
tracker = EyeLink("100.1.1.1")
tracker.openDataFile(edf_filename)

# === EyeLink calibration graphics ===
genv = EyeLinkCoreGraphicsPsychoPy(tracker, win)
genv.setCalibrationColors((-1, -1, -1), win.color)
genv.setTargetType('picture')
genv.setPictureTarget(os.path.join(script_dir, 'images', 'fixTarget.bmp'))
pylink.openGraphicsEx(genv)


# === EyeLink screen and calibration settings ===
tracker.sendCommand(f"screen_pixel_coords = 0 0 {scn_width - 1} {scn_height - 1}")
tracker.sendMessage(f"DISPLAY_COORDS = 0 0 {scn_width - 1} {scn_height - 1}")
tracker.sendCommand('enable_automatic_calibration=YES')
tracker.sendCommand('automatic_calibration_pacing=500')
           
##################################################################
######## Eyetracker  Calibration #################################
##################################################################
               
# === Calibrate the tracker (optional but recommended) ===
tracker.doTrackerSetup()


# Generate random luminance levels (0 = black, 1 = white)
luminance_levels = np.linspace(0.1, 1.0, num_trials)
np.random.shuffle(luminance_levels)

trial_data = pd.DataFrame(columns=['participant','trial', 'luminance'])  


#hide mouse:
win.mouseVisible = False
# Run the experiment
for i, lum in enumerate(luminance_levels):
    print(i)
    # Convert luminance to PsychoPy's color scale (-1 to 1) as a tuple
    screen_color = tuple([lum * 2 - 1] * 3)  # Ensure it's a tuple of 3 values
   
    # Create the stimulus (full-screen rectangle)
    stim = visual.Rect(win, size=(2500, 2500), pos=(0, 0), fillColor=screen_color, lineColor=screen_color)
   
    #### set the tracker offline and wait after X seconds after each stimuli
    tracker.setOfflineMode()
    #### Time between stimuli
    core.wait(Time_between_stim)
       
    ## Start recording on the eyetracker
    tracker.startRecording(1, 1, 1, 1)

    #send signal that we start the trial with a certain LUMINANCE
    tracker.sendMessage(f"trialID {i+1} LUMINANCE {lum} waiting for {Time_before_stim}")

    core.wait(Time_before_stim)

    # Draw and show stimulus
    tracker.sendMessage("STIMULUS_ONSET")  # Optional: timestamp visual onset

    # Draw and show stimulus
    stim.draw()
    win.flip()

    # Wait for stimulus duration
    core.wait(stim_duration)
   
    # stop recording
    tracker.stopRecording()
    # send ending message
    tracker.sendMessage(f"trial_result  0")


    trial_data.loc[len(trial_data)] = {
        'participant': subject_id,
        'trial': i + 1,  # start from 1
        'luminance': lum
    }


    # Check for user key press (Escape to exit)
    keys = event.getKeys()
    if "escape" in keys:
        break

# Keep window open until a key press (prevents it from closing instantly)
#event.waitKeys()
core.wait(2)  # waits 2 seconds before closing

os.makedirs('data', exist_ok=True)

core.wait(2)  # waits 2 seconds before closing
tracker.setOfflineMode()
core.wait(0.5)

##################################################################
########    Save everything if everything ran smoothly   #########
##################################################################

## behavioural data

# Save behavioral data
df = pd.DataFrame(trial_data)
df.to_csv(os.path.join(results_folder, f"{subject_id}_behavioral_data.csv"), index=False)



tracker.closeDataFile()
local_edf_path = os.path.join(results_folder, edf_filename)
print(local_edf_path)

core.wait(1)

try:
    tracker.receiveDataFile(edf_filename,local_edf_path)
except RuntimeError as e:
    print("error transfering", e)


# Cleanup
tracker.close()
win.close()
core.quit()
