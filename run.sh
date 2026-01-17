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
pip install flask --quiet

### Run App ###
pkill -f app.py 2>/dev/null
clear

echo -e "${G}ﻕﺎﻌﻣ ﺎﻳ ﺮﺒﺻﺍ${R}"
echo -e "${C}ﺮﺒﺻﺍ ﺐﺼﻌﺗ ﻻ ﻞﻤﺤﻳ${R}"
echo ""

echo -e "${C}ﺮﺒﺻﺍ ﺐﺼﻌﺗ ﻻ ﻞﻤﺤﻳ 2${R}"
echo ""

cloudflared tunnel --url http://localhost:8080 2>&1 | \
grep --line-buffered -o 'https://[-a-z0-9]*\.trycloudflare\.com' | \
while read url; do
    echo ""
    echo -e "${G}══════════════════════════════════════${R}"
    echo -e "${G}🌍 ﺡﺪﻗ ﺖﺤﺗ ﻊﻗﻮﻤﻟﺍ:${R}"
    echo -e "${C}$url${R}"
    echo -e "${G}══════════════════════════════════════${R}"
    echo ""
done &


python "$APP_DIR/app.py"

