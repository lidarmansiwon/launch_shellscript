#! /bin/sh

echo "\033[33m"PASS NAVIGATION SYSTEM START"\033[0m"
echo ""
echo "\033[33m"CONTENTS: "\033[0m"
echo ""
echo "NAVIGATION NODE"
echo "SWITCH MODE NODE"
echo ""
echo "\033[33m"CHOOSE NAVI METHOD"\033[0m"
echo "RUN EKF NAVIGATION == 1"
echo "RUN DEFAULT NAVIGATION == 2"
read input1

if [ "$input1" -eq 1 ]; then
    echo "\033[33m"RUN EKF NODE"\033[0m"
    ros2 launch pass_2024 pass_ekf_2024_launch.py pcl_topic:=ouster/points
    
elif [ "$input1" -eq 2 ]; then 
    echo "\033[33m"RUN DEFAULT Node"\033[0m"
    ros2 launch pass_2024 pass_navi_launch.py pcl_topic:=ouster/points
fi

