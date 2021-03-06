#!/bin/bash
#PBS -q qfree
#PBS -l select=1:ncpus=24:mpiprocs=24,walltime=12:00:00
#PBS -A OPEN-7-33
#PBS -o TEST0SORo.out
#PBS -e TEST0SORe.out

# see https://docs.it4i.cz/salomon/resource-allocation-and-job-execution
# qfree - max 12h  (for free, low priority, may wait befor start)
# qprod - max 48h  (charge your account)
# qlong - max 144h (charge your account)

# go to working directory on the /scratch/ disc space
cd /scratch/work/user/hrncirja/projection

# use our own fenics module from /home/hron
module use /home/hron/pkg/Modules
module add fenics/1.7.0dev

# run the computation by mpirun
mpirun --display-map --map-by core --bind-to core python main.py real ipcs1 HYK 0.002 0.001 -S only_vel --ST min --wss all --onset 0.5 --stab 0.5 --prv1 12 --pav1 4 --precV sor --bcv LAP -n TEST0SOR | tee TEST0SOR.tmp
