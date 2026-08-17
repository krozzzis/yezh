# Проект OSA — Описание для агентов

**OSA** — NixOS конфигурация. Основана на [denix](https://github.com/yunfachi/denix) — модульной системе поверх NixOS + home-manager.

---

## Архитектура

```
flake.nix        ← СГЕНЕРИРОВАННЫЙ файл (github:vic/flake-file), не редактировать руками
flake-file.nix   ← реальная точка входа: outputs (denix) + базовые inputs
├── hosts/       ← конфигурации машин
│   ├── inputs.nix   ← flake inputs, общие для всех хостов (disko, nixos-hardware)
│   └── nixlaptop/
├── modules/     ← переиспользуемые модули
│   ├── config/  ← системные мета-опции (desktop/server/gui/shell/dev)
│   ├── shell/   ← shell утилиты (все включаются при shell.enable)
│   ├── de/      ← Desktop Environments (niri, hyprland, xfce)
│   │   └── dms/inputs.nix, niri/inputs.nix, ...  ← flake inputs конкретного модуля
│   ├── editor/  ← редакторы (nixvim, vim, zed)
│   ├── browser/ ← браузеры
│   ├── apps/    ← приложения
│   ├── media/   ← медиа
│   ├── ai/      ← AI инструменты (opencode)
│   ├── dev/     ← LSP и MCP серверы
│   ├── fileManager/
│   ├── network/
│   ├── office/
│   ├── system/  ← системные настройки
│   ├── terminal/
│   └── user/    ← шрифты, раскладки
├── rices/       ← пресеты DE (rice = desktop environment preset)
├── lib/
│   └── flake-inputs.nix  ← собирает все inputs.nix для flake-file
├── flake.lock
├── AGENTS.md
└── README.md
```

---

## flake.nix / flake-file.nix (как всё собирается)

`flake.nix` больше не редактируется руками — это сгенерированный
[flake-file](https://github.com/vic/flake-file) shim (`evalModules` +
`inputs.flake-file.flakeModules.flake` + `./flake-file.nix`). Реальный
`outputs` и базовый набор inputs (`nixpkgs`, `home-manager`, `denix`,
`flake-file`) живут в `flake-file.nix`.

Любой другой flake input объявляется рядом с модулем, который его
использует, в файле `inputs.nix` (см. `lib/flake-inputs.nix`,
`modules/osa/de/dms/inputs.nix` как пример) — не в корневом flake.nix.
После добавления/изменения `inputs.nix` выполни `nix run .#write-flake`,
чтобы перегенерировать `flake.nix` (или запусти `nix flake check` —
`checks.flake-file-in-sync` упадёт, если файл рассинхронизирован).

- **Модульная система**: `denix` — он проходит по `./hosts`, `./modules`, `./rices`, собирает `nixosConfigurations` и `homeConfigurations`. `inputs.nix`-файлы в этих директориях явно исключены из denix-скана (`exclude` в `flake-file.nix`) — их видит только flake-file.
- **Extensions**: `args` (проброс `cfg` в модули) + `base.withConfig` (включает `myconfig`).
- **Пользователь**: `krozzzis`.
- **specialArgs**: пробрасываются `inputs` (все флейки).

Конфигурация собирается из трёх директорий. Порядок применения: hosts → modules → rices.

---

## hosts/ — машины

В `hosts/nixlaptop/` лежат файлы конкретной машины:
- **`default.nix`** — главная конфигурация: выбирает rice (`niri`), включает dev/desktop, устанавливает дефолтные приложения, настройки питания, Bluetooth, часовой пояс.
- **`boot.nix`** — systemd-boot, Plymouth, silent boot.
- **`disko.nix`** — разметка диска: GPT → ESP (FAT32) + LUKS → btrfs (subvolumes: @, @home, @nix, @log, @snapshots, @swap).
- **`hardware.nix`** — AMD CPU, NVMe, kvm-amd.
- **`network.nix`** — hostname `nixlaptop`, NetworkManager.

---

## rices/ — пресеты DE

Каждый rice — это `delib.rice`, который включает группу модулей для конкретного DE: `niri` (niri + DMS + Walker), `hyprland` (Hyprland + polkit + SDDM), `xfce`. В хосте выбирается полем `rice = "niri";`.

---

## modules/ — категории модулей

Все модули используют `delib.module { name = "категория.подкатегория"; }`.

Доступ к опциям других модулей — через `myconfig.категория.подкатегория.опция`.

---

## Как создать новый модуль

1. Создайте файл `modules/<category>/<name>.nix`.
2. Используйте шаблон:

```nix
{ delib, lib, pkgs, ... }:
delib.module {
  name = "категория.имя";

  options = { myconfig, ... }: {
    категория.имя.enable = lib.mkOption {
      type = lib.types.bool;
      default = myconfig.gui.enable;  # или false, или myconfig.shell.enable
    };
  };

  nixos.ifEnabled = { ... }: { /* NixOS config */ };
  home.ifEnabled = { ... }: { /* home-manager config */ };
  myconfig.ifEnabled = { ... }: { /* влияет на другие myconfig-опции */ };
};
```

3. Если модулю нужен flake input — создай (или дополни) `inputs.nix` рядом с модулем:
   ```nix
   { ... }:
   {
     flake-file.inputs.<name> = {
       url = "github:...";
       inputs.nixpkgs.follows = "nixpkgs";
     };
   }
   ```
   Затем `nix run .#write-flake`, чтобы перегенерировать `flake.nix`. В самом модуле input доступен как обычно, через `inputs.<name>`.
4. Если модуль не требует опций включения — используй `delib.singleEnableOption true/false`.
5. Включи модуль в хосте через `myconfig.категория.имя.enable = true;`.

### Жизненные циклы конфигурации

- `nixos.always` — всегда применяется к NixOS (даже если модуль выключен)
- `nixos.ifEnabled` — применяется к NixOS только если модуль включён
- `home.always` — всегда применяется к home-manager
- `home.ifEnabled` — применяется к home-manager только если модуль включён
- `myconfig.ifEnabled` — влияет на другие myconfig-опции (прокидывает enable в другие модули)

### Доступ к опциям других модулей

```nix
{ myconfig, ... }: {
  myconfig.ifEnabled = {
    other.module.enable = true;  # включить другой модуль
  };

  home.ifEnabled = {
    home.packages = [ myconfig.other.module.pkg ];  # использовать pkg из другого модуля
  };
}
```

### Специальные атрибуты

- `myconfig` — все опции всех модулей (доступны из любого модуля)
- `cfg` — опции текущего модуля (если включено `args` extension в flake.nix)
- `inputs` — все flake inputs
- `host` — информация о хосте
- `pkgs` — nixpkgs

---

## Как создать новый хост

1. Создай `hosts/<name>/default.nix` с `delib.host { name = "<name>"; }`.
2. Укажи `rice = "<name>";` для выбора DE.
3. Настрой нужные модули через `myconfig.*`.
4. Ничего добавлять в `flake.nix`/`flake-file.nix` не нужно — denix сканирует `./hosts` целиком и подхватит новую директорию автоматически. Если хосту нужен свой flake input — `hosts/<name>/inputs.nix`, как в "Как создать новый модуль".

## Как создать новый rice

1. Создай `rices/<name>.nix` с `delib.rice { name = "<name>"; }`.
2. Включи нужные DE/модули через `myconfig.*`.
3. В хосте укажи `rice = "<name>";`.

---

## Команды

```bash
# Сборка и переключение
sudo nixos-rebuild switch --flake .#nixlaptop

# Только home-manager
home-manager switch --flake .#nixlaptop

# Очистка старых поколений
./clear.sh

# Перегенерировать flake.nix после правки flake-file.nix/inputs.nix
nix run .#write-flake

# Проверить, что flake.nix не рассинхронизирован (среди прочего)
nix flake check
```
