#!/usr/bin/env bash
set -uo pipefail

pane="${1:?Missing pane ID}"

content="$(tmux capture-pane -p -S - -t "$pane")" || exit 1

# 从最新的 panic: 开始，只处理该次 panic 的输出
result="$(
    printf '%s\n' "$content" | awk '
    /^panic:/ {
        start = NR
        first = 0
    }

    start && !first && /^[[:space:]]+.*\.(go|c|cc|cpp|h|hpp|rs|py|java|js|ts):[0-9]+/ {
        first = NR
        line = $0
        sub(/^.*:/, "", line)
        # 下面重新计算源码行号前的冒号位置
        match($0, /:[0-9]+/)
        col = RSTART + 1
    }

    END {
        if (!start || !first) exit 1
        print NR - first, col
    }'
)" || {
    tmux display-message -t "$pane" "No stack frame found in latest panic"
    exit 1
}

read -r up col <<<"$result"

tmux copy-mode -t "$pane"

if ((up > 0)); then
    tmux send-keys -X -t "$pane" -N "$up" cursor-up
fi

tmux send-keys -X -t "$pane" start-of-line

if ((col > 1)); then
    tmux send-keys -X -t "$pane" -N "$((col - 1))" cursor-right
fi
