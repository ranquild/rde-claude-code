#!/usr/bin/env bash
# Logs the mb CLI in to Metabase with the API key created from config.yml.
set -euo pipefail

: "${MB_URL:?}" "${MB_API_KEY:?}"

# Pipe the key: with a TTY attached, mb would otherwise prompt interactively.
printf '%s' "$MB_API_KEY" | mb auth login --url "$MB_URL" >/dev/null
echo "mb CLI logged in to $MB_URL."

exec "$@"
