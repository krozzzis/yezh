# Yezh

NixOS configuration for **nixlaptop** — niri/Wayland, LUKS full-disk encryption, btrfs.

---

## Disk layout

```
/dev/nvme0n1
├── nvme0n1p1   1 GiB    FAT32         /boot (EFI)
└── nvme0n1p2   rest     LUKS2
                          └── btrfs "nixos"
                               ├── @           /
                               ├── @home       /home
                               ├── @nix        /nix
                               ├── @log        /var/log
                               ├── @snapshots  /.snapshots
                               └── @swap       /swap  (12 GiB swapfile)
```

All btrfs subvolumes use `compress=zstd:3` + `noatime`.  
TRIM passthrough (`allowDiscards`) is enabled — safe for NVMe/SSD.

---

## Fresh install

### 0. Boot the NixOS installer

Download the [NixOS minimal ISO](https://nixos.org/download/) and write it to a USB drive:

```bash
# on another machine
dd if=nixos-minimal-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

Boot the target laptop from USB.

### 1. Connect to the internet

```bash
# Wi-Fi
nmcli device wifi connect "SSID" password "password"

# or just use Ethernet — it comes up automatically
ping nixos.org
```

### 2. Clone the repo

```bash
nix-shell -p git
git clone https://github.com/<you>/yezh /mnt/yezh
cd /mnt/yezh
```

### 3. Check the disk device name

```bash
lsblk
```

If your NVMe shows up as something other than `/dev/nvme0n1`, edit
`hosts/nixlaptop/disko.nix` before the next step:

```nix
device = "/dev/nvme0n1";   # ← change this
```

### 4. Partition, format, and mount with disko

> **⚠ This erases the entire disk.**

```bash
sudo nix run github:nix-community/disko -- \
  --mode disko \
  --flake .#nixlaptop
```

disko will:
1. Create a GPT partition table
2. Create the EFI partition and format it as FAT32
3. Create the LUKS2 container — **you will be prompted to set the encryption passphrase**
4. Create the btrfs filesystem and all subvolumes inside LUKS
5. Mount everything under `/mnt`

### 5. Generate hardware config (optional sanity check)

```bash
nixos-generate-config --root /mnt --show-hardware-config
```

Make sure the kernel modules and CPU section match what's in
`hosts/nixlaptop/hardware.nix`. Update if needed.

### 6. Install

```bash
sudo nixos-install --flake .#nixlaptop --root /mnt
```

You will be asked to set the **root password** at the end.

### 7. Reboot

```bash
sudo umount -R /mnt
sudo reboot
```

Remove the USB drive. The bootloader will ask for the LUKS passphrase on every boot.

### 8. First login

Log in as `krozzzis` (initial password is the username itself — change it immediately):

```bash
passwd
```

---

## Rebuild after config changes

```bash
sudo nixos-rebuild switch --flake .#nixlaptop
```

---

## Optional: enroll a TPM2 key (skip passphrase on boot)

After a successful install:

```bash
sudo systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs=0+7 \
  /dev/nvme0n1p2
```

Then add to `hosts/nixlaptop/disko.nix` inside the `luks` block:

```nix
settings = {
  allowDiscards = true;
  bypassWorkqueues = true;
};
extraFormatArgs = [ "--pbkdf=argon2id" ];
```

And in `hosts/nixlaptop/boot.nix`:

```nix
boot.initrd.systemd.emergencyAccess = true; # keep passphrase fallback
```

---

## Snapshots with snapper (optional)

```bash
sudo snapper -c root create-config /
sudo snapper -c home  create-config /home
```

Snapshots land in `/.snapshots` (the `@snapshots` btrfs subvolume).
