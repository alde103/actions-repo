#!/bin/bash

# Cleanup, if restarting a container
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

# Start virtual screen
sudo /sbin/start-stop-daemon --start --pidfile /tmp/custom_xvfb_1.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :1 -ac -screen 0 1280x1024x16;
sleep 5;

export EAGLE_DIR=/opt/eagle-9.6.2;
export DISPLAY=:1;
export EAGLE_USER="rhernandez@valiot.io"
export EAGLE_PSW="DeltaEcho9"

# Eagle Auto Login.
sudo ${EAGLE_DIR}/eagle & sleep 50;
sudo xdotool key Left;
sleep 5;
sudo xdotool key Return;
sleep 5;
sudo xdotool type ${EAGLE_USER};
sleep 5;
sudo xdotool key Return;
sleep 5;
sudo xdotool type ${EAGLE_PSW};
sleep 5;
sudo xdotool key Return;
sleep 10;
sudo kill $(pidof ${EAGLE_DIR}/eagle);
sleep 2;

cp -r lbr ${EAGLE_DIR}/cache/lbr/

# Execute CAM Jobs
sudo ${EAGLE_DIR}/eagle -X -dCAMJOB -j${EAGLE_DIR}/examples/cam/examples/example_2_layer.cam -o/home/user/bin /home/user/optoSensor.brd
sleep 3

# Verify outputs
sudo ls -ls /home/user/
sudo ls -ls /home/user/bin/
sudo ls -ls /home/user/bin/CAMOutputs/
sudo ls -ls /home/user/bin/CAMOutputs/Assembly/
sudo ls -ls /home/user/bin/CAMOutputs/DrillFiles/
sudo ls -ls /home/user/bin/CAMOutputs/GerberFiles/
