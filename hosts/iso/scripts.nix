{ pkgs }:
let
  bootLabel = "boot";
  rootLabel = "nixos";
in
{
  quick-disk-setup = pkgs.writeShellApplication {
    name = "quick-disk-setup";
    runtimeInputs = [
      pkgs.bash
      pkgs.parted
      pkgs.dosfstools
      pkgs.e2fsprogs
      pkgs.util-linux
      pkgs.coreutils
    ];
    text = ''

      bootLabel="${bootLabel}"
      rootLabel="${rootLabel}"

      validate_device() {
        local device="$1"

        if [[ -z "$device" ]]; then
          echo "Usage: quick-disk-setup <device>"
          exit 1
        fi

        if [[ ! -b "$device" ]]; then
          echo "Error: $device is not a block device."
          exit 1
        fi

        echo "WARNING: This will ERASE ALL DATA on $device"
        read -rp "Type 'YES' to continue: " confirm
        if [[ "$confirm" != "YES" ]]; then
          echo "Aborted."
          exit 1
        fi

        echo "$device"
      }

      detect_partition_suffix() {
        # NVMe devices end with 'p1', SATA with '1'
        local device="$1"
        if [[ "$device" =~ nvme[0-9]+n[0-9]+$ ]]; then
          echo "p"
        else
          echo ""
        fi
      }

      format_disk() {
        local device="$1"

        "${pkgs.parted}/bin/parted" "$device" mklabel gpt
        "${pkgs.parted}/bin/parted" "$device" mkpart ESP fat32 1MiB 501MiB
        "${pkgs.parted}/bin/parted" "$device" set 1 esp on
        "${pkgs.parted}/bin/parted" "$device" mkpart primary 501MiB 100%

        echo "Partitioning completed on $device"
      }

      format_partitions() {
        local device="$1"
        local suffix
        suffix=$(detect_partition_suffix "$device")

        local part1="''${device}''${suffix}1"
        local part2="''${device}''${suffix}2"

        if [[ ! -b "$part1" || ! -b "$part2" ]]; then
          echo "Error: partitions do not exist."
          exit 1
        fi

        echo "WARNING: Formatting $part1 and $part2"
        read -rp "Type 'YES' to continue: " confirm
        if [[ "$confirm" != "YES" ]]; then
          echo "Aborted."
          exit 1
        fi

        "${pkgs.dosfstools}/bin/mkfs.fat" -F 32 "$part1"
        "${pkgs.dosfstools}/bin/fatlabel" "$part1" "$bootLabel"
        "${pkgs.e2fsprogs}/bin/mkfs.ext4" -L "$rootLabel" "$part2"

        echo "Formatted:"
        echo "  $part1 → FAT32 label=$bootLabel"
        echo "  $part2 → ext4  label=$rootLabel"
      }

      mount_partitions() {
        local root_path="/dev/disk/by-label/${rootLabel}"
        local boot_path="/dev/disk/by-label/${bootLabel}"

        if [[ ! -b "$root_path" ]]; then
          echo "Error: root label not found: $rootLabel"
          exit 1
        fi

        if [[ ! -b "$boot_path" ]]; then
          echo "Error: boot label not found: $bootLabel"
          exit 1
        fi

        echo "Mounting root partition..."
        "${pkgs.util-linux}/bin/mount" "$root_path" /mnt

        echo "Creating /mnt/boot..."
        "${pkgs.coreutils}/bin/mkdir" -p /mnt/boot

        echo "Mounting boot partition..."
        "${pkgs.util-linux}/bin/mount" "$boot_path" /mnt/boot

        echo "Mount complete:"
        echo "  root → /mnt  (label=$rootLabel)"
        echo "  boot → /mnt/boot (label=$bootLabel)"
      }

      main() {
        local device
        device=$(validate_device "$1")
        format_disk "$device"
        format_partitions "$device"
        mount_partitions
      }

      main "$@"
    '';
  };
}
