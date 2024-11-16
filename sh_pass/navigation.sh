#!/bin/sh

# tmux 세션 생성
SESSION="pass_navigation_system"

# 새로운 tmux 세션을 시작
tmux new-session -d -s $SESSION

echo -e "\033[33mPASS NAVIGATION SYSTEM START\033[0m"
echo ""
echo -e "\033[33mCONTENTS:\033[0m"
echo ""
echo "NAVIGATION NODE"
echo "SWITCH MODE NODE"
echo ""
echo -e "\033[33mCHOOSE NAVI METHOD\033[0m"
echo "RUN EKF NAVIGATION == 1"
echo "RUN DEFAULT NAVIGATION == 2"
read input1

if [ "$input1" -eq 1 ]; then
    echo -e "\033[33mRUN EKF NODE\033[0m"
    # tmux 창을 만들고 해당 창에서 EKF 노드 실행
    tmux new-window -t $SESSION -n EKF_Navigation_NODE "ros2 launch pass_2024 pass_ekf_2024_launch.py pcl_topic:=ouster/points; read"
    
elif [ "$input1" -eq 2 ]; then 
    echo -e "\033[33mRUN DEFAULT NODE\033[0m"
    # tmux 창을 만들고 해당 창에서 Default 노드 실행
    tmux new-window -t $SESSION -n DEFAULT_Navigation_NODE "ros2 launch pass_2024 pass_navi_launch.py pcl_topic:=ouster/points; read"
fi

# tmux 세션에 attach하여 실행된 노드를 확인할 수 있도록 함
tmux attach-session -t $SESSION