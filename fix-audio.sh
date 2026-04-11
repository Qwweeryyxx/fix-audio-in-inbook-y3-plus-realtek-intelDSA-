if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, write sudo!! to restart with root rights and enter your password!"
   exit 1
fi




echo "Start fix"

#!/bin/bash
echo "=== ФИКС ЗВУКА И МИКРОФОНА Infinix Inbook Y3 Plus ==="

sudo tee /etc/modprobe.d/fix-infinix-alc269.conf > /dev/null <<EOF
options snd-hda-intel model=dell-inspiron-7559
options snd-hda-intel power_save=0
options snd-hda-intel power_save_controller=N
EOF

# reboot driver
sudo modprobe -r snd_hda_intel 2>/dev/null || true
sudo modprobe snd_hda_intel

sleep 2


amixer -c 0 set 'Master' 80% unmute
amixer -c 0 set 'Speaker' 100% unmute
amixer -c 0 set 'PCM' 90% unmute


amixer -c 0 set 'Internal Mic' 100% unmute
amixer -c 0 set 'Internal Mic Boost' 0
amixer -c 0 set 'Capture' 66% unmute
amixer -c 0 set 'Digital' 24% unmute

# Save
sudo alsactl store

echo "✅ Done!"
echo "микрофон теперь работает ништяк и звук хотябы пашет.\n если работа микрофона не так как вы хотите, пропишите alsamixer,\n нажмите F6, выберите вариант с написью intel,\n затем F4, отрегулируй Capture (это громкость микрофона) по своему желанию\n а зачем нажми Ctrl + C и пропиши sudo alsactl store"
echo "щас ноут перезагрузит через 15 секунд, если не хочешь - Ctrl + C"
sleep 15
sudo reboot
