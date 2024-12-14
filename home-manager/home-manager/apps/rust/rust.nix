{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.rustc
	pkgs.cargo
	pkgs.rustfmt
	pkgs.rust-script
  ];
}
