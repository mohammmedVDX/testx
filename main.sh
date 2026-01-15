#!/data/data/com.termux/files/usr/bin/bash

# ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﺤﻤﺪ ✌️ - ﺔﺨﺴﻨﻟﺍ ﺔﻟﺎﻌﻓ ﺔﻠﻴﺴﻫ

REPO_URL="https://raw.githubusercontent.com/mohammmedVDX/testx/refs/heads/main/main.sh"
CURRENT_SCRIPT="$0"

# ﺔﺨﺴﻨﻟﺍ ﺪﻳﺪﺟ ﻞﻴﻤﺤﺗ ﻭ ﺔﻧﺭﺎﻤﻗ
echo "ﺔﺨﺴﻨﻟﺍ ﺪﻳﺪﺠﻟﺍ ﺮﻈﻨﻳ..." >/dev/null 2>&1
curl -s -o /data/data/com.termux/files/home/.temp_update.sh "$REPO_URL"

if [ -f /data/data/com.termux/files/home/.temp_update.sh ]; then
    if ! cmp -s "$CURRENT_SCRIPT" /data/data/com.termux/files/home/.temp_update.sh; then
        echo "ﺔﺨﺴﻨﻟﺍ ﺪﻳﺪﺟ ﺔﻟﻭﺪﻨﺗ ﻢﺘﻫ!" >/dev/null 2>&1
        mv /data/data/com.termux/files/home/.temp_update.sh "$CURRENT_SCRIPT"
        chmod +x "$CURRENT_SCRIPT"
        echo "ﺔﻟﺎﻌﻔﻟﺍ ﻂﺒﺿ ﻢﺘﻫ... ﻲﻨﺜﺑ ﺮﻈﺗ" >/dev/null 2>&1
        exec "$CURRENT_SCRIPT"
        exit 0
    else
        rm -f /data/data/com.termux/files/home/.temp_update.sh
    fi
fi

# ﺔﻄﺴﻗ ﺔﻠﻴﺴﻫ ﻭ ﺔﻠﻴﺴﻫ ﺔﻴﻨﻴﻄﺳﻟﺍ
pkg update -y -qq >/dev/null 2>&1
pkg install nginx cloudflared -y -qq >/dev/null 2>&1

mkdir -p ~/testx/{site1,site2}

cat > ~/testx/site1/index.html << 'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>الموقع الأول</title>
<style>
body{font-family:system-ui,sans-serif;text-align:right;background:#f8f9fa;padding:2rem;}
h1{color:#2e7d32;font-size:2.5rem;}
p{font-size:1.4rem;}
input,button{font-size:1.3rem;padding:1rem;margin:1rem 0;width:92%;box-sizing:border-box;}
button{background:#2e7d32;color:white;border:none;border-radius:10px;cursor:pointer;}
</style>
</head>
<body>
<h1>السلام عليكم ✌️ يا محمد</h1>
<p>الحقول مطلوبة:</p>
<form>
<input type="text" required placeholder="اكتب هنا...">
<input type="text" required placeholder="شيء ثاني حلو...">
<button>إرسال</button>
</form>
</body>
</html>
EOF

cat > ~/testx/site2/index.html << 'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>الموقع الثاني</title>
<style>
body{font-family:system-ui,sans-serif;text-align:right;background:#fffde7;padding:2rem;}
h1{color:#6a1b9a;font-size:2.5rem;}
p{font-size:1.4rem;}
input,button{font-size:1.3rem;padding:1rem;margin:1rem 0;width:92%;box-sizing:border-box;}
button{background:#6a1b9a;color:white;border:none;border-radius:10px;cursor:pointer;}
</style>
</head>
<body>
<h1>هلا والله 🔥 يا ولد</h1>
<p>جرب الحقول دي كمان:</p>
<form>
<input type="text" required placeholder="اكتب اللي تبي...">
<input type="text" required placeholder="مثال: السلام عليكم">
<button>اضغط هنا</button>
</form>
</body>
</html>
EOF

pkill nginx 2>/dev/null
sleep 0.5
nginx

clear

echo ""
echo "ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﺤﻤﺪ ✌️"
echo ""
echo "ﻲﻧﺎﺜﻟﺍ ﻂﺑﺍﺮﻟﺍ ﻪﺘﺤﺗﻭ ﺖﺤﺗ ﺦﺴﻨﻠﻟ ﻪﻟﻮﻃﻣ ﻪﻄﻐﺿ ﻂﺑﺍﺮﻟﺍ اﺫﺎﻫ"
echo ""
echo "   https://xxxxxxxxxxxx.trycloudflare.com/site1/index.html"
echo "   https://xxxxxxxxxxxx.trycloudflare.com/site2/index.html"
echo ""
echo "ﺮﻴﻏ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ"
echo ""

# النفق بدون أي رسائل مرئية (الرابط الحقيقي يطلع في الـ terminal تحت هالرسائل)
cloudflared tunnel --url http://localhost:8080 >/dev/null 2>&1 &
