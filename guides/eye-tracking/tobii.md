---
title: Tobii T60 XL eye-tracker
layout: default
parent: Eye Tracking
nav_order: 1
---
# Tobii T60 XL eye-tracker
This is a quick guide to using COBE Lab's [*Tobii T60 XL*](https://www.srlabs.it/wp-content/uploads/2017/07/TXL60.pdf) eye tracker and
the software *Tobii Studio* for experiment building and data analysis. You can read the entire guide before you
start building you experiment or follow along as you build your
experiment.

The *Tobii T60 XL* provides an unobtrusive way of recording gaze data. Cameras are integrated in to the 24 inch widescreen monitor, 
enabling data to be collected in a naturalistic manner. The eye tracker has a sampling rate of 60 Hz and is apt for large stimuli displays.
To get the best quality data, we recommend that the participant uses a chin rest to keep their head stable. COBE Lab has two chin rests available.

If *Tobii Studio* does not support your experimental
design, you can use *PsychoPy* together with our *EyeLink 1000 eye-tracker*.

# Table of Contents

1. [How to create an experiment](#creating-and-editing-an-experiment)
2. [How to run an experiment](#running-an-experiment)
3. [How to analyse data in *Tobii Studio*](#analyses-in-tobii-studio-and-exporting-data)
4. [Instructions for a demo experiment and analysis](#demo-experiment-and-analysis)
5. [How to do eye tracking with *PsychoPy*](#eye-tracking-with-psychopy)
6. [Data management in COBE Lab](#data-management)

---

## Creating and editing an experiment

You can both build and run your experiment through the software *Tobii Studio*.

Open *Tobii Studio*. Experiments are structured around *projects*.
Choose 'create a new project' to create a new experiment.

You build your experiment by dragging and dropping elements from the top
panel and adding them to the timeline at the center. Experiments are
structured in *projects* which effectively are folders saved to the
desktop of the computer and where all files are saved.

To edit your experiment, make sure that the lock in the right hand
corner is unlocked. Remember to lock the lock to avoid unwanted changes
to your experiment.

#### *Types of elements*

-   Instruction: use this element for instructions for the participants.
-   Image: use this element to present images.
-   Movie: use this element to present video clips.
-   Web: use this element to present a webpage.
-   Screen Rec: this element records the screen.
-   External Video: this element records video from an external source
    like a webcam.
-   Scene Camera: this element records video from an external source
    including mapping of gaze data.
-   Questionnaire: use this element to present a questionnaire, e.g. a
    consent form.
-   PDF Element: use this element to present a PDF document.

To change for example how a participant proceed from an element, right
click an element and choose 'edit'. In this window you can change
several parts of how an element is presented.

#### *Managing Participants*

You can add independent variables to your experiment under 'setup' and
'managing participants'. Here you can define variables such as age or
gender.

You can also add these independent variables to a questionnaire element.
Add the variable as described above, add a questionnaire element and
choose 'use values from existing independent variable'.

When you begin your recording, you will either be prompted to input the
answers to the variable before calibration, or if you added a
questionnaire element with existing independent variables, the
participants will answer the questionnaire after calibration.

#### *Changing the order of elements*

There are three ways to vary the order of the elements of your
experiment.

-   Multiple tests: you can add as many tests as you want to a project.
    Each teast is an experiment, so you build an experiment for each
    test you add to a project. This solution works best for factorial
    designs.

-   Counterbalancing: you can counterbalance elements in your experiment
    in two ways. Tobii Studio uses the Latin Square Method for
    counterbalancing.

    -   If you want to counterbalance all elements, you can choose
        'counterbalance mode' in the left corner.

    -   If you want. to counterbalance some but not all elements, you
        can right click each element you want to counterbalance and
        choose 'counterbalance element'.

-   Presentation sequences: in the panel to the left, you can choose
    'presentation sequences', where you define the sequences of the
    elements yourself. Choose 'export' which will open a correctly
    formatted excel file in which you can define the sequences.

These solutions can also be combined. For example, you can have multiple
tests and counterbalacing in the same project.

Choose 'preview test' in the bottom panel to try out your experiment
without recording and calibration.

## Running an experiment

Choose 'start' to run your experiment. Tobii Studio opens a window
where you can put in participant information and after that, calibration
starts.

For the calibration, the participant's eyes should be visible as two
white dots. A successful calibration is marked by short green lines
within each circle. Tobii Studio also suggests how many points should
be recalibrated, if the calibration was not satisfactory. Accept or
recalibrate the calibrations.

If you accept, a window opens to ask whether you wish to begin the
experiment. Choose 'start recording' to begin the experiment.

## Analyses in *Tobii Studio* and exporting data

In the top row, you can click through different ways to visualize and
analyze your data:

-   Replay: you can replay the experiment with the eye tracking data
    overlaid.
-   Visualizations: you can visualize the data in three different ways -
    gaze plot, heat map and cluster.
-   Areas of Interest: draw areas of interest for further analysis.
-   Statistics: choose between different statistics to perform on the
    data.
-   Data Export: choose which part of the data you wish to export to
    analyze elsewhere.

#### *Deleting recordings*

To delete a recording, make sure the lock in the top right corner is
unlocked. Go to the 'replay' panel, right click on the recording you
wish to delete, and select 'delete recording'. Lock the lock again to
avoid unwanted change to the experiment.

## Demo experiment and analysis

You can follow along here to create an experiment and analysis in *Tobii
Studio* using the information and elements described above. This demo
experiment is partly based on a workshop by Sonja Percovic.

**Building an experiment**

**1.** Open *Tobii Studio*. Choose 'create a new project'. Give it a
name, description, author and choose where it should be saved. For our
current purposes, you can call it 'demo_experiment'. Click next.

**2.** Either rename the test or just click 'create'. You can always
rename and create more tests later.

**3.** Add an 'instruction element' and add the following instructions:
*Dear Participant, thank you for your participation in this study. Your task is to find the target as quickly as possible.
When you find it, press the space button. Press the space button when
you are ready to begin.*

**4.** Add the images from the folder labelled 'demo_experiment_stimuli'
on the desktop as 'images'. Remember to add a fixation cross before each new stimulus. Take a look
at the stimuli so you get an understanding of the experiment and in
which order to set it up.

**5.** For each instruction element and image, you need to choose how
the participant will proceed from that element:

-   For each instruction element, right click and choose 'edit'. Choose
    'key press' and 'space'.
-   For each stimulus, right click and choose 'edit'. Choose 'key press'.
-   For each fixation cross, right click and choose 'edit'. Choose
    'viewing time' and set the time to one second.
-   For each instruction of which target to find, right click and choose
    'edit'. Choose 'viewing time' and set the time to three seconds.

**6.** Add an 'instruction element' at the end thanking the participant
for their participation again.

You should now have a finished experiment. This is a very minimal experiment. Remember you can for example define participant parameters and add questionnaire elements. You can also add multiple tests if you for example wish to change the order of the elements.

After you have collected data, you can analyse the results.

## Eye tracking with *PsychoPy*

*Tobii Studio* is fairly limited in terms of creating more complex
study designs. If you for example wish to add loops or feedback, you
need to use another software than *Tobii Studio*, such as *PsychoPy*.

We are currently working on a guide for how to collect eye tracking data with the *Tobii T60 XL* and *Psychopy*. In the meantime, our *Eyelink 1000 eye tracker* is also setup to work with *PsychoPy*. 

## Data management
Remember to transfer the data to your personal AU-computer and store it correctly. You should never store data on COBE Lab's computers due to risk of data theft and data breach. 
We routinely delete data stored on our equipment, so you are at risk of loosing your data, if you store them on our equipment.

