#!/usr/bin/env bash
# Launch the AI Industry Chain Cube (SQLite API + modular web UI).
# Type quit (or Ctrl+C) in this terminal to stop.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
PORT=8787
URL="http://127.0.0.1:${PORT}/"
PID=""

cleanup() {
  if [[ -n "${PID}" ]] && kill -0 "$PID" 2>/dev/null; then
    kill "$PID" 2>/dev/null || true
    # Brief wait; force if still alive
    for _ in 1 2 3 4 5; do
      kill -0 "$PID" 2>/dev/null || break
      sleep 0.2
    done
    if kill -0 "$PID" 2>/dev/null; then
      kill -9 "$PID" 2>/dev/null || true
    fi
    wait "$PID" 2>/dev/null || true
  fi
}

trap 'echo; echo "[ai-chain] stopping…"; cleanup; exit 0' INT TERM

cd "$ROOT"

# Free stale listener on our port (our previous server only).
if lsof -ti ":$PORT" >/dev/null 2>&1; then
  echo "[ai-chain] port $PORT busy — stopping previous listener"
  lsof -ti ":$PORT" | xargs kill 2>/dev/null || true
  sleep 0.4
fi

# Homepage company lists read the BICS member DB. It is gitignored and built
# from DATA-SPACE xlsx, so a fresh clone has none; rebuild when xlsx is newer.
BICS_DIR="$ROOT/../class-3-coords/BICS-Classification"
ENTITIES_DB="$BICS_DIR/bics_entities_20261003.db"
DATA_SPACE="$ROOT/../DATA-SPACE"
needs_ingest=0
if [[ ! -f "$ENTITIES_DB" ]]; then
  needs_ingest=1
elif [[ -d "$DATA_SPACE" ]] && [[ -n "$(find "$DATA_SPACE" -name '*.xlsx' ! -name '~$*' -newer "$ENTITIES_DB" -print -quit)" ]]; then
  needs_ingest=1
fi
if (( needs_ingest )); then
  if ! python3 -c "import openpyxl" 2>/dev/null; then
    echo "[ai-chain] installing openpyxl (one-time, reads DATA-SPACE xlsx)…"
    python3 -m pip install --user --quiet openpyxl 2>/dev/null \
      || python3 -m pip install --quiet openpyxl 2>/dev/null \
      || true
  fi
  if python3 -c "import openpyxl" 2>/dev/null; then
    echo "[ai-chain] building BICS member DB from DATA-SPACE (first run may take a minute)…"
    python3 "$BICS_DIR/ingest_20261003_entities.py" \
      || echo "[ai-chain] WARNING: ingest failed — homepage company counts will be 0" >&2
  else
    echo "[ai-chain] WARNING: openpyxl unavailable — homepage company counts will be 0" >&2
    echo "[ai-chain]   fix: python3 -m pip install openpyxl   then relaunch" >&2
  fi
fi

python3 "$ROOT/scripts/seed.py"
echo "[ai-chain] starting server…"
python3 "$ROOT/server/app.py" &
PID=$!
sleep 0.6

if ! kill -0 "$PID" 2>/dev/null; then
  echo "[ai-chain] server failed to start" >&2
  exit 1
fi

open "$URL" 2>/dev/null || true
echo "[ai-chain] homepage  $URL  (pid $PID)"
echo "[ai-chain] decision cube  http://127.0.0.1:${PORT}/cube"
echo "[ai-chain] type quit + Enter to stop, or press Ctrl+C"

while true; do
  if ! kill -0 "$PID" 2>/dev/null; then
    wait "$PID" 2>/dev/null || true
    echo "[ai-chain] server exited"
    exit 0
  fi
  # Read one line; timeout so we notice a dead server
  if ! IFS= read -r -t 1 line; then
    continue
  fi
  cmd="$(printf '%s' "$line" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
  if [[ "$cmd" == "quit" ]]; then
    echo "[ai-chain] quit — stopping server (pid $PID)"
    cleanup
    echo "[ai-chain] stopped"
    exit 0
  fi
done
