{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-parents.nix
    ./modules/xfce.nix
  ];

  virtualisation.virtualbox.host.enable = true;

  environment.systemPackages = with pkgs; [
    nixos-unstable.ltris
    pcmanfm
    albatross
    gdrivefs
    truecrypt
    mimms
    bomi
    streamlink
    aspell
    aspellDicts.pl
    pdfmod
    perlPackages.PDFAPI2
    fbida
  ];

  users.extraUsers.robert = {
    hashedPassword = "$6$rcYySsCDE$X/ilZ3Z4/3dUQ0pPXwnStOQQAsGuoCNY26/29oA4vY6gj.9ZpFYnpaiCUXl4w4sEBdtzqze42LePiIFx51cmM1";
    isNormalUser = true;
    description = "Robert Rus";
    extraGroups = [ "wheel" "scanner" "networkmanager" "vboxusers" "cdrom" ];
    dotfiles = let d = ../../../dotfiles; in [ "${d}/base" "${d}/xfce" "${d}/git-annex" "${d}/robertrus" ];
  };

  hardware.android.automount = let user = config.users.users.robert; in {
    enable = true;
    user = user.name;
    point = "${user.home}/Telefon";
  };
}
