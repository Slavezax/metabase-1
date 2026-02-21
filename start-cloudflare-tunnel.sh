#!/bin/bash
# Start Cloudflare Tunnel for Metabase

echo "🌐 Starting Cloudflare Tunnel for Metabase..."
echo ""
echo "📊 Services being exposed:"
echo "  - convertax.diktatorial.com    -> localhost:8000 (existing)"
echo "  - metabase.dictatorialsuite.com -> localhost:3001 (metabase)"
echo ""

# Make sure Metabase is running
echo "🔍 Checking if Metabase is running on port 3001..."
if ! lsof -i :3001 >/dev/null 2>&1; then
    echo "⚠️  Metabase is not running on port 3001!"
    echo "💡 Start Metabase first with: ./metabase-config.sh"
    exit 1
fi

echo "✅ Metabase is running on port 3001"
echo ""
echo "🚀 Starting Cloudflare tunnel..."
echo "   Access your Metabase at: https://metabase.dictatorialsuite.com"
echo ""

cloudflared tunnel --config ~/.cloudflared/metabase-config.yml run 549803db-7db8-482e-8f2f-7ced24f3cd07

