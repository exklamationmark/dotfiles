{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.git-lfs
    pkgs.git-graph
    pkgs.git-trim
  ];

  programs.git = {
    enable = true;

    package = pkgs.gitFull;

    aliases = {
      s = "status";
      cm = "commit -v";
      cma = "commit -v --amend";
      cmm = "commit --message";
      tree = "log --graph --pretty=oneline --abbrev-commit --decorate --color=always";
      graph = "graph --format=oneline";
      showmsg = "show --pretty=format:%B -s";
      adda = "add --all";
      resolve = "mergetool";
      dfa = "diff --ignore-all-space --color-moved --color=always";
      dfs = "diff --cached --color-moved --color=always";
      fetch = "fetch -a";
      ap = "add --patch";
      an = "add --intent-to-add";
      mg = "merge --stat";
      diffstat = "diff --color --stat";
      fixup = "commit --fixup";
      rbcont = "rebase --continue";
      rbabort = "rebase --abort";
      pusho = "!git push -u origin $(git branch --show-current)";
      pick = "cherry-pick -x";
      pa = "cherry-pick --abort";
      pc = "cherry-pick --continue";
      wipe = "clean --force -d";
    };

    extraConfig = {
      core = {
        logallrefupdates = true;

        filemode = true;

        editor = "nvim";

        whitespace = "trailing-space,space-before-tab";
      };

      rebase = {
        autosquash = true;
      };

      rerere = {
        enabled = true;
      };

      color = {
        ui = true;
        diff = "auto";
      };

      diff = {
        tool = "vimdiff3";
        algorithm = "histogram";
        colorMoved = "default";
        colorMovedWS = "allow-indentation-change";
      };

      difftool = {
        prompt = false;
      };

      merge = {
        tool = "vimdiff3";
        ff = false;
      };

      push = {
        default = "simple";
      };

      filter."lfs" = {
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
      };
    };

    # userName && userEmail are not used.
    # Instead, those info are set conditionally, using include files

    includes = [
      {
        path = "~/.config/git/user-default";
      }
      {
        path = "~/.config/git/user-personal";
        condition = "gitdir:~/workspace/src/github.com/exklamationmark";
      }
      {
        path = "~/.config/git/user-work";
        condition = "gitdir:~/workspace/src/path/to/work";
      }
    ];
  };

  home.file.".config/git/user-default" = {
    text = ''
      [user]
      name = "exklamationmark"
      email = "tonghuukhiem@gmail.com"
    '';
  };

  home.file.".config/git/user-personal" = {
    text = ''
      [user]
      name = "exklamationmark"
      email = "tonghuukhiem@gmail.com"
    '';
  };

  home.file.".config/git/user-work" = {
    text = ''
      [user]
      name = "???"
      email = "???@???.???"
    '';
  };
}
