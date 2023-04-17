#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=1:00:00
#SBATCH --job-name=gnu-parallelx16

# load modules needed...
module load gcc/12
module load gnu-parallel

SCRIPT_DIR=$(pwd)
cd $SLURM_SUBMIT_DIR

#SLURM_TASKS_PER_NODE = 16

# Run the code on 80 cores.
parallel -j 4 $SCRIPT_DIR/mzasolve "{1}" "{2}" result.nc ::: $(seq 0 0.02 1) ::: $(seq 0 0.02 1)
#parallel -j 16 "mkdir ./data/{1}; mkdir ./data/{1}/{2}; ./mzasolve {1} {2} ./data/{1}/{2}/result.nc"::: $(seq 0 0.02 1) ::: $(seq 0 0.02 1) 
#parallel -j 16 "./mzasolve {1} {2} ./result.nc" ::: $(seq 0 0.02 1) ::: $(seq 0 0.02 1) 
#parallel -j 16 "mkdir ./data/{1}; mkdir ./data/{1}/{2}"::: $(seq 0 0.02 1) ::: $(seq 0 0.02 1) 



