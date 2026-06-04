# COBE EEG Lab Development

---

## Equipment sharing policy

Four scenarios:

(1) PI applies for / collects EEG data
(2) Postdoc applies for / collects EEG data
(3) PhD applies for / collects EEG data
(4) Bachelor's / Master's students apply for / collect EEG data

Responses:

Generally, all users will have to apply for EEG resources using the COBE Lab pre-study form. The Lab Manager and a LICS committee (Anna/Cordula?) will review requests and approve with the Lab Manager. All approved users will:

- Be registered in a shared log containing their name and exact equipment used
- Must watch a training video / read a use protocol
- Must submit a signed form indicating that they have done these things
**Scenario 1:** PI does the above, no more is needed.


**Scenario 2:** Postdoc does the above, PI must sign form indicating knowledge of postdoc's use.


**Scenario 3:** PI AND postdoc complete training and sign form.


**Scenario 4:** PI AND students complete training, sign form and must complete at least 1 pilot together before collecting participants.


## Equipment list

**EEG System 01**

- [ ] Amplifier PRO_234
- [ ] Charging USB cable
- [ ] Software USB dongle
- [ ] Bluetooth USB dongle 

**EEG System 02**

- [ ] Amplifier PRO_235
- [ ] Charging USB cable
- [ ] Software USB dongle
- [ ] Bluetooth USB dongle 

**EEG Caps & Accessories**
- [ ] 32-ch 56cm cap PRO_00116
- [ ] 32-ch 56cm cap PRO_00112
- [ ] Brushes for cleaning electrodes (x2, 25 brushes per bag)
- [ ] Plastic wash-bags (x2)
- [ ] Gel (x2, 1 expires Dec 2026, the other expires July 31 2027 or 12 months after opening)
- [ ] Biohazard waste disposal bucket for syringe tips (x1)
- [ ] Measuring tape

**Hairwashing**
- [ ] 1 towel
- [ ] 1 hairdryer
- [ ] 1 shampoo

## EEG Wishlist ##

- [ ] More towels
- [ ] Find hairdryer
- [ ] More shampoo 
- [ ] More caps 

## EEG Use Protocol

**Before subject arrives**

- [ ] Prepare forms:
  - [ ] EEG Information Sheet
  - [ ] Participant Information Sheet
  - [ ] Consent Form
  - [ ] Head measurement log 

- [ ] Prepare gelling station in the lab room:
  - [ ] 1 bottle of gel is placed on convenient surface 
  - [ ] Fill 4 syringes with gel:
    - [ ] Try to reduce air bubbles 
    - [ ] Push out any extra gel that might come out with high force *before* subject arrives
  - [ ] Bundle of paper towels 
  - [ ] Measuring tape 
  
  - [ ] Setup for experiment:
    - [ ] Find amplifier kit. Labelled by amplifier number 
    - [ ] Remove amplifier and find bluetooth dongle (smallest dongle in kit)
    - [ ] Plug in bluetooth dongle to EEG recording computer. Use the laptops (1&2) for stimulus delivery and the desktops (3&4) for recording
    - [ ] Open the mbt streamer software 
    - [ ] Click toggle next to 'disconnected'
    - [ ] In pop up window either click 'scan' if no devices are listed. Otherwise if devices are listed, click on the right one
    - [ ] Click on connect
    - [ ] Slot the amplifier into the cap and snap/secure it to the back
    
    
if you can't see lsl stream:
- [ ] go to start and search 'allow an app through windows firewall'
- [ ] change settings. you might need to elevate with heimdal first and then enter the cobe lab's username and password
- [ ] click allow another app. From the sending computer, it is likely python. from the receiving computer it is likely mbtstreamer
- [ ] to find the location of the app, type python list into powershell and copy the path into the pop up window 
- [ ] click ok

- [ ] open device manager
- [ ] check that the internal bluetooth driver is disabled - note to self: we are afraid of disabling the intel(R) bluetooth driver and is it even necessary since we are not sending triggers via bluetooth
- [ ] you disable the internal driver for the dongle - do this before you plug in the dongle for the first time

**When subject arrives** 

- [ ] Fill out forms (make sure they read EEG information sheet)
- [ ] Explain to them the process of EEG head measurement & gel application 
  - [ ] **Write script for this**
- [ ] Measure head size:
  - [ ] Measure head circumference by wrapping tape measure around head, where tape measure is at the level of the subject's forehead center. 
  - [ ] Now place the cap on the subjects' head (be careful not to touch the electrodes, try to hold cap from inside). The cloth on the cap should not bunched but as flat as possible on the subject's head. If you have trouble finding the inion, you can remove the amplifier from the socket at the back of the cap.
  - [ ] Measure cap to make sure that electrode Cz (electrode #18) is centered between nasion and inion and pre-auricular points:
     - [ ] Nasion-to-inion: Place 0cm point on tape measure over nose bridge, in dip between eyebrows. This is the nasion. Measure the distance from nasion to the bony ridge at the back of the subject's head (underneath their hair). Record this distance in the head measurement log.
     - [ ] Pre-auricular points: Find gap between upper and lower jaw next to the ear on the left side and the right side and measure this distance. Record in the head measurement log. 
- [ ] Prepare the cap for gelling & impedance monitoring:
  - [ ] Turn on the recording software and navigate to the settings tab.
  - [ ] Select the mounting setting
  - [ ] Click on streaming in the recording software
  - [ ] Fill the ground electrode (white, labeled DLR), the reference electrode (blue, labeled CMS) and a third electrode with gel. To properly fill each electrode, you should: 
    1) move the hair slightly with the applicator
    2) add gel
    3) move the applicator around on the head
- [ ] Continuously adjust gel in REF/GND electrodes until impedance display goes below 10 (light green for REF/GND electrodes)
- [ ] Once you have filled the three electrodes, turn off streaming
- [ ] Under impedance measurement, change to all electrodes
- [ ] Turn streaming back on
- [ ] Then gel all other electrodes (each one should turn green, light (=10kOhm) is optimal, dark(=20kOhm) is acceptable). This can take a really long time.
- [ ] Turn impedance measurement off and stop streaming
- [ ] Turn streaming on one more time & look at visualization by Signals tab: You can confirm from the visualisation whether the data quality is good. The visualisation is processed, only the raw data is stored (**look into this!!**)
- [ ] As you fill the cap, avoid to get gel on surfaces

**During study**
- [ ] You can give the subject instructions through the speaker system to the right on the table in the control room. Turn on all three pieces (you turn on the microphone by opening the cover).
- [ ] Remember to turn off the speaker system when the experiment is ongoing.
- [ ] You can see the participant on the video stream via the laptop in the control room (not there yet, but Mads will provide it) 

**After study**
- [ ] Stop recording and disconnect the amplifier in the software
- [ ] Remove the cap from the participant's head and prepare to clean the cap. Place the amplifier by the sink while you show the participant out.
- [ ] Change the name of the recording file to something meaningful
- [ ] Files are saved to mbtStreamer recordings
- [ ] Clean the cap (see instructions below)
- [ ] Empty any trash in the lab into the trashcans in the hallway.

**Cleaning the cap**
- [ ] Clean your hands before you clean the cap because they might have gel on them
- [ ] Place the amplifier in the clear bag and as much of the cables as possible
- [ ] Clean the cap using the mascara brushes in the sink the lab as seen in this video https://www.youtube.com/watch?v=pPvsxgS5FQ4
- [ ] Place the cap on a towel by the sink after cleaning while the amplifier is still in the clear bag.
- [ ] Let the cap dry completely before you store it and the amplifier
- [ ] Push any gel in back into the tub with gel and clean the syringes with water 

**Hyperscanning mode** 

## How to maintain EEG consumables 

**Here we discuss policy for maintaining continuous supply of EEG resources (gel, syringes, etc.)**