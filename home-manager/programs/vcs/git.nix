{...}: {
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Lampros Pitsillos";
    userEmail = "hauahx@gmail.com";
    aliases = {
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
    };
    extraConfig = {
      credential.helper = "store";
      merge.conflictstyle = "zdiff3";
    };
  };
}
