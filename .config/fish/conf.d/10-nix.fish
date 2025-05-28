# Nix Standalone
set nix_profile "$HOME/.nix-profile/etc/profile.d/nix.fish"
[ -e $nix_profile ] && source $nix_profile

# Nix's Home Manager
set nix_home_manager_init "$HOME/.nix-profile/etc/profile.d/hm-session-vars.fish"
[ -e $nix_home_manager_init ] && source $nix_home_manager_init
