#FROM nvcr.io/nvidia/l4t-ml:r32.5.0-py3
FROM nvcr.io/nvidia/l4t-cuda:10.2.460-runtime
# set the locale
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

# install packages
RUN apt-get update \
    && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs) main restricted \n\
deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-updates main restricted \n\
deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse \n\
deb-src http://security.ubuntu.com/ubuntu $(lsb_release -cs)-security main restricted" \
    > /etc/apt/sources.list.d/official-source-repositories.list

# install build tools
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TERM=linux apt-get install --no-install-recommends -q -y \
    apt-utils -y \
    apt-transport-https \
    bash-completion \
    build-essential \
    ca-certificates \
    clang \
    clang-format \
    cmake \
    cmake-curses-gui \
    curl \
    gconf2 \
    gconf-service \
    gdb \
    git-core \
    git-gui \
    gvfs-bin \
    inetutils-ping \
    llvm \
    llvm-dev \
    nano \
    net-tools \
    pkg-config \
    shared-mime-info \
    software-properties-common \
    sudo \
    tzdata \
    unzip \
    wget \
    vim -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# create user
ENV HOME /home/seoulrobotics
RUN adduser seoulrobotics --uid 1000 --disabled-password --gecos "" \
    && echo "seoulrobotics:seoulrobotics" | chpasswd \
    && adduser seoulrobotics sudo \
    && echo "seoulrobotics ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#RUN useradd -ms /bin/bash seoulrobotics 
# switch to non-root user
USER seoulrobotics

# set the working directory
WORKDIR $HOME

CMD ["bash"]
