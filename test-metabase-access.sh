#!/bin/bash
# Test Metabase access through Cloudflare tunnel

echo "🧪 Testing Metabase Access..."
echo ""

echo "1️⃣  Testing local access:"
if curl -s --max-time 5 http://localhost:3001/api/health >/dev/null 2>&1; then
    echo "✅ Local access: http://localhost:3001 - OK"
else
    echo "❌ Local access: http://localhost:3001 - FAILED"
fi

echo ""
echo "2️⃣  Testing public access:"
if curl -s --max-time 10 https://metabase.dictatorialsuite.com/api/health >/dev/null 2>&1; then
    echo "✅ Public access: https://metabase.dictatorialsuite.com - OK"
else
    echo "❌ Public access: https://metabase.dictatorialsuite.com - FAILED"
    echo "   (Make sure hostname is added to tunnel configuration)"
fi

echo ""
echo "3️⃣  Testing DNS resolution:"
nslookup metabase.dictatorialsuite.com | grep -A2 "Non-authoritative answer"

echo ""
echo "4️⃣  Checking local Metabase status:"
if lsof -i :3001 >/dev/null 2>&1; then
    echo "✅ Metabase running on port 3001"
else
    echo "❌ Metabase NOT running on port 3001"
    echo "   Start with: ./metabase-config.sh"
fi

echo ""
echo "5️⃣  Checking tunnel status:"
if pgrep -f cloudflared >/dev/null; then
    echo "✅ Cloudflare tunnel is running"
else
    echo "❌ Cloudflare tunnel is NOT running"
    echo "   Start with: ./start-cloudflare-tunnel.sh"
fi

