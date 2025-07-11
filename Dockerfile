FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential cmake git pkg-config \
    libsuitesparse-dev libeigen3-dev libboost-all-dev libyaml-cpp-dev \
    libopencv-dev libtbb-dev \
    libgl1-mesa-dev libglew-dev libegl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols \
    && rm -rf /var/lib/apt/lists/*
# Pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin.git /opt/Pangolin && \
    cd /opt/Pangolin && git checkout v0.6 && mkdir build && cd build && \
    cmake .. && cmake --build . && make install && cd / && rm -rf /opt/Pangolin
# GTSAM
RUN git clone https://github.com/borglab/gtsam.git /opt/gtsam && \
    cd /opt/gtsam && git checkout 4.2a6 && mkdir build && cd build && \
    cmake -DGTSAM_POSE3_EXPMAP=ON -DGTSAM_ROT3_EXPMAP=ON -DGTSAM_USE_SYSTEM_EIGEN=ON -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF .. && \
    make -j$(nproc) && make install && cd / && rm -rf /opt/gtsam
WORKDIR /workspace/dm-vio
COPY . /workspace/dm-vio
RUN git submodule update --init --recursive && \
    mkdir build && cd build && cmake .. && make -j$(nproc)
COPY download_euroc.sh /workspace/dm-vio/download_euroc.sh
RUN chmod +x /workspace/dm-vio/download_euroc.sh
CMD ["/bin/bash"]
