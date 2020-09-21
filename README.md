![](https://images.microbadger.com/badges/version/jarylc/bittorrent-tracker.svg) ![](https://images.microbadger.com/badges/image/jarylc/bittorrent-tracker.svg) ![](https://img.shields.io/docker/stars/jarylc/bittorrent-tracker.svg) ![](https://img.shields.io/docker/pulls/jarylc/bittorrent-tracker.svg)

# Environment variables:
| Environment | Default value | Description
|---|---|---|
| PORT | 8000 | Port to host tracker |
| HTTP | 1 | Enable HTTP on '/announce' and '/scrape' endpoints |
| UDP | 1 | Enable UDP |
| WS | 1 | Enable WebSocket |
| STATS | 1 | Enable stats on '/stats' and '/stats.json' endpoints |
| INTERVAL | 600000 | Client announce interval (ms) |
| TRUST_PROXY | 0 | Trust 'x-forwarded-for' header from reverse proxy |
| QUIET | 1 | Show only errors |
| SILENT | 0 | Show no output at all (overrides QUIET) |

# Deploying
## Terminal
```bash
docker run -d \
    --name bittorrent-tracker \
    -e PORT=8000 \
    -e HTTP=1 \
    -e UDP=1 \
    -e WS=1 \
    -e STATS=1 \
    -e INTERVAL=600000 \
    -e TRUST_PROXY=0 \
    -e QUIET=1 \
    -e SILENT=0 \
    -p 8000:8000 \
    --restart unless-stopped \
    jarylc/bittorrent-tracker
```
## Docker-compose
```yml
bittorrent-tracker:
    image: jarylc/bittorrent-tracker
    ports:
        - "8000:8000"
    environment:
        - PORT=3000
        - HTTP=1
        - UDP=1
        - WS=1
        - STATS=1
        - INTERVAL=600000
        - TRUST_PROXY=0
        - QUIET=1
        - SILENT=0
    restart: unless-stopped
```
