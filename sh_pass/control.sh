#! /bin/sh

echo -e "\033[33mMK3 CONTROL SYSTEM START\033[0m"
sudo chmod -R 777 ~/mount_docker && sudo chmod 777 /dev/tty* && ls /dev/tty*
echo -e "\033[33mGET PERMISSION SUCCESS\033[0m"
echo ""
echo -e "\033[33mCONTENTS:\033[0m"
echo ""
echo "Arudino Serial Node"
echo "CONTROL Node"
echo ""
echo -e "\033[33mSELECT NODE TO RUN\033[0m"
echo "RUN Arudino Serial Node == 1"
echo "RUN CONTROL Node == 2"
echo "RUN ALL Node == ENTER"
read input1

echo -e "\033[33mSELECT Control Method\033[0m"
echo "RUN Default CONTROL Node == 1"
echo "RUN Tournament CONTROL Node == 2"
read input2

# tmux 세션 생성
SESSION_NAME="mk3_control_system"

tmux new-session -d -s $SESSION_NAME

if [ "$input1" -eq 1 ]; then
    echo "\033[33m"RUN Arudino Serial Node"\033[0m"
    # Arduino Serial Node 실행을 위한 tmux 창 생성
    tmux rename-window -t $SESSION_NAME:0 'ArudinoSerialNode'
    tmux send-keys -t $SESSION_NAME:0 'ros2 run mk3_control serial_arduino' C-m

elif [ "$input1" -eq 2 ]; then 

    if [ "$input2" -eq 1 ]; then
    
        echo "\033[33m"RUN Default CONTORL Node"\033[0m"
        # Control Node 실행을 위한 tmux 창 생성
        tmux rename-window -t $SESSION_NAME:0 'ControlNode'
        tmux send-keys -t $SESSION_NAME:0 'ros2 launch mk3_control mk3_auto_control.launch.py' C-m
    
    else
        echo "\033[33m"RUN Tournament CONTROL Node"\033[0m"
        # Control Node 실행을 위한 tmux 창 생성
        tmux rename-window -t $SESSION_NAME:0 'Tournament ControlNode'
        tmux send-keys -t $SESSION_NAME:0 'ros2 launch mk3_control mk3_tournament_control.launch.py' C-m  
    fi  

else 
    echo "\033[33m"RUN ALL Node"\033[0m"
    # Arduino Serial Node 창 생성 및 실행
    tmux rename-window -t $SESSION_NAME:0 'ArudinoSerialNode'
    tmux send-keys -t $SESSION_NAME:0 'ros2 run mk3_control serial_arduino' C-m
    
    if [ "$input2" -eq 1 ]; then
    
        echo "\033[33m"RUN Default CONTORL Node"\033[0m"
        # Control Node 실행을 위한 tmux 창 생성
        tmux new-window -t $SESSION_NAME:1 -n 'ControlNode'
        tmux send-keys -t $SESSION_NAME:1 'ros2 launch mk3_control mk3_auto_control.launch.py' C-m
    
    else
        echo "\033[33m"RUN Tournament CONTROL Node"\033[0m"
        # Control Node 실행을 위한 tmux 창 생성
        tmux new-window -t $SESSION_NAME:1 -n 'Tournament ControlNode'
        tmux send-keys -t $SESSION_NAME:1 'ros2 launch mk3_control mk3_tournament_control.launch.py' C-m
    fi    
fi

# tmux 세션에 연결하여 출력을 확인할 수 있게 함
tmux attach-session -t $SESSION_NAME
