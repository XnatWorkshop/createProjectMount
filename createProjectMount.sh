#! /bin/bash

project="$1"
project_folder="tank/xnat/archive/${project}"

sudo /sbin/zfs list ${project_folder} 2>&1 | grep -q "dataset does not exist"

if [ $? -ne 0 ]; then
    echo "zfs folder ${project_folder} already exists"
    exit 1
fi

sudo /sbin/zfs create ${project_folder}
sudo /opt/ozmt/snapshots/snapjobs-mod.sh ${project_folder} 15min/4 hourly/12 daily/0
sudo /opt/ozmt/utils/zfs-cache-refresh.sh &
