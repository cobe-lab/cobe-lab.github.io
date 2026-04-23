from psychopy import visual, core, event, monitors
import numpy as np

# Experiment settings
num_trials = 15  # Number of different luminance levels
stim_duration = 2  # Display each screen for 2 seconds

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

luminance_levels = np.array([0.2, 0.5, 0.8])  # Low, medium, high

# Repeat each luminance 5 times = 15 trials
luminance_levels = np.tile(luminance_levels, num_trials//3)
np.random.shuffle(luminance_levels)


#hide mouse:
win.mouseVisible = False

# Mapping luminance to trigger colors
def get_trigger_color(lum):
    if lum == 0.2:
        return (1, -1, -1)  # red
    elif lum == 0.5:
        return (1, 1, -1)  # yellow
    elif lum == 0.8:
        return (-1, 1, -1)  # green


# Run the experiment
for lum in luminance_levels:
    print(1)
    # Convert luminance to PsychoPy's color scale (-1 to 1) as a tuple
    screen_color = tuple([lum * 2 - 1] * 3)  # Ensure it's a tuple of 3 values
   
    # Create the stimulus (full-screen rectangle)
    stim = visual.Rect(win, size=(2500, 2500), pos=(0, 0), fillColor=screen_color, lineColor=screen_color)
   
    trigger_color = get_trigger_color(lum)
   
    trigger = visual.Rect(win, size=(25, 25),  # 10% of original (was 100x100)
                            pos=(-win.size[0]//2 + 25, -win.size[1]//2 + 25),
                            fillColor=trigger_color, lineColor=trigger_color)

    stim.draw()
    trigger.draw()
    win.flip()

    # Wait for stimulus duration
    core.wait(stim_duration)

    # Check for user key press (Escape to exit)
    keys = event.getKeys()
    if "escape" in keys:
        break

# Keep window open until a key press (prevents it from closing instantly)
#event.waitKeys()
core.wait(2)  # waits 2 seconds before closing


# Cleanup
win.close()
core.quit()
