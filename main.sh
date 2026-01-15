#!/data/data/com.termux/files/usr/bin/bash

pkg update -y
pkg install nginx cloudflared -y

mkdir -p ~/testx/site1 ~/testx/site2

cat > ~/testx/site1/index.html << 'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>الموقع الأول</title>
<style>
body{font-family:sans-serif;text-align:right;background:#f0f8ff;padding:20px;}
h1{color:#006400;}
input{margin:10px;padding:8px;width:80%;}
</style>
</head>
<body>
<h1>السلام عليكم ✌️</h1>
<p>أدخل شيء هنا (مطلوب)</p>
<form>
<input type="text" required placeholder="اكتب هنا...">
<input type="text" required placeholder="شيء ثاني...">
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
body{font-family:sans-serif;text-align:right;background:#fffacd;padding:20px;}
h1{color:#8b008b;}
input{margin:10px;padding:8px;width:80%;}
</style>
</head>
<body>
<h1>هلا والله 🔥</h1>
<p>جرب الحقول دي (مطلوبة)</p>
<form>
<input type="text" required placeholder="اكتب أي شيء...">
<input type="text" required placeholder="مثال: السلام عليكم">
<button>اضغط</button>
</form>
</body>
</html>
EOF

# Start nginx on port 8080 (more reliable than 8000 in many cases)
pkill nginx 2>/dev/null
nginx

echo ""
echo "محلياً جرب:"
echo "http://localhost:8080/site1/index.html"
echo "http://localhost:8080/site2/index.html"
echo ""
echo "الآن انتظر الرابط العام من cloudflared..."
echo ""

cloudflared tunnel --url http://localhost:8080
