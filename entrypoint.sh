#!/bin/bash
set -e

# Source ROS environment and workspace
source /opt/ros/noetic/setup.bash
source /root/liorf_ws/devel/setup.bash

# Launch the ROS node
exec roslaunch liorf run_lio_sam_crl.launch
