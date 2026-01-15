#!/data/data/com.termux/files/usr/bin/bash

echo "ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﺤﻤﺪ! ﺮﻴﺼﻗ ﻭ ﺔﻠﻴﺴﻫ ﺔﻄﺴﻗ ﻢﻴﻫﺮﻓ"

pkg update -y
pkg install nginx cloudflared -y

mkdir -p ~/testx/site1 ~/testx/site2

# موقع 1 - عربي طبيعي صحيح
cat << 'EOF' > ~/testx/site1/index.html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>الموقع الأول</title>
<style>
body {font-family:sans-serif; text-align:right; background:#f0f8ff; padding:25px;}
h1 {color:#006400;}
input {margin:12px; padding:10px; width:85%;}
</style>
</head>
<body>
<h1>السلام عليكم ✌️ مرحبا يا ولد</h1>
<p>أدخل شيء في الحقول (مطلوب):</p>
<form>
<input type="text" required placeholder="اكتب هنا...">
<input type="text" required placeholder="شيء آخر...">
<button type="submit">إرسال</button>
</form>
</body>
</html>
EOF

# موقع 2 - عربي طبيعي صحيح
cat << 'EOF' > ~/testx/site2/index.html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>الموقع الثاني</title>
<style>
body {font-family:sans-serif; text-align:right; background:#fffacd; padding:25px;}
h1 {color:#8b008b;}
input {margin:12px; padding:10px; width:85%;}
</style>
</head>
<body>
<h1>هلا والله 🔥 مرحبا يا محمد</h1>
<p>جرب الحقول التالية (مطلوب):</p>
<form>
<input type="text" required placeholder="اكتب أي شيء...">
<input type="text" required placeholder="مثال: السلام عليكم">
<button type="submit">اضغط هنا</button>
</form>
</body>
</html>
EOF

echo "nginx ﻞﻴﻐﺸﺗ ﻢﺘﻫ 8000 ﺮﺘﻧﻮﻴﺑ ﻰﻠﻋ"
nginx

echo "ﺮﻴﻏ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ"
echo "http://localhost:8000/site1/index.html"
echo "http://localhost:8000/site2/index.html"

echo "ﻲﻧﺎﺜﻟﺍ ﻂﺑﺍﺮﻟﺍ ﻪﺘﺤﺗﻭ ﺖﺤﺗ ﺦﺴﻨﻠﻟ ﻪﻟﻮﻃﻣ ﻪﻄﻐﺿ ﻂﺑﺍﺮﻟﺍ اﺫﺎﻫ"
echo "ﻚﻟﺫ ﻂﺑﺍﺮﻟﺍ ﻰﻠﻋ ﻂﻐﺿﺍ ﻭ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ"

cloudflared tunnel --url http://localhost:8000
