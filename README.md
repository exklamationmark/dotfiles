## Setting up a new machine

This repo contains scripts to setup new machines.

# How to use

```
wget -q -O - https://raw.githubusercontent.com/exklamationmark/dotfiles/refs/heads/main/bootstrap.bash | bash
```

# Overview

I have made most of configurations private, to obfuscate & reduce the chance
of targetted supply-chain attack.

However, a rough idea of this works is:

```
.
├── bootstrap.bash <----------------- entry point for everything
├── lib <---------------------------- bash scripts for bootstrap
│                                     Also install things not configured by Nix
│
│
├── overlays <----------------------- override nixpkgs
├── modules  <----------------------- orthorgonal modules
│   ├── home-manager <------------------- : common things
│   │   ├── password-manager
│   │   ├── shell
│   │   ├── editor
│   │   ├── language-go
│   │   ├── language-rust
│   │   ├── developer-tools
│   │   └── utils
│   │
│   ├── macOS <-------------------------- : for MacOS
│   ├── ubuntu <------------------------- : for Ubuntu
│   │
│   ├── work <--------------------------- : for work
│   └── projects <----------------------- : for projects
│
└── hosts <-------------------------- machine-specific settings
    ├── work-laptop-1
    ├── work-laptop-2
    ├── personal-desktop
    ├── personal-laptop
    ├── lab-server-ABC
    └── lab-server-XYZ
```

This design work pretty well for a small number of machines that share a lot
of configurations.

I only have a few dimenstions to care about (e.g: OS, work/personal).
And most things can be configured with home-manager, it became easier to manage
a fleet of machines.

Some packages are installed via bash instead of Nix, because that's what the
company offering them support (they tend to assume specific things for easier
integrations).

## Other uses

If people are convinced, this setup could be used to manage a fleet of machines
in the same company/team. Nix will make it easy to ensure everyone use the same
tools, while allowing for each machine to still have their own unique configs.
