#! /bin/sh

echo "\033[33m"PASS GUIDANCE SYSTEM START"\033[0m"
echo ""
echo "\033[33m"CONTENTS: "\033[0m"
echo ""
echo "GLOBAL PATH PLAN NODE"
echo "PCL TOOL BOX NODE"
echo "GRID MAP NODE"
echo "DWA GUIDANCE NODE"
echo "DP GUIDANCE NODE"
echo ""
echo "\033[33m"SELECT NODE TO RUN"\033[0m"
echo "RUN GLOBAL PATH PLAN NODE == 1"
echo "RUN TREE PLANNER(DWA, PCL, GRID) == 2"
echo "RUN ALL Node == ENTER"
read input1

if [ "$input1" -eq 1 ]; then
    echo "\033[33m"RUN GLOBAL PATH PLAN NODE"\033[0m"
    ros2 launch path_plan global_path_planner_ver2.launch.py 
    wait

elif [ "$input1" -eq 2 ]; then 
    echo "\033[33m"RUN TREE PLANNER - DWA, PCL, GRID"\033[0m"
    ros2 launch pass_2024 Tree_Planner_launch.py
    wait
else 
    echo "\033[33m"RUN ALL Node"\033[0m"
  
    ros2 launch pass_2024 Tree_Planner_launch.py &
    ros2 launch pass_2024 pass_guid.launch.py &
    sleep 2
    ros2 launch path_plan global_path_planner_ver2.launch.py

    wait
fi

wait
