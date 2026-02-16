if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, write sudo!! to restart with root rights and enter your password!"
   exit 1
fi




echo "Start fix"

sudo tee /etc/modprobe.d/alsa-base.conf << EOF
options snd-hda-intel model=dell-inspiron-7559
EOF

sudo alsa force-reload

echo "fix finish!"
echo "auto-reboot the system after 15 seconds, press Ctrl+C to cancel"
sleep 15
reboot
