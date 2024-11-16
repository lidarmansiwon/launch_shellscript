#! /bin/bash


echo -e "\033[33mPASS GUIDANCE SYSTEM START\033[0m"
echo ""
echo -e "\033[33mCONTENTS:\033[0m"
echo ""
echo "GLOBAL PATH PLAN NODE"
echo "PCL TOOL BOX NODE"
echo "GRID MAP NODE"
echo "DWA GUIDANCE NODE"
echo "DP GUIDANCE NODE"
echo ""
echo -e "\033[33mSELECT NODE TO RUN\033[0m"
echo "RUN GLOBAL PATH PLAN NODE == 1"
echo "RUN TREE PLANNER(DWA, PCL, GRID) == 2"
echo "RUN ALL Nodes == ENTER"
read input1

# TMUX 세션 생성
SESSION="ros2_nodes"

# tmux 세션이 존재하는지 확인하고, 존재하지 않으면 생성
if ! tmux has-session -t $SESSION 2>/dev/null; then
    tmux new-session -d -s $SESSION
fi

if [ "$input1" -eq 1 ]; then
    echo "\033[33m"RUN GLOBAL PATH PLAN NODE"\033[0m"
    tmux new-window -t $SESSION -n "GlobalPathPlan" "ros2 launch path_plan global_path_planner_ver2.launch.py; read"
    tmux select-window -t $SESSION:GlobalPathPlan
    tmux attach-session -t $SESSION

elif [ "$input1" -eq 2 ]; then 
    echo "\033[33m"RUN TREE PLANNER - DWA, PCL, GRID"\033[0m"
    tmux new-window -t $SESSION -n "TreePlanner" "ros2 launch pass_2024 Tree_Planner_launch.py; read"
    tmux select-window -t $SESSION:TreePlanner
    tmux attach-session -t $SESSION

else 
    echo "\033[33m"RUN ALL Nodes"\033[0m"
    
    # 각 노드를 별도의 tmux 윈도우에서 실행
    tmux new-window -t $SESSION -n "TreePlanner" "ros2 launch pass_2024 Tree_Planner_launch.py; read"
    tmux new-window -t $SESSION -n "PassGuidance" "ros2 launch pass_2024 pass_guid.launch.py; read"
    tmux new-window -t $SESSION -n "TF" "ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 camera_init map_offset; read"
    tmux new-window -t $SESSION -n "GlobalPathPlan" "ros2 launch path_plan global_path_planner_ver2.launch.py; exec bash"
    
    # tmux 세션을 연결하여 모든 노드를 볼 수 있게 함
    tmux select-window -t $SESSION:GlobalPathPlan
    tmux attach-session -t $SESSION
fi
