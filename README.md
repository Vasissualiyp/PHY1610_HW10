This script does the parameter sweep. It works perfectly on the teach cluster.

Before using it, please load the modules:
`source setup` 
# Parameter sweep
If you already generated the output folder, please use the following to clean it up.
`sbatch clean.sh`
If you are running the code for the first time: 
`sbatch run.sh`

# Postprocessing
`python winners.py`
Would save the ICs of simulations with appropriate winners to humanswin.dat and zombieswin.dat 
