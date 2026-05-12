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

    settings = {
      alias = {
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

      url."git@github.com:" = {
        insteadOf = "https://github.com";
      };

      # default user only, see below for specific path-dependent overrides
      user = {
        name = "exklamationmark";
        email  = "tonghuukhiem@gmail.com";
      };
    };
  };
}
