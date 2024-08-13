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
  # allowUnfree=true, taken from https://fnordig.de/til/nix/home-manager-allow-unfree.html
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.username = "algus";
  home.homeDirectory = "/home/algus";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages =
    with pkgs;
    [
      nix-direnv
      nix-index

      # LSP
      nil
      phpactor

      # Code Formatters
      nixfmt-rfc-style
      nixpkgs-fmt
      nodePackages.prettier
      # nodePackages.intelephense
      yq-go
      php83Packages.php-codesniffer

      aws-vault
      awscli2
      kubectl
      kubectx
      eksctl
      kustomize

      _1password-gui
      act
      gh
    ]
    ++ [ emacs ];

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
