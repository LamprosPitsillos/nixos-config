{ ... }:
{
  # Can import any users i would like present on this host
  imports = [
    ../../share/users.nix
    ../../modules/user_preferences
    ../../users/housekeeper
  ];
}
