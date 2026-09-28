FROM node:22-bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl git jq tmux \
 && rm -rf /var/lib/apt/lists/*

# Static ttyd binary from the official multi-arch image.
COPY --from=tsl0922/ttyd:1.7.7 /usr/bin/ttyd /usr/local/bin/ttyd

RUN npm install -g @anthropic-ai/claude-code @metabase/cli \
 && npm cache clean --force

COPY init.sh /usr/local/bin/init.sh

RUN mkdir -p /workspace && chown node:node /workspace
USER node
WORKDIR /workspace

RUN npx -y skills add metabase/agent-skills --skill metabase-cli --agent claude-code --global --copy --yes

RUN echo '{"hasCompletedOnboarding": true, "projects": {"/workspace": {"hasTrustDialogAccepted": true}}}' > /home/node/.claude.json

COPY --chown=node:node tmux.conf /home/node/.tmux.conf

# UTF-8 locale; without it tmux draws non-ASCII characters as "_".
ENV LANG=C.UTF-8 \
    MB_URL=http://metabase:3000 \
    MB_CLI_DISABLE_KEYRING=1 \
    DISABLE_AUTOUPDATER=1 \
    CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

EXPOSE 7681
ENTRYPOINT ["/usr/local/bin/init.sh"]
# tmux keeps the session alive across browser refreshes; -A reattaches to it.
CMD ["ttyd", "--writable", "--port", "7681", "tmux", "new-session", "-A", "-s", "claude"]
