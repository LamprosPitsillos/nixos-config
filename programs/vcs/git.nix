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
      {
        condition = "gitdir:~/dev/WORK/";
        path = "~/.config/git/work-config";
      }
    ];
  };
  programs.delta = {

    enable = true;
    enableGitIntegration = true;

  };
}
