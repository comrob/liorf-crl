FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

ENV CATKIN_WS=/root/liorf_ws
ENV ROS_DISTRO=noetic

RUN apt-get update &&\
apt install software-properties-common -y &&\
    add-apt-repository ppa:borglab/gtsam-release-4.0 &&\
    apt-get update &&\
    apt-get install -y \
    libgtsam-dev \
    libgtsam-unstable-dev \
    libgeographic-dev

RUN mkdir -p ${CATKIN_WS}/src
COPY . ${CATKIN_WS}/src/liorf

WORKDIR ${CATKIN_WS}

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make"

RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN rm ${CATKIN_WS}/src/liorf/config/lio_sam_ouster.yaml

# Default command to run on container start
ENTRYPOINT ["/entrypoint.sh"]



