{ pkgs }:
let
  bootLabel = "boot";
  rootLabel = "nixos";
in
{
  quick-disk-setup = pkgs.writeShellApplication {
    name = "quick-disk-setup";
    runtimeInputs = [
      pkgs.parted
      pkgs.util-linux
      pkgs.dosfstools
      pkgs.e2fsprogs
      pkgs.gnugrep
      pkgs.gawk
    ];
    text = ''
      bootLabel="${bootLabel}"
      rootLabel="${rootLabel}"
      SELECTED_DEVICE="" # Global variable to store our target

      choose_device() {
        echo "Please select a disk to ERASE and format:"
        echo "-----------------------------------------------------------------------"
        
        # 1. Generate a list of devices with details
        # We fetch NAME, SIZE, TYPE, and MODEL. 
        # We filter for 'disk' to avoid showing individual partitions or read-only loops.
        mapfile -t raw_list < <(lsblk -dnio NAME,SIZE,TYPE,MODEL | grep "disk")

        if [[ ''${#raw_list[@]} -eq 0 ]]; then
          echo "Error: No disk devices found."
          exit 1
        fi

        # 2. Present the menu
        PS3="Enter the number of the device: "
        select choice in "''${raw_list[@]}" "Abort"; do
          if [[ "$choice" == "Abort" ]]; then
            echo "Exiting."
            exit 0
          elif [[ -n "$choice" ]]; then
            # 3. Extract just the device name from the selection
            # choice looks like: "sda    223.6G disk  SAMSUNG_MZ7LN256"
            # We take the first word and prepend /dev/
            local dev_name
            dev_name=$(echo "$choice" | awk '{print $1}')
            local full_path="/dev/$dev_name"

            echo "-----------------------------------------------------------------------"
            echo "SELECTED: $full_path ($choice)"
            echo "WARNING: ALL DATA ON $full_path WILL BE DELETED."
            read -rp "Type 'YES' to continue: " confirm
            
            if [[ "$confirm" == "YES" ]]; then
              SELECTED_DEVICE="$full_path"
              return 0
            else
              echo "Aborted."
              exit 1
            fi
          else
            echo "Invalid selection.Exiting."
            exit 1
          fi
        done
      }

      detect_partition_suffix() {
        local device="$1"
        if [[ "$device" =~ nvme[0-9]+n[0-9]+$ ]]; then
          echo "p"
        else
          echo ""
        fi
      }

      format_disk() {
        local device="$SELECTED_DEVICE"
        echo "Creating GPT table on $device..."
        parted -s "$device" mklabel gpt
        parted -s "$device" mkpart ESP fat32 1MiB 512MiB
        parted -s "$device" set 1 esp on
        parted -s "$device" mkpart primary 512MiB 100%
        # Ensure kernel sees new partitions before formatting
        udevadm settle
      }

      format_partitions() {
        local device="$SELECTED_DEVICE"
        local suffix
        suffix=$(detect_partition_suffix "$device")
        local part1="''${device}''${suffix}1"
        local part2="''${device}''${suffix}2"

        echo "Formatting $part1 as FAT32..."
        mkfs.fat -F 32 -n "$bootLabel" "$part1"
        
        echo "Formatting $part2 as EXT4..."
        mkfs.ext4 -L "$rootLabel" -F "$part2"
      }

      mount_partitions() {
        echo "Mounting..."
        mount -L "$rootLabel" /mnt
        mkdir -p /mnt/boot
        mount -L "$bootLabel" /mnt/boot
        echo "Filesystems mounted at /mnt and /mnt/boot"
      }

      main() {
        if [[ $EUID -ne 0 ]]; then
           echo "Error: Please run as root (sudo)." 
           exit 1
        fi


        choose_device
        format_disk 
        format_partitions
        mount_partitions
      }

      main "$@"
    '';
  };
}
