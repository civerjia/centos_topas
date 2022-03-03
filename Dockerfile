# Use debian9 image with downloaded two topas zip files
# FROM shjbdh8qw3eb/debian9
# https://hub.docker.com/r/mwiesnero2c/topas-ubuntu20.04
# FROM ubuntu:20.04
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt update && \
#  apt install -y wget gcc make cmake g++ git \
#         valgrind libboost-all-dev language-pack-en-base libboost-python-dev python3-dev \
# 	sshpass\
# 	clang-tidy clang python-yaml fontconfig python3-pip time\
#  && rm -rf /var/lib/apt/lists/* 
# RUN apt-get update && \
#     apt-get install -y qt5-qmake qt5-default libqt5charts5 libqt5charts5-dev libqt5svg5-dev openssh-client && \
#     apt-get clean && \
#     strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5 && \
#     rm -rf /var/lib/apt/lists/*
    
# RUN apt update && apt install -y libopenblas-base libsuperlu-dev && \
#     wget -q -O worhp_1.14-0~ubuntu2004.deb https://seafile.zfn.uni-bremen.de/f/0171f8b47c114aa282a5/?dl=1 && \
#     chmod +x worhp_1.14-0~ubuntu2004.deb && apt-get install -y ./worhp_1.14-0~ubuntu2004.deb
# RUN pip3 install conan
# ENV LANG en_US.utf-8

# ENV DEBIAN_FRONTEND=noninteractive
# # http://www.topasmc.org/user-guides/installation
# # intall pre-requisites
# RUN apt-get update && \
#     apt-get install -y libexpat1-dev \
#     apt-get install -y libgl1-mesa-dev \
#     apt-get install -y libglu1-mesa-dev \
#     apt-get install -y libxt-dev \
#     apt-get install -y xorg-dev \
#     apt-get install -y build-essential \
#     apt-get install -y libharfbuzz-dev 

# # Combine the two zip files using the "cat" command and then unpack the result
# RUN    cat topas_3_7_debian9.tar.gz.part_* > topas_3_7_debian9.tar.gz \
#     tar -zxvf topas_3_7_debian9.tar.gz

# # Install Data Files
# RUN mkdir ~/G4Data
# RUN cd ~/G4Data
# RUN sudo apt-get update && \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4NDL.4.6.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4EMLOW.7.9.1.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4PhotonEvaporation.5.5.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4RadioactiveDecay.5.4.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4PARTICLEXS.2.1.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4SAIDDATA.2.0.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4ABLA.3.1.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4INCL.1.0.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4PII.1.3.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4ENSDFSTATE.2.2.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4RealSurface.2.1.1.tar.gz \
#     wget -4 https://geant4-data.web.cern.ch/geant4-data/datasets/G4TENDL.1.3.2.tar.gz \
#     tar -zxf G4NDL.4.6.tar.gz \
#     tar -zxf G4EMLOW.7.9.1.tar.gz \
#     tar -zxf G4PhotonEvaporation.5.5.tar.gz \
#     tar -zxf G4RadioactiveDecay.5.4.tar.gz \
#     tar -zxf G4PARTICLEXS.2.1.tar.gz \
#     tar -zxf G4SAIDDATA.2.0.tar.gz \
#     tar -zxf G4ABLA.3.1.tar.gz \
#     tar -xzf G4INCL.1.0.tar.gz \
#     tar -zxf G4PII.1.3.tar.gz \
#     tar -zxf G4ENSDFSTATE.2.2.tar.gz \
#     tar -zxf G4RealSurface.2.1.1.tar.gz \
#     tar -zxf G4TENDL.1.3.2.tar.gz

FROM centos/httpd-24-centos7
# https://stackoverflow.com/questions/38133849/cant-use-yum-inside-docker-container-running-on-centos#
USER root
RUN yum groupinstall -y "Development Tools" \
    yum install -y expat-devel \
    yum install -y libXmu-devel \
    yum install -y mesa-libGL-devel \
    yum install -y mesa-libGLU-devel 

RUN scp topas_3_7_centos7.tar.gz /
RUN scp topas_3_7_centos7.tar.gz.part_2 /
RUN cat topas_3_7_centos7.tar.gz.part_2 > topas_3_7_centos7.tar.gz
RUN tar -zxvf topas_3_7_centos7.tar.gz
# # Set up the environment
# RUN setenv TOPAS_G4_DATA_DIR ~/G4Data
# # run topas
# RUN cd /Applications/topas/examples/SpecialComponents
# RUN /Applications/topas/bin/topas MultiLeafCollimator_sequence.txt