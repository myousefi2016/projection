# README

This code was developed during work on Master thesis "Projection method applied to modelling blood flow in cerebral aneurysm". The thesis was writen by Jakub Hrnčíř under the supervision of Jaroslav Hron from Mathematical Institute of Charles University in Prague.

The text of the thesis is available [here](https://drive.google.com/open?id=0B2eGGjPtxvxHTTc0d1JFN0pFMjQ).

## Dependency
The code uses [FEniCS](https://fenicsproject.org/index.html) software. The code was created to work with 1.6.0 and 2016.1 release of FEniCS with [PETSc](https://www.mcs.anl.gov/petsc/) linear algebra backend.

## Overview
The motivation of the work, problems solved and methods used in the code are described in the thesis.

## Parallel run
The "real" aneurysm problem can be run in parallel, and was tested to run on up to 960 cores. To estimate reasonable number of used cores, see results of strong scaling tests in the thesis.
The test problem cannot be run in parallel due to the technique of generating analytic solution. The technique could be changed, but we saw no reason, as the test problem runs sufficiently fast on one core.

## Basic usage
The code is operated using command line arguments. Basic structure is:
    python main.py problem_name solver_name mesh total_time time_step

|argument|option/value|explanation|
|:---|:---|:---|
|problem name|"womersley_cylinder"| test problem |
| |"real"| real aneurysm problem |
|solver name| "ipcs1"| for IPCS scheme or its modifications|
| |"direct"|previous solving strategy (Newton method with direct solver)|
|mesh|"cyl_c1", "cyl_c2" or "cyl_c3"|test problem meshes (gradually increasing quality)|
| | "HYK", or "HYK3"| real mesh (coarsest or middle quality)|
|total time|positive float|in seconds, computation will run from 0 to this time|
|time step|positive float|in seconds|

All parameters are used without quotes. Many optional parameters can be appended.

In the thesis tests on third, finest real mesh were conducted. This mesh is not included in this repository because of its size (231 MB). 

## Optional arguments
### General arguments
|argument|option|explanation|
|:---|:---|:---|
|-n|any string|name of this run instance|
|-s|'noSave' (default)|do not save any XDMF files during computation|
| |'only_vel'|saves only velocity fields|
| |'doSave'|velocity and its divergence, pressure fields|
| |'diff'|adds difference between computed and analytic solution|
|--saventh|positive integer|save velocity, pressure etc. only in every n-th step during first second|
|--ST|"peak"|saves XDMF files only in the second tenth of each second|
| |"min"|"min" saves only up to ten steps around peak
| | |Both options do not save anything during first second, overrides --saventh.|
|--ffc| |FEniCS form compiler options and optimizations|
| |'uflacs_opt' (default)|takes longer to compile but result in more efficient code|
| |'auto_opt'|alternative to 'uflacs_opt'|
| |'auto'|faster compiling, less efficient code (may be used for debugging)|
|--out|"all"|allows output from all processes|
### For "real" problem

### For "womersley_cylinder" problem

### For IPCS solver

### For direct solver

## Another options
Following options were not mentioned in the thesis.
Problem "steady_cylinder" is a simpler variant of test problem "womersley_cylinder", with steady parabolic inflow profile instead of pulsating Womersley flow.
Problem "FaC3D_benchmark"

# Visualisation of results
Computed results are stored in XDMF files. To open them you can use the [ParaView](http://www.paraview.org/) software.

Scripts for convenient visualisation in ParaView are generated after each successful run. The scripts should work well with ParaView version 4.4. For the scripts to work properly, you should open ParaView from the same directory as the folder with results is located (the scripts use relative paths fo XDMF files). To use them, go to menu Tools/Python Shell and then click 'Run Script'.



