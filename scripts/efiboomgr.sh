#!/bin/bash
echo "Beware, it changes entries in NVRAM"
sudo efibootmgr --create \
  --disk /dev/nvme0n1 --part 1 \
  --label 'Arch Hiber' \
  --loader /vmlinuz-linux \
  --unicode 'root=UUID=8102ce03-fbf2-4234-bdc6-dae2e2ccb0a4 rw initrd=\initramfs-linux.img resume=UUID=8102ce03-fbf2-4234-bdc6-dae2e2ccb0a4 resume_offset=3377152'
