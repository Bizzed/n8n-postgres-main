# ─────────────────────────────────────────────────────────────────────────────
# n8n-postgres-main
#
# Thin wrapper on the official n8n image. Source is NOT rebuilt here.
# Pin the version explicitly and bump it deliberately when upgrading n8n.
#
# To upgrade: change N8N_VERSION below, rebuild, and push.
# Verify the tag exists first: https://hub.docker.com/r/n8nio/n8n/tags
# ─────────────────────────────────────────────────────────────────────────────
ARG N8N_VERSION=2.17.0
FROM n8nio/n8n:${N8N_VERSION}

# ── Custom / community nodes ──────────────────────────────────────────────────
# Add your node packages here. Uncomment and repeat as needed.
# Always pin versions for reproducible builds.
#
# USER root
# RUN cd /usr/local/lib/node_modules && \
#     npm install n8n-nodes-yourpackage@1.0.0
# USER node

# ── Config ────────────────────────────────────────────────────────────────────
# Non-secret defaults are baked into the image via production.json.
# Secrets and host-specific values are injected at runtime via Railway env vars.
COPY --chown=node:node config/ /home/node/bizzed-config/
ENV N8N_CONFIG_FILES=/home/node/bizzed-config/production.json

EXPOSE 5678
