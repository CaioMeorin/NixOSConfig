{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "cmeorin";
  home.homeDirectory = "/home/cmeorin";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.gnome.gnome-initial-setup
    pkgs.gnome.gnome-tweaks
    pkgs.discord
    pkgs.zsh
    pkgs.vim
    pkgs.oh-my-zsh
    pkgs.htop
    pkgs.fortune
    pkgs.google-chrome
    pkgs.nerdfonts
    pkgs.luajit
    pkgs.pyenv
    pkgs.cargo
    pkgs.neovim
    pkgs.curl
    pkgs.gcc
    pkgs.git
    pkgs.gh
    pkgs.perl
    pkgs.curl
    pkgs.python312
    pkgs.tmux
    pkgs.kitty
    pkgs.unzip
    pkgs.ripgrep
    pkgs.fzf
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };
  home.sessionVariables = {
    SHELL="zsh";
    TERMINAL="kitty";
    EDITOR="nvim";
  };
  programs.git = {
    enable = true;
    userName = "cmeorin";
    userEmail = "caiomeorin.dev@gmail.com";
  };
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
