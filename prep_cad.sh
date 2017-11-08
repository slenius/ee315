# from:
# https://askubuntu.com/questions/795487/unable-to-launch-matlab
cd /tmp
wget http://mirrors.kernel.org/ubuntu/pool/main/libx/libxp/libxp6_1.0.2-1ubuntu1_amd64.deb
sudo dpkg -i libxp6_1.0.2-1ubuntu1_amd64.deb

# modified from:
# http://bellyfatcat.com/index.php/2016/09/20/how-to-install-cadence-ic616-on-ubuntu-16-04/
sudo apt-get install build-essential
sudo apt-get install default-jre
sudo apt-get install gawk
sudo ln -s /usr/bin/awk /bin/awk
sudo apt-get install lib32stdc++6 ksh csh tcsh nscd ureadahead

# fonts and unity stuff
sudo apt-get install ubuntu-restricted-extras
sudo apt-get install unity-tweak-tool
sudo apt-get install font-manager

