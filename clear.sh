#!/usr/bin/env bash
set -euo pipefail

echo "1. Удаляем старые системные поколения (> +4)"
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +4 || true

echo "2. Удаляем старые home-manager поколения"
if command -v home-manager >/dev/null; then
    gen_list=$(home-manager generations 2>/dev/null | grep -Eo '^[0-9]+' | sort -n | head -n -4 || true)
    [[ -n "$gen_list" ]] && echo "$gen_list" | xargs -r home-manager remove-generations || echo "HM поколений мало / не найдено"
else
    echo "home-manager не установлен"
fi

echo "3. Garbage collection"
before=$(du -sh /nix/store 2>/dev/null || echo unknown)
sudo nix-collect-garbage --delete-older-than 10d
after=$(du -sh /nix/store 2>/dev/null || echo unknown)
echo "Было: $before   Стало: $after"
