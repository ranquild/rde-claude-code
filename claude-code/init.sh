#!/usr/bin/env bash
# Logs the mb CLI in to Metabase with the API key created from config.yml.
set -euo pipefail

: "${MB_URL:?}" "${MB_API_KEY:?}"

echo "Waiting for Metabase at $MB_URL..."
until curl -fsS --noproxy '*' "$MB_URL/api/health" >/dev/null 2>&1; do sleep 2; done

# The key exists once Metabase has loaded config.yml; retry until it does.
for attempt in $(seq 30); do
  if out=$(mb auth login --url "$MB_URL" 2>&1); then
    echo "mb CLI logged in to $MB_URL."
    exec "$@"
  fi
  sleep 2
done
echo "mb auth login failed: $out" >&2
exit 1
