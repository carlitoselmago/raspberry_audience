#!/bin/sh -e

#modify GPU memory
echo "gpu_mem=64" >> /boot/config.txt

#replace cmdline with
rm /boot/cmdline.txt
echo "console=serial0,115200 console=tty1 root=PARTUUID=e0e69b19-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles usbcore.usbfs_memory_mb=64 usbcore.autosuspend=-1" > /boot/cmdline.txt

git clone https://github.com/Jyurineko/libfreenect2
cd libfreenect2
sudo apt install libudev-dev
sudo apt install mesa-utils
sudo apt update
sudo apt install libgles2-mesa-dev
#Now similar to Linux install description from: https://github.com/OpenKinect/libfreenect2 ...
sudo apt-get install libusb-1.0-0-dev
sudo apt-get install libturbojpeg0-dev
sudo apt-get install libglfw3-dev
sudo apt-get install libopenni2-dev
sudo apt install -y cmake
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_CUDA=OFF -DENABLE_OPENCL=OFF -DENABLE_OPENGL_AS_ES31=ON -DENABLE_CXX11=ON -DENABLE_VAAPI=OFF
make -j4
sudo make install
sudo ldconfig
sudo cp ../platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/
