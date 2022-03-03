# centos_topas
HOW TO USE
- Download topas and save the two zip files into your working directory (topas_3_7_centos7.tar.gz.part_1 topas_3_7_centos7.tar.gz.part_2)
- Put your text file into the same directory i.e. hello.txt
- Change the text file name in Dockerfile or add [ADD . .] in the last line, then build the image
- ```docker build -t civerjia/centos_topas:topas . --progress=plain```
- ```docker push civerjia/centos_topas:topas```
- ```docker run -it -v pathHost:pathImage  civerjia/centos_topas:topas /opt/app-root/src/topas/bin/topas /opt/app-root/src/hello.txt```



