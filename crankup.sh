#!/usr/bin/env bash
cd "$(dirname "$0")"
exec nixos-rebuild -I nixpkgs=../nixpkgs -I nixos-config=machines/$(hostname).nix "$@"
