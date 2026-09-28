# Metabase + Claude Code

1. Get a Claude Code token:
   ```sh
   claude setup-token
   ```
2. Copy the env file, paste the token into `CLAUDE_CODE_OAUTH_TOKEN`, and a
   Metabase Pro/Enterprise token into `MB_PREMIUM_EMBEDDING_TOKEN`:
   ```sh
   cp .env.example .env
   ```
   Optionally replace `MB_API_KEY` with your own: `echo "mb_$(openssl rand -base64 32)"`.
3. Start the stack:
   ```sh
   docker compose up -d --build
   ```
4. Open http://127.0.0.1:3000 for Metabase (`admin@example.com` /
   `metasample123`), and http://127.0.0.1:7681 for Claude Code.

Claude Code runs in tmux: `Ctrl-b c` opens another Claude session, and you switch
by clicking the status bar or with `Ctrl-b 1`…`9`. Sessions survive a page refresh.

Stop with `docker compose down` (add `-v` to wipe Metabase and the workspace).
