#!/data/data/com.termux/files/usr/bin/bash

### CONFIG ###
REPO_BASE="https://raw.githubusercontent.com/mohammmedVDX/testx/main"
APP_DIR="$HOME/testx"
VERSION_FILE="$APP_DIR/version.txt"
REMOTE_VERSION_URL="$REPO_BASE/version.txt"

### COLORS ###
G="\033[92m"
C="\033[96m"
R="\033[0m"

mkdir -p "$APP_DIR"

### Auto Update by VERSION ###
LOCAL_VERSION="0.0.0"
[ -f "$VERSION_FILE" ] && LOCAL_VERSION=$(cat "$VERSION_FILE")

REMOTE_VERSION=$(curl -fs "$REMOTE_VERSION_URL")

if [ -n "$REMOTE_VERSION" ] && [ "$REMOTE_VERSION" != "$LOCAL_VERSION" ]; then
    echo -e "${C}Updating to version $REMOTE_VERSION...${R}"

    curl -fs "$REPO_BASE/run.sh" -o "$APP_DIR/run.sh"
    curl -fs "$REPO_BASE/app.py" -o "$APP_DIR/app.py"
    curl -fs "$REPO_BASE/version.txt" -o "$APP_DIR/version.txt"

    mkdir -p "$APP_DIR/templates"
    curl -fs "$REPO_BASE/templates/index.html" -o "$APP_DIR/templates/index.html"

    chmod +x "$APP_DIR/run.sh"
    exec "$APP_DIR/run.sh"
fi

### Dependencies ###
pkg update -y -qq >/dev/null
pkg install python cloudflared -y -qq >/dev/null
pip install flask requests 


### Run App (FIXED & STABLE) ###

pkill -f app.py 2>/dev/null
cd "$APP_DIR"

# 1) Start Flask FIRST
python app.py > flask.log 2>&1 &
FLASK_PID=$!

# 2) Wait for server
sleep 2

# 3) Start Cloudflared (safe mode)
echo -e "${C}Starting Cloudflare Tunnel...${R}"
echo ""

cloudflared tunnel \
  --no-autoupdate \
  --protocol http2 \
  --url http://127.0.0.1:8080 \
  --logfile cloudflared.log \
  --loglevel info &

# 4) Wait for tunnel
sleep 3

# 5) Get URL
URL=$(grep -o 'https://[-a-z0-9]*\.trycloudflare\.com' cloudflared.log | head -n 1)

if [ -n "$URL" ]; then
    echo ""
    echo -e "${G}══════════════════════════════════════${R}"
    echo -e "${G}🌍 YOUR WEBSITE IS LIVE:${R}"
    echo -e "${C}$URL${R}"
    echo -e "${G}📋 Copied to clipboard${R}"
    echo -e "${G}══════════════════════════════════════${R}"
    echo ""

    echo -n "$URL" | termux-clipboard-set
else
    echo -e "\033[91mFailed to get Cloudflare URL ❌\033[0m"
    echo "Check cloudflared.log"
fi

# 6) Keep running
wait $FLASK_PID
