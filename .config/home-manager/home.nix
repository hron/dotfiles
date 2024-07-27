{ config, pkgs, ... }:

let
  treesitGrammars = (pkgs.emacsPackagesFor pkgs.emacs29-pgtk).treesit-grammars.with-all-grammars;
  emacs = (pkgs.emacsPackagesFor pkgs.emacs29-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      vterm
      treesitGrammars
    ]
  );
in
{
  home.username = "algus";
  home.homeDirectory = "/home/algus";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ nixfmt-rfc-style ] ++ [ emacs ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/algus/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #
  # https://github.com/nix-community/home-manager/issues/1439
  home.activation = {
    linkDesktopApplications = {
      after = [
        "writeBoundary"
        "createXdgUserDirectories"
      ];
      before = [ ];
      data = ''
        rm -rf ${config.xdg.dataHome}/"applications/home-manager"
        mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
        cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
      '';
    };
  };

  xdg.enable = true;
  xdg.mime.enable = true;

  xdg.desktopEntries = {
    # We need to redefine StartupWMClass, otherwise the desktop entry is the same
    emacs = {
      name = "Emacs";
      genericName = "Text Editor";
      comment = "Edit text";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      exec = "emacs %F";
      icon = "emacs";
      type = "Application";
      terminal = false;
      categories = [
        "Development"
        "TextEditor"
      ];
      startupNotify = true;
      settings = {
        StartupWMClass = "emacs";
      };
    };

    orgMode = {
      name = "GTD";
      comment = "Get Things Done with org-mode";
      exec = "emacs --name org-mode --eval \"(aleksei/org-gtd)\"";
      icon = "org.gnome.Todo";
      type = "Application";
      terminal = false;
      categories = [ "Utility" ];
      startupNotify = true;
      settings = {
        StartupWMClass = "org-mode";
      };
    };
  };
}
