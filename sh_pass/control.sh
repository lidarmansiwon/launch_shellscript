#! /bin/sh

echo "\033[33m"MK3 CONTROL SYSTEM START"\033[0m"
sudo chmod -R 777 ~/mount_docker && sudo chmod 777 /dev/tty* && ls /dev/tty*
echo "\033[33m"GET PERMISSION SUCCESS"\033[0m"
echo ""
echo "\033[33m"CONTENTS: "\033[0m"
echo ""
echo "Arudino Serial Node"
echo "CONTORL Node"

echo ""
echo "\033[33m"SELECT NODE TO RUN"\033[0m"
echo "RUN Arudino Serial Node == 1"
echo "RUN CONTORL Node == 2"
echo "RUN ALL Node == ENTER"
read input1

if [ "$input1" -eq 1 ]; then
    echo "\033[33m"RUN Arudino Serial Node"\033[0m"
    ros2 run mk3_control serial_arduino
    wait
elif [ "$input1" -eq 2 ]; then 
    echo "\033[33m"RUN CONTORL Node"\033[0m"
    ros2 launch mk3_control mk3_auto_control.launch.py
    wait
else 
    echo "\033[33m"RUN ALL Node"\033[0m"
    ros2 run mk3_control serial_arduino &
    ros2 launch mk3_control mk3_auto_control.launch.py &
    wait  
fi

