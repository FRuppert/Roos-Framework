This is a matlab implementation of the motor/gearhead selection procedure presented in the "Optimal Selection of Motor and Gearhead in Mechatronic Applications" paper. This is a very simple implementation and some simplifications are used, for example are the inertias and efficiencies of the candidate gears implemented as constants for all ratios. 

Example.m
Run this file to quickly test the program
This file executes the FrictionInertial.m and MotorSelection.m files.

Description of the files:

/Loads:
Two files are located in the loads directory, one implements the inertial load (InertialLoad.m) used in the paper and the other the combined load (FrictionInertial.m). Modify one of these files to fit your load. The load file needs to be runned before the MotorSelection.m file is executed. 

CandidateMotorData.m
This file contains information about the candidate motors, replace the information in this file with the data on the candidate motors used in your case.

CandidateGearData.m
This files contains data on the candidate gearheads, replace with data on your gearheads. 

MotorSelection.m
This is the actual selection program. It calculates required RMS motor torque for all motor/gear ratio combinations. All combinations that not can drive the load are removed from the results. THe peak torque limit is currently not checked in the program, but it is easy to add that check...
Before this file is executed, the file specifiing the load has to be executed.



 