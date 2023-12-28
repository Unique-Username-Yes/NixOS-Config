{ pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
    services.xserver = {
      enable = true;
      displayManager.gdm = {
          enable = true;
          wayland = true;
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu #application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock #default i3 screen locker
          i3blocks #if you are planning on using i3blocks over i3status
        ];
      };
    };
}