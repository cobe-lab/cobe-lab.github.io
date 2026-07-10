---
title: Lab 2A Stimulus PC
layout: default
parent: Equipment Setup
nav_order: 1
---


This is a quick guide to using COBE Lab's *Stimulus PC* that connects to the Eyelink 1000.

Following this guide will ensure that you can run a very simple python experiment coded with psychopy on the stimulus pc attached to the Eyelink 1000.

Running this simple experiment before trying to connect with the *Eyelink 1000* is recommended as it helps with debugging.

## Running the experiment on the Stimulus PC

In order to run the experiment on the Stimulus PC, simply open the [Python experiment.py](/example code/Room_A2/Eyelink1000_exp.py) in VScode and run the script. This should open a new full-screen window that changes in luminance with a colored square in the lower left corner.

## Running the experiment on a local machine

If you want to try and run the experiment on a local machine you'll need to install the required dependencies and have the right version of python. This is because Psychopy (the library) used for building experiments only work with a select few old versions of python. 
We recommend using python 3.9 to run the experiment (as this is what the Stimulus PC uses) and then installing psychopy with the following code
      
`pip install psychopy`

Onces successfully run you can move to connecting the *Eyelink 1000* please find the associated guide [here](../guides/eye-tracking/eyelink1000)