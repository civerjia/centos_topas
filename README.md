# centos_topas
Install topas in centOS7 within a docker container

Reference: 
- https://docs.docker.com/engine/reference/commandline/run/
- https://docs.docker.com/engine/reference/builder/#env
- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy
- http://www.topasmc.org/user-guides/installation

HOW TO USE
- Download topas and save the two zip files into your working directory (topas_3_7_centos7.tar.gz.part_1 topas_3_7_centos7.tar.gz.part_2)
- Put your text file into the same directory i.e. hello.txt, ./project1/compute1.txt
- [ADD . .] in the last line will copy everything(txt,sh,folders...) in the same folder to docker image, please remove unrelevant files
- Then build the image
- ```docker build -t civerjia/centos_topas:topas . --progress=plain```
- ```docker push civerjia/centos_topas:topas```
- Run image in local PC, pathHost is the output directory, pathImage should be the same as [s:Sc/WaterDose/OutputFile] in txt file.```docker run -it -v pathHost:pathImage  civerjia/centos_topas:topas /opt/app-root/src/topas/bin/topas /opt/app-root/src/hello.txt```

# This image was designed to run in WUSTL RIS/CHPC cluster
RIS wiki
- https://docs.ris.wustl.edu/doc/compute/workshops/ris-docker-basics.html#in-this-tutorial-we-re-going-to-create-a-custom-docker-container-with-python3-r-and-git
- https://docs.ris.wustl.edu/doc/compute/recipes/ris-compute-storage-volumes.html?highlight=path
- https://docs.ris.wustl.edu/doc/compute/recipes/job-execution-examples.html?highlight=job
- https://docs.ris.wustl.edu/doc/compute/recipes/job-execution-examples.html

Commands after docker push:
- login RIS
- Mount volume host:image `export SCRATCH1=/scratch1/fs1/joe.user
export STORAGE1=/storage1/fs1/joe.user/Active
export LSF_DOCKER_VOLUMES="$HOME:$HOME $STORAGE1:$STORAGE1 $SCRATCH1:$SCRATCH1"`
- interactive ```bsub -oo /storage1/fs1/joe.user/Active/YourPathToSave/output/msg -R 'select[model==Intel_Xeon_Gold6242CPU280GHz]' -R 'rusage[mem=32GB]' -Is -q general-interactive -a 'docker(civerjia/centos_topas:topas)' /opt/app-root/src/topas/bin/topas /opt/app-root/src/hello.txt```
-  Non-Interactive ```bsub -oo /storage1/fs1/joe.user/Active/YourPathToSave/output/msg -R 'select[model==Intel_Xeon_Gold6242CPU280GHz]' -R 'rusage[mem=32GB]' -q general -a 'docker(civerjia/centos_topas:topas)' /opt/app-root/src/topas/bin/topas /opt/app-root/src/hello.txt```


disk quota exceed -> block-size almost full, check block size with this:
```mmlsquota --block-size auto -u yourusername cache1-fs1:home1```
```echo $HOME```
```ls -lh```
remove useless files and folders
```rm filename```
```rm -r folder/```

Commands after docker push:
- login CHPC
- load singularity
  - `module load singularity/3.7.0`
- convert docker image to singularity image
  - `singularity build topas.sif docker://civerjia/centos_topas:topas`
- new shell scripts
```
#!/bin/sh
for idx in {0..95}
do
    module load singularity/3.7.0
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
    mycommand="sbatch -J Topas_Job$idx -o Topas_job$idx.o%j -e Topas_job$idx.e%j -N 1 -n 1 --cpus-per-task 1 --mem 4G -t 23:59:00 call_singularity.sh $idx \n"
    eval $mycommand
done
```
```
#!/bin/sh 
singularity exec --bind data:/storage1/fs1/tiezhizhang/Active/shuangzhou/SpotBeamDecompose topas.sif sh /opt/app-root/src/CTTwoBeam/multiRun_docker$1.sh
```
- run shell scripts
