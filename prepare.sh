lsblk -f
read -p "Select your disk (eg. /dev/sda): " s_disk
echo ""
read -p "Are you sure is it your disk, all the data will be erased ($s_disk)? [y/N] " disk_confirmation
if [ "$disk_confirmation" != "Y" ] && [ "$disk_confirmation" != "y" ]; then
    echo "Exiting script.."
    exit 1
fi

if [ "${s_disk::8}" == "/dev/nvm" ]; then
    p_disk="${s_disk}p"
else
    p_disk="${s_disk}"
fi

parted ${s_disk} -- mklabel gpt
parted ${s_disk} -- mkpart ESP fat32 1MiB 512MiB
parted ${s_disk} -- mkpart primary 512MiB 100%
parted ${s_disk} -- set 1 boot on
mkfs.fat -F32 -n boot ${p_disk}1
mkfs.ext4 -L nixos ${p_disk}2

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot