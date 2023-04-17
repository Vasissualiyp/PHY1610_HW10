#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=1:00:00
#SBATCH --job-name=vasilii-parallel

# THIS IS THE SCRIPT THAT GENERATES THE PARAMETER SWEEP
# IF YOU HAVE THE OUTPUT FOLDER CREATED ALREADY IN RUNTIME DIRECTORY,
# PLEASE USE THE clean.sh SCRIPT FIRST

# Set the ICs max
MAX_X=1

# Get current directory
SCRIPT_DIR=$(pwd)

# Disable coredump
ulimit -c 0

# load modules needed...
module load gcc/12
module load gnu-parallel
module load hdf5
module load netcdf

# Get the directory for the output
OUTPUT_DIR="${SCRIPT_DIR}/output"

# Create the output directory
#rm -r -f $OUTPUT_DIR
#mkdir -p "${OUTPUT_DIR}"
#chmod 755 "${OUTPUT_DIR}"

# Run the code on slurm cores. It does 3 things: 
# Create the output directory
# Changes its permissions 
# Runs mzasolve with the appropriate output ics, nc file, and writes terminal output
parallel -j $SLURM_TASKS_PER_NODE  " mkdir -p $SCRIPT_DIR/output/{1}-{2}; chmod 755 $SCRIPT_DIR/output/{1}-{2}; $SCRIPT_DIR/mzasolve {1} {2} $SCRIPT_DIR/output/{1}-{2}/timeseries.nc > $SCRIPT_DIR/output/{1}-{2}/output.txt " ::: $(seq 0 0.02 $MAX_X) ::: $(seq 0 0.02 $MAX_X)



