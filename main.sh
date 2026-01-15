#!/data/data/com.termux/files/usr/bin/bash

# ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﺤﻤﺪ ✌️

echo "ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﺤﻤﺪ! ﺔﻄﺴﻗ ﻢﻴﻫﺮﻓ ﻦﻳﺪﻟﺍ ﻦﻴﻤﻴﻠﻋ"
pkg update -y && pkg upgrade -y

echo "ﺕﺎﺠﻬﻨﻟﺍ ﻞﻴﻜﺸﺗ ﻭ cloudflared ﻭ nginx ﺕﺎﺒﻠﻄﻟﺍ ﻢﻴﻫﺮﻓ"
pkg install nginx cloudflared -y

mkdir -p ~/site1 ~/site2

cat << 'EOF' > ~/site1/index.html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>١ ﻊﻴﻄﻘﻤﻟﺍ - ﺎﺒﺤﺮﻣ</title>
<style>body{font-family:sans-serif;text-align:right;background:#f0f8ff;padding:20px;}h1{color:#006400;}</style>
</head>
<body>
<h1>ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ✌️ Hala ya wld!</h1>
<p>ﻰﻠﻋ ﻞﻴﻠﻗ ﺎﻣ ﻞﺧﺩﺃ ↓</p>
<form>
<input type="text" required placeholder="...ﻪﻨﻫ ﻲﺑﺮﻋ ﻭﺃ ﺰﻴﻨﺠﻟﺍ ﺐﺘﻛﺍ">
<input type="text" required placeholder="...ﺮﺧﺁ ﺀﻲﺷ">
<button>→ ﻞﺴﺭﺇ</button>
</form>
</body>
</html>
EOF

cat << 'EOF' > ~/site2/index.html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>٢ ﻊﻴﻄﻘﻤﻟﺍ - ﻪﻟﺎﻫ</title>
<style>body{font-family:sans-serif;text-align:right;background:#fffacd;padding:20px;}h1{color:#8b008b;}</style>
</head>
<body>
<h1>!ﻩﻼﻫ ﻪﻟﻮﻟﺍ 🔥 Marhaba ya wld</h1>
<p>ﺔﻴﻠﻤﻋ ﻰﻠﻋ ﻞﻴﻠﻗ ﺎﻣ ﺐﺟﺮﺟ</p>
<form>
<input type="text" required placeholder="...ﺔﺟﺎﺣ ﻲﺋﺎﻴﺷ">
<input type="text" required placeholder="ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ">
<button>→ ﻩﻨﻫ ﻂﻐﺿﺍ</button>
</form>
</body>
</html>
EOF

echo "8080 ﺮﺘﻧﻮﻴﺑ ﻰﻠﻋ nginx ﻞﻴﻐﺸﺗ ﻢﺘﻫ"
nginx

echo "ﻞﻴﻐﺸﺘﻟﺍ ﻞﻴﻜﺸﺗ ﻢﺘﻫ:"
echo "http://localhost:8080/site1/index.html"
echo "http://localhost:8080/site2/index.html"

echo "ﻞﻴﻜﺸﺘﻟﺍ ﻞﻴﻜﺸﺗ ﻢﺘﻫ... Cloudflared Quick Tunnel ﻞﻴﻜﺸﺗ"
echo "ﺮﻴﻏ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﺮﻴﻏ ﻞﻜﺸﻳ"
echo "ﻲﻟﺎﻌﻟﺍ ﻞﻴﻜﺸﺘﻟﺍ ﻞﻴﻜﺸﺗ ﻢﺘﻫ..."

cloudflared tunnel --url http://localhost:8080

echo "ﻢﺘﻫ! ﻰﻠﻋ ﻞﻴﻜﺸﺘﻟﺍ ﺮﻴﻏ ﻞﻜﺸﻳ ﻰﻠﻋ ﻞﻴﻜﺸﺘﻟﺍ ﺮﻴﻏ ﻞﻜﺸﻳ"
echo "ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ"
echo "ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ✌️"
