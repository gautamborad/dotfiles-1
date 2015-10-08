{ config, pkgs, ... }:

let
  fb-input = pkgs.callPackage ./pkgs/fb-input {};
in {
  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      inconsolata
      source-code-pro
      ubuntu_font_family
      fb-input
      terminus_font
    ];
  };

  environment.systemPackages = with pkgs; [
    firefox
    dmenu
    dzen2 # notifications?
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.auto.enable = true;
    displayManager.auto.user = "mjhoy";

    desktopManager.default = "none";
    # desktopManager.xfce.enable = true;

    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.extraPackages = haskellPackages: [
      haskellPackages.xmonad-contrib
    ];
  };
}