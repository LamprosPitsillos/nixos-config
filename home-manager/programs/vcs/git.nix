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
    includes = [
      # {
      #   condition = "gitdir:~/docs/WORK/";
      #   contents = {
      #     user = {
      #       email = "l.pitsillos@ianus-technologies.com";
      #     };
      #     core = {
      #       sshCommand = "ssh -i ~/.ssh/id_ed25519_work";
      #     };
      #   };
      # }
    ];
  };
}
