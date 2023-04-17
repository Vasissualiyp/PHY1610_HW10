#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=1:00:00
#SBATCH --job-name=vasilii-parallel

# THIS SCRIPT IS CREATED TO CLEAN UP THE OUTPUT USING GNU PARALLEL

MAX_X=1

ulimit -c 0
SCRIPT_DIR=$(pwd)

# load modules needed...
module load gcc/12
module load gnu-parallel
module load hdf5
module load netcdf

# Set a new directory for output files
OUTPUT_DIR="${SCRIPT_DIR}/output"

# Run the code on slurm cores.
parallel -j $SLURM_TASKS_PER_NODE  " rm -f -r $SCRIPT_DIR/output/{1}-{2}" ::: $(seq 0 0.02 $MAX_X) ::: $(seq 0 0.02 $MAX_X)
rm -r -f $OUTPUT_DIR



