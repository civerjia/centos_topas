FROM centos/httpd-24-centos7

# https://stackoverflow.com/questions/38133849/cant-use-yum-inside-docker-container-running-on-centos#
USER root
# # http://www.topasmc.org/user-guides/installation
# # intall pre-requisites
RUN yum groupinstall -y "Development Tools" \
    yum install -y expat-devel \
    yum install -y libXmu-devel \
    yum install -y mesa-libGL-devel \
    yum install -y mesa-libGLU-devel 

RUN yum install -y wget
RUN yum install -y wget gcc make cmake g++ git

RUN yum install -y qt5-qtbase-devel

# copy local installation files into docker image
COPY topas_3_7_centos7.tar.gz.part_1 .
COPY topas_3_7_centos7.tar.gz.part_2 .
# Combine the two zip files using the "cat" command and then unpack the result
RUN cat topas_3_7_centos7.tar.gz.part_* > topas_3_7_centos7.tar.gz
RUN tar -zxvf topas_3_7_centos7.tar.gz


# Install Data Files
# in home directory
# RUN mkdir ~/G4Data 
# RUN cd ~/G4Data 

# https://www.computerhope.com/unix/wget.htm
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4NDL.4.6.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4EMLOW.7.9.1.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4PhotonEvaporation.5.5.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4RadioactiveDecay.5.4.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4PARTICLEXS.2.1.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4SAIDDATA.2.0.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4ABLA.3.1.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4INCL.1.0.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4PII.1.3.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4ENSDFSTATE.2.2.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4RealSurface.2.1.1.tar.gz
RUN wget -q https://geant4-data.web.cern.ch/geant4-data/datasets/G4TENDL.1.3.2.tar.gz
RUN tar -zxf G4NDL.4.6.tar.gz
RUN tar -zxf G4EMLOW.7.9.1.tar.gz
RUN tar -zxf G4PhotonEvaporation.5.5.tar.gz
RUN tar -zxf G4RadioactiveDecay.5.4.tar.gz
RUN tar -zxf G4PARTICLEXS.2.1.tar.gz
RUN tar -zxf G4SAIDDATA.2.0.tar.gz
RUN tar -zxf G4ABLA.3.1.tar.gz
RUN tar -xzf G4INCL.1.0.tar.gz
RUN tar -zxf G4PII.1.3.tar.gz
RUN tar -zxf G4ENSDFSTATE.2.2.tar.gz
RUN tar -zxf G4RealSurface.2.1.1.tar.gz
RUN tar -zxf G4TENDL.1.3.2.tar.gz

RUN cd ~
# Set up the environment
# ENV TOPAS_G4_DATA_DIR=/opt/app-root/src/G4Data
ARG TOPAS_G4_DATA_DIR=/opt/app-root/src
ENV TOPAS_G4_DATA_DIR=/opt/app-root/src
# this line maynot work, the previous two lines are usefull
RUN TOPAS_G4_DATA_DIR=/opt/app-root/src
RUN export TOPAS_G4_DATA_DIR
# copy txt files from host to image
COPY *.txt /opt/app-root/src/
COPY *.sh /opt/app-root/src/
# add everything in pwd of host to pwd in image
ADD . .

# RUN pwd
# RUN ls -a
