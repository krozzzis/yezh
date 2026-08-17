# OSA

Personal NixOS configuration built on [denix](https://github.com/yunfachi/denix),
a modular system on top of NixOS + home-manager.

## Hosts

### nixlaptop

Main desktop — niri/Wayland, DMS shell, LUKS2-encrypted btrfs on NVMe,
systemd-boot/EFI.

### eeepc

ASUS Eee PC 1001PXD netbook (2010 Atom N455, ~1GB RAM), x86_64. Same
niri/DMS shell as nixlaptop but pared down (no office suite, no AI
assistants, no VMs), plain ext4 + swap partition via GRUB/BIOS boot —
no LUKS/btrfs, too slow for it on this CPU.

### pi-backup

Raspberry Pi 3B (aarch64), headless backup server — SD-card image, plain
ext4, zram swap, a trimmed vendor kernel (no sound/media/BT), and a
hardware watchdog + capped journald for unattended operation.

## Offline installer images

Any host+rice combination that's disko-partitioned and boots from an ISO
(x86_64/i686 — not pi-backup's aarch64 SD-card image) automatically gets
a matching offline installer, built once in `lib/installer.nix`. List
them with `nix flake show` under `packages.x86_64-linux` (e.g.
`eeepc-installer`, `nixlaptop-niri-installer`).

```bash
nix build .#eeepc-installer
sudo dd if=result/iso/nixos-minimal-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

Boot the target machine from that USB stick and run:

```bash
osa-install /dev/sda   # the exact device the image was built for
```

It partitions, formats, and installs the exact target the ISO was built
for — fully offline, no network needed. Unlike `disko-install`, it does
not re-evaluate the flake on the install target; it runs the toplevel
and disko script that were already built when the ISO was made, which
matters on weak hardware like eeepc.

For a manual install instead (e.g. to pick a different disk or tweak
config first), boot any NixOS installer, clone this repo, then:

```bash
sudo nix run github:nix-community/disko -- --mode disko --flake .#<host>
sudo nixos-install --flake .#<host> --root /mnt
```

## Raspberry Pi SD card image (pi-backup)

pi-backup isn't disko-partitioned (see above), so it doesn't get an
offline installer — it builds straight to a flashable SD card image via
nixpkgs' own `sd-image-aarch64.nix`:

```bash
nix build .#nixosConfigurations.pi-backup.config.system.build.sdImage
```

This cross-compiles (see `hosts/pi-backup/default.nix` for why) rather
than emulating aarch64, but still expect a long first build — the kernel
and everything above it builds from source. Output is a zstd-compressed
image at `result/sd-image/*.img.zst`; decompress on the fly straight onto
the card (`/dev/sdX`, not a partition):

```bash
zstdcat result/sd-image/*.img.zst | sudo dd of=/dev/sdX bs=4M status=progress oflag=sync
```

Login is authorized-key-only (baked into the image at build time, see
`hosts/pi-backup/default.nix`) with no password set at all, so there's
nothing to stage on the card by hand before first boot. Boot it, find its
DHCP lease, `ssh krozzzis@<ip>`.
