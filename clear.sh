#!/usr/bin/env bash
# Очистка NixOS + Home-Manager: оставляем ~3 последних поколения
# Показывает объём освобождённого места на каждом шаге
# Запускать предпочтительно от root (для полной очистки)

set -euo pipefail

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}┌─────────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│     Очистка NixOS + Home-Manager — оставляем ~3 поколения   │${NC}"
echo -e "${GREEN}└─────────────────────────────────────────────────────────────┘${NC}"

function human_size() {
    numfmt --to=iec-i --suffix=B --format="%.1f" "$1" 2>/dev/null || echo "${1}B"
}

function get_nix_store_size() {
    du -s --exclude=/nix/store/trash /nix/store 2>/dev/null | awk '{print $1}' || echo "unknown"
}

function show_freed() {
    local before="$1"
    local after="$2"
    local freed=$((before - after))
    if [[ $freed -gt 0 ]]; then
        echo -e "Освобождено: ${GREEN}$(human_size $((freed * 1024)))${NC}"
    else
        echo -e "Изменение: ${YELLOW}≈0 или выросло${NC}"
    fi
}

before_total=$(get_nix_store_size)

echo ""
echo -e "${YELLOW}Текущий размер /nix/store:${NC} $(human_size $((before_total * 1024)))"

# ──────────────────────────────────────────────────────────────
echo ""
echo "1. Системные поколения NixOS (оставляем последние 3 + текущее)"

before_sys=$(du -s /nix/var/nix/profiles/system* 2>/dev/null | awk '{s+=$1} END{print s}' || echo 0)

echo "До очистки поколений:"
sudo nixos-rebuild list-generations | tail -n 8 || sudo nix-env -p /nix/var/nix/profiles/system --list-generations | tail -n 8

# Оставляем последние 3 + текущее → удаляем старше 3-го с конца
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3 2>/dev/null || true

after_sys=$(du -s /nix/var/nix/profiles/system* 2>/dev/null | awk '{s+=$1} END{print s}' || echo 0)
echo -e "${GREEN}Системные поколения очищены${NC}"
show_freed "$before_sys" "$after_sys"

# ──────────────────────────────────────────────────────────────
echo ""
echo "2. Поколения Home-Manager текущего пользователя"

if [[ -e "$HOME/.local/state/nix/profiles/home-manager" ]]; then
    before_hm=$(du -s "$HOME/.local/state/nix/profiles/home-manager"* 2>/dev/null | awk '{s+=$1} END{print s}' || echo 0)

    echo "До очистки:"
    home-manager generations | head -n 8 || true

    # Оставляем последние 3 + текущее
    # home-manager не имеет встроенного +N → делаем вручную
    gen_list=$(home-manager generations | grep -Eo '^[0-9]+' | sort -n | tac | tail -n +4 | tac)

    if [[ -n "$gen_list" ]]; then
        echo "$gen_list" | xargs -r home-manager remove-generations
        echo -e "${GREEN}Старые HM-поколения удалены (оставлено ~3–4)${NC}"
    else
        echo -e "${YELLOW}Меньше 4 поколений — ничего не удалено${NC}"
    fi

    after_hm=$(du -s "$HOME/.local/state/nix/profiles/home-manager"* 2>/dev/null | awk '{s+=$1} END{print s}' || echo 0)
    show_freed "$before_hm" "$after_hm"
else
    echo -e "${YELLOW}Home-Manager профиль не найден для текущего пользователя${NC}"
fi

# ──────────────────────────────────────────────────────────────
echo ""
echo "3. Сборщик мусора (nix-collect-garbage)"

before_gc=$(get_nix_store_size)

echo "До GC:"
echo "  /nix/store ≈ $(human_size $((before_gc * 1024)))"

# Безопасный вариант: удаляем старше 8 дней + удаляем мёртвые ссылки
sudo nix-collect-garbage --delete-older-than 8d

# Если хотите максимально агрессивно (осторожно!):
# sudo nix-collect-garbage -d

after_gc=$(get_nix_store_size)
echo -e "${GREEN}Garbage collection завершён${NC}"
show_freed "$before_gc" "$after_gc"

# ──────────────────────────────────────────────────────────────
echo ""
echo "4. Оптимизация хранилища (hardlinks)"

before_opt=$(get_nix_store_size)

echo -n "Запустить оптимизацию? (y/N): "
read -r opt
if [[ "$opt" =~ ^[Yy]$ ]]; then
    echo "Оптимизация (может занять 5–60 мин)..."
    sudo nix store optimise
    after_opt=$(get_nix_store_size)
    show_freed "$before_opt" "$after_opt"
else
    echo "Пропущено."
fi

# ──────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}Итог очистки:${NC}"
after_total=$(get_nix_store_size)
show_freed "$before_total" "$after_total"

echo ""
echo "Оставшиеся поколения:"
echo "→ NixOS:"
sudo nixos-rebuild list-generations | tail -n 7 || true

echo "→ Home-Manager:"
home-manager generations | head -n 7 || echo "(нет поколений или home-manager не установлен)"

echo -e "\n${GREEN}Готово. Рекомендуется:${NC}"
echo "  sudo nixos-rebuild switch   (чтобы убедиться в загрузке)"
echo "  reboot                      (на всякий случай)"
