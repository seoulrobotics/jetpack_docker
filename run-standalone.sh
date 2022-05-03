#!/bin/sh
HOST_IP=`hostname -I | awk '{print $1}'`
REPOSITORY='jetson-agx/opengl'
#JETPACK_VERSION='4.4.1'
#REPOSITORY='nvcr.io/nvidia/l4t-ml'
JETPACK_VERSION='4.5'
#CODE_NAME='bionic'
#TAG="jetpack-$JETPACK_VERSION-$CODE_NAME"
CODE_NAME='r32.5.0-py3'
TAG='r32.5.0-py3'

# setup pulseaudio cookie
#if [ x"$(pax11publish -d)" = x ]; then
#    start-pulseaudio-x11;
#    echo `pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'`
#fi

# run container
xhost +si:localuser:root 
sudo docker run -it \
  --device /dev/nvhost-as-gpu \
  --device /dev/nvhost-ctrl \
  --device /dev/nvhost-ctrl-gpu \
  --device /dev/nvhost-ctxsw-gpu \
  --device /dev/nvhost-dbg-gpu \
  --device /dev/nvhost-gpu \
  --device /dev/nvhost-prof-gpu \
  --device /dev/nvhost-sched-gpu \
  --device /dev/nvhost-tsg-gpu \
  --device /dev/nvmap \
  --device /dev/snd \
  --net=host \
  -e DISPLAY \
  -e PULSE_SERVER=tcp:$HOST_IP:4713 \
  -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
  -e QT_GRAPHICSSYSTEM=native \
  -e QT_X11_NO_MITSHM=1 \
  -v /dev/shm:/dev/shm \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
  -v ${XDG_RUNTIME_DIR}/pulse/native:/run/user/1000/pulse/native \
  -v ~/mount/backup:/backup \
  -v ~/mount/data:/data \
  -v ~/mount/project:/project \
  -v ~/mount/tool:/tool \
  --name jetson-agx-opengl-${TAG} \
  ${REPOSITORY}:${TAG}
xhost -si:localuser:root 
 #-v /usr/local/cuda-11.4/lib64:/usr/local/cuda/lib64 \
 #-v /usr/local/cuda-11.4:/usr/local/cuda \
