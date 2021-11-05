#!/bin/bash -x

# debian install
wget -qO- https://apt.hyperion-project.org/hyperion.pub.key | sudo gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg
echo "deb [signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.hyperion-project.org/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hyperion.list
sudo apt update -y && sudo apt install hyperion -y