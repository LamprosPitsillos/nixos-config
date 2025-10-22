{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      credential.helper = "store";
      merge.conflictstyle = "zdiff3";
      alias = {
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
      };
      user = {
        name = "Lampros Pitsillos";
        email = "hauahx@gmail.com";
      };
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
  programs.delta = {

    enable = true;
    enableGitIntegration = true;

  };
}
