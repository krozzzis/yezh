# OSA

A reusable [denix](https://github.com/yunfachi/denix) module library for
NixOS + home-manager. This flake has no hosts, no user identity, and no
`nixosConfigurations` of its own — it's just `modules/`, meant to be
imported by whatever flake actually builds a machine.

Personal configuration built on top of OSA lives in separate,
private-by-default flakes:

- [osa-krozzzis](https://github.com/krozzzis/osa-krozzzis) — krozzzis's
  identity, desktop/server profiles, and rice (DE) presets.
- osa-hosts — krozzzis's actual machine configurations (private).

This split is deliberate: `osa` is the reusable part anyone can depend on;
everything person- or machine-specific lives downstream.

## What's in `modules/`

Modules are grouped by category under `modules/osa/`:

| Category      | Contents                                    |
|----------------|----------------------------------------------|
| `ai/`          | AI coding assistants (claude-code, opencode) |
| `apps/`        | misc applications                            |
| `browser/`     | firefox, librewolf, zen-browser, tor         |
| `de/`          | desktop environments (niri, hyprland, xfce, caelestia) + their shells (dms) |
| `dev/`         | LSP and MCP server definitions               |
| `editor/`      | nixvim, vim, zed                             |
| `fileManager/` | nautilus                                     |
| `media/`       | audio/video apps                             |
| `network/`     | yggdrasil                                    |
| `office/`      | libreoffice                                  |
| `shell/`       | CLI utilities (fish, zsh, eza, fzf, ripgrep, ...) |
| `system/`      | system-level settings (audio, polkit, sddm, branding, ...) |
| `terminal/`    | wezterm                                      |

Every module is a `delib.module` (see denix), namespaced as
`myconfig.osa.<category>.<name>`. A module that needs its own flake input
declares it in a sibling `inputs.nix` (e.g.
`modules/osa/de/dms/inputs.nix`) rather than in the root flake — see
`lib/flake-inputs.nix`, which scans for these and feeds them into
`flake-file.nix`.

`flake.nix` is generated from `flake-file.nix` via
[flake-file](https://github.com/vic/flake-file) — never edit it by hand.
After touching `flake-file.nix` or any `inputs.nix`, run:

```bash
nix run .#write-flake
```

`nix flake check` fails if `flake.nix` is out of sync.

## Using OSA in your own configuration

Add it as a flake input:

```nix
inputs.osa.url = "github:krozzzis/osa";
```

Then feed `${inputs.osa}/modules` into denix's module scan alongside your
own module/host directories. A minimal flake putting this together:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs = { nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager"; };
    };
    osa.url = "github:krozzzis/osa";
  };

  outputs = { denix, osa, ... }@inputs: {
    nixosConfigurations = denix.lib.configurations {
      moduleSystem = "nixos";
      homeManagerUser = "<your-username>";
      paths = [
        ./hosts
        "${osa}/modules"
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
```

From there, a host under `./hosts/<name>/default.nix` turns modules on
via `myconfig.osa.<category>.<name>.enable = true;`. See
[osa-krozzzis](https://github.com/krozzzis/osa-krozzzis) for a real
identity/rice layer built this way, and its README for how to wire user
profiles and rices on top of `osa` modules, or `AGENTS.md` in this repo
for the full module-authoring reference (how `delib.module`,
`nixos.ifEnabled`/`home.ifEnabled`, and cross-module options work).

Each module's own `inputs.nix` (if any) is picked up automatically by the
same `lib/flake-inputs.nix` scanning mechanism — nothing needs to be
hand-declared in your root flake for a module you didn't write yourself.
