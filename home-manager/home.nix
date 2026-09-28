# This is your home-manager configuration file
# Use this to configure your home environment.
# (On NixOS this is imported per user from nixos/configuration.nix
# via home-manager.users."<name>".)
{
  pkgs, 
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager),
    # add them to nixos/configuration.nix via garuda.home-manager.modules.

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    # (needs `inputs` passed through home-manager.extraSpecialArgs first)

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home = {
    username = "yan";
    homeDirectory = "/home/yan";
  };

  programs.fish.enable = true;

  programs.neovim = {
    enable=true;
    defaultEditor = true;

    initLua = ''
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
      '';
  };
  
  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  programs.git.settings = {
    user.name = "yan";
    user.email = "ymcdonald@izayan.ca";
    core.editor = "nvim";
  };

  programs.yazi = {
    enable = true;

    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
  };

  #Historique des commandes shell
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.qutebrowser = {
    enable = true;

    settings = {
      colors.webpage.darkmode.enabled = true;
      content.headers.accept_language =
        "fr-CA,fr;q=0.9,en-CA;q=0.8,en;q=0.7";
    };
  };

  home.packages = with pkgs; [ 
    lazygit
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.11";
}
