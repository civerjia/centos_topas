# centos_topas
Install topas in centOS7 within a docker container

Reference: 
- https://docs.docker.com/engine/reference/commandline/run/
- https://docs.docker.com/engine/reference/builder/#env
- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy
- http://www.topasmc.org/user-guides/installation

HOW TO USE
- Download topas and save the two zip files into your working directory (topas_3_7_centos7.tar.gz.part_1 topas_3_7_centos7.tar.gz.part_2)
- Put your text file into the same directory i.e. hello.txt
- Change the text file name in Dockerfile or add [ADD . .] in the last line, then build the image
- ```docker build -t civerjia/centos_topas:topas . --progress=plain```
- ```docker push civerjia/centos_topas:topas```
- Run image in local PC, pathHost is the output directory, pathImage should be the same as [s:Sc/WaterDose/OutputFile] in txt file.```docker run -it -v pathHost:pathImage  civerjia/centos_topas:topas /opt/app-root/src/topas/bin/topas /opt/app-root/src/hello.txt```

# This image was designed to run in WUSTL RIS cluster
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
```mmlsquota --block-size auto -u shuangzhou cache1-fs1:home1```
```echo $HOME```
```ls -lh```
```cd /home/shuang.zhou```
```rm filename```
```rm -r folder/```
show the size used
```du -sh --apparent-size /home/shuang.zhou```

