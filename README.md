# Notes

`flake.nix` is the entrypoint.

To build for laptop

```sh
sudo nixos-rebuild switch --flake .#kixtop
```

To build for home desktop

```sh
sudo nixos-rebuild switch --flake .#kix
```

To update home-manager on work desktop

```sh
home-manager switch --impure
```
