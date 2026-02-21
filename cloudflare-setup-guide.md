# Cloudflare Tunnel Setup for Metabase

## Overview
This guide shows how to expose your local Metabase instance at `metabase.dictatorialsuite.com` using Cloudflare Tunnel.

## DNS Setup Required
1. Go to Cloudflare Dashboard for `dictatorialsuite.com`
2. Add DNS Record:
   - Type: `CNAME`
   - Name: `metabase`
   - Target: `549803db-7db8-482e-8f2f-7ced24f3cd07.cfargotunnel.com`
   - Proxy Status: 🟠 Proxied

## Files Created
- `~/.cloudflared/metabase-config.yml` - Tunnel configuration
- `start-cloudflare-tunnel.sh` - Tunnel startup script

## Usage
```bash
# Start Metabase
./metabase-config.sh &

# Start Cloudflare tunnel
./start-cloudflare-tunnel.sh
```

## Access URLs
- **Public:** https://metabase.dictatorialsuite.com
- **Local:** http://localhost:3001

## Services Exposed
- `metabase.dictatorialsuite.com` → `localhost:3001` (Metabase)
- `convertax.diktatorial.com` → `localhost:8000` (Existing Converta)

## Troubleshooting
- Ensure Metabase is running on port 3001 before starting tunnel
- DNS changes may take a few minutes to propagate
- Check tunnel status: `cloudflared tunnel info 549803db-7db8-482e-8f2f-7ced24f3cd07`

