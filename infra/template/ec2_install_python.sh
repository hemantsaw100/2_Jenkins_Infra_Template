#! /bin/bash
cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install python3 python3-pip
git clone https://github.com/hemantsaw100/3_python_mysql_db.git # Python MySQL DB Git Repo
sleep 20
cd python-mysql-db-proj-1
pip3 install -r requirements.txt --break-system-packages
echo 'Waiting for 30 seconds before running the app.py'
setsid python3 -u app.py &
sleep 30