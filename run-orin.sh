#!/bin/sh
# run container
xhost +si:localuser:root 
nvidia-docker run -it \
  --gpus all \
  --runtime nvidia \
  --net=host \
  -e DISPLAY \
  --security-opt no-new-privileges \
  -v /dev/shm:/dev/shm \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ~/mount/backup:/backup \
  -v ~/mount/data:/data \
  -v ~/mount/project:/project \
  -v ~/mount/tool:/tool \
  --name jetson-agx-cuda \
  jetson-agx/cuda-base:10.2.460-runtime
  #nvcr.io/nvidia/l4t-ml:r32.6.1-py3 
xhost -si:localuser:root 

#  -v /etc/localtime:/etc/localtime:ro \
#  -v /tmp/.X11-unix:/tmp/.X11-unix \
#  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
#  -v ${XDG_RUNTIME_DIR}/pulse/native:/run/user/1000/pulse/native \
#-e QT_GRAPHICSSYSTEM=native \
#-e QT_X11_NO_MITSHM=1 \
#  --device /dev/nvhost-as-gpu \
#--device /dev/nvhost-ctrl \
#  --device /dev/nvhost-ctrl-gpu \
#  --device /dev/nvhost-ctxsw-gpu \
#  --device /dev/nvhost-dbg-gpu \
# --device /dev/nvhost-prof-gpu \
#  --device /dev/nvhost-sched-gpu \
#  --device /dev/nvhost-tsg-gpu \
#--device /dev/nvhost-gpu \
#--device /dev/nvmap \
#--device /dev/snd \
#--privileged \
