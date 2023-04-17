#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=1:00:00
#SBATCH --job-name=vasilii-parallel

ulimit -c 0
SCRIPT_DIR=$(pwd)
#cd $SLURM_SUBMIT_DIR

# load modules needed...
module load gcc/12
module load gnu-parallel
module load hdf5
module load netcdf

# Create a new directory for output files
OUTPUT_DIR="${SCRIPT_DIR}/output"
mkdir -p "${OUTPUT_DIR}"
chmod 755 "${OUTPUT_DIR}"


#SLURM_TASKS_PER_NODE = 16

# Run the code on 80 cores.
parallel -j $SLURM_TASKS_PER_NODE  " mkdir -p $SCRIPT_DIR/output/{1}-{2}; chmod 755 $SCRIPT_DIR/output/{1}-{2}; $SCRIPT_DIR/mzasolve {1} {2} $SCRIPT_DIR/output/{1}-{2}/result.nc " ::: $(seq 0 0.02 0.04) ::: $(seq 0 0.02 0.04)
#parallel -j 16 "mkdir ./data/{1}; mkdir ./data/{1}/{2}; ./mzasolve {1} {2} ./data/{1}/{2}/result.nc"::: $(seq 0 0.02 1) ::: $(seq 0 0.02 1) 
#parallel -j 16 "./mzasolve {1} {2} ./result.nc" ::: $(seq 0 0.02 1) ::: $(seq 0 0.02 1) 
#parallel -j 16 "mkdir ./data/{1}; mkdir ./data/{1}/{2}"::: $(seq 0 0.02 1) ::: $(seq 0 0.02 1) 



