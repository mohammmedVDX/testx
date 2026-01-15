#!/data/data/com.termux/files/usr/bin/bash

pkg update -y >/dev/null 2>&1
pkg install nginx -y >/dev/null 2>&1

mkdir -p ~/testx/site1 ~/testx/site2

cat > ~/testx/site1/index.html << 'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>الموقع الأول</title>
<style>
  body{font-family:sans-serif; text-align:right; background:#f0f8ff; padding:30px; direction:rtl;}
  h1{color:#006400; font-size:2.2em;}
  input{margin:15px 0; padding:12px; width:90%; font-size:1.1em;}
  button{padding:12px 30px; font-size:1.2em; background:#006400; color:white; border:none;}
</style>
</head>
<body>
<h1>السلام عليكم ✌️ يا محمد</h1>
<p>اكتب اللي تبيه في الحقول (مطلوب):</p>
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
  body{font-family:sans-serif; text-align:right; background:#fffacd; padding:30px; direction:rtl;}
  h1{color:#8b008b; font-size:2.2em;}
  input{margin:15px 0; padding:12px; width:90%; font-size:1.1em;}
  button{padding:12px 30px; font-size:1.2em; background:#8b008b; color:white; border:none;}
</style>
</head>
<body>
<h1>هلا والله 🔥 يا ولد</h1>
<p>الحقول دي كمان مطلوبة:</p>
<form>
  <input type="text" required placeholder="اكتب أي حاجة...">
  <input type="text" required placeholder="مثلاً: السلام عليكم">
  <button>اضغط هنا</button>
</form>
</body>
</html>
EOF

pkill nginx 2>/dev/null
nginx

clear

echo "ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﺤﻤﺪ ✌️"
echo ""
echo "ﻲﻧﺎﺜﻟﺍ ﻂﺑﺍﺮﻟﺍ ﻪﺘﺤﺗﻭ ﺖﺤﺗ ﺦﺴﻨﻠﻟ ﻪﻟﻮﻃﻣ ﻪﻄﻐﺿ ﻂﺑﺍﺮﻟﺍ اﺫﺎﻫ"
echo ""
echo "https://your-quick-link.trycloudflare.com/site1/index.html"
echo "https://your-quick-link.trycloudflare.com/site2/index.html"
echo ""
echo "ﺮﻴﻏ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ"
echo ""
