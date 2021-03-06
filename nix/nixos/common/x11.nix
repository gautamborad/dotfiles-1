{ config, pkgs, ... }:

{
  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      inconsolata
      source-code-pro
      ubuntu_font_family
      terminus_font
    ];
  };

  environment.systemPackages = with pkgs; [
    chromium
    dmenu
    dzen2 # notifications?
    haskellPackages.xmobar
    scrot
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    xkbOptions = "compose:ralt,caps:super";

    displayManager.auto.enable = true;
    displayManager.auto.user = "mjhoy";

    desktopManager.plasma5.enable = true;

    # desktopManager.xfce.enable = true;

    # windowManager.i3.enable = true;
    # windowManager.default = "i3";
    # windowManager.default = "xmonad";
    # windowManager.xmonad.enable = true;
    # windowManager.xmonad.extraPackages = haskellPackages: [
    #   haskellPackages.xmonad-contrib
    # ];
  };
}
