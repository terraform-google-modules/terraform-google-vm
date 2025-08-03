#!/bin/bash

# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This script is used to activate Confidential GPU on a Google Cloud VM instance.
# It installs necessary packages, GPU drivers, and configures the Linux Kernel Crypto API (LKCA).
# Runs only once on the first startup of the VM instance.

FLAG_FILE_1="/var/log/confidential-gpu-script-part-1-ran.flag"

echo "Running startup script to activate Confidential GPU..."

# Check if the flag file exists to determine if the script has already run.
if ! [ -f "$FLAG_FILE_1" ]; then
    echo "Running part 1 of the startup script..."
    # Update package list and install necessary packages.
    sudo apt-get update -y
    sudo apt-get install linux-headers-"$(uname -r)" -y
    sudo apt install -y build-essential libxml2 libncurses5-dev pkg-config libvulkan1 gcc-12 -y

    # Install GPU drivers.
    sudo apt install linux-modules-nvidia-550-server-open-gcp nvidia-driver-550-server-open -y

    # Create a flag file to indicate that the part 1 of the script has run.
    touch "$FLAG_FILE_1"
    sudo reboot
fi

FLAG_FILE_2="/var/log/confidential-gpu-script-part-2-ran.flag"

if ! [ -f "$FLAG_FILE_2" ]; then
    echo "Running part 2 of the startup script..."

    # Configure a secure communication between the GPU and the GPU driver, by enabling the Linux Kernel Crypto API (LKCA).
    echo "install nvidia /sbin/modprobe ecdsa_generic; /sbin/modprobe ecdh; /sbin/modprobe --ignore-install nvidia" | sudo tee /etc/modprobe.d/nvidia-lkca.conf
    sudo update-initramfs -u

    # Enable persistence mode.
    sudo test -f /usr/lib/systemd/system/nvidia-persistenced.service && sudo sed -i "s/no-persistence-mode/uvm-persistence-mode/g" /usr/lib/systemd/system/nvidia-persistenced.service
    sudo systemctl daemon-reload

    # Create a flag file to indicate that the part 2 of the script has run.
    sudo touch "$FLAG_FILE_2"

    # Reboot the VM instance to apply LKCA and persistence mode configurations.
    sudo reboot
fi

FLAG_FILE_3="/var/log/confidential-gpu-script-part-3-ran.flag"
if [ -f "$FLAG_FILE_3" ]; then
    echo "Script has already run. Skipping..."
    exit 0
fi

# Set GPU to ready state after each reboot.
sudo nvidia-smi conf-compute -srs 1

touch "$FLAG_FILE_3"
echo "Confidential GPU activation script has completed successfully."
