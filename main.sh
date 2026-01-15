#!/data/data/com.termux/files/usr/bin/bash

# هذا السكريبت لإعداد استضافة موقعين في تيرمكس باستخدام Nginx و Cloudflared
# مرحبا يا ولد! This script sets up two websites in Termux with Nginx and Cloudflared tunnel.
# It supports Arabic text. Run this in Termux.

echo "مرحبا! Updating packages..."
pkg update -y && pkg upgrade -y

echo "تثبيت البرامج اللازمة... Installing necessary packages..."
pkg install nginx cloudflared -y

# إنشاء مجلدات المواقع - Create site directories
mkdir -p ~/site1 ~/site2

# إنشاء صفحة HTML للموقع الأول مع حقول إدخال مطلوبة - Create HTML for site1
cat << EOF > ~/site1/index.html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>الموقع الأول - مرحبا</title>
</head>
<body>
    <h1>مرحبا يا ولد! Hala ya wld</h1>
    <p>أدخل شيئاً في الحقول التالية (مطلوب):</p>
    <form>
        <input type="text" required placeholder="أدخل نصاً هنا">
        <input type="text" required placeholder="أدخل نصاً آخر هنا">
        <button type="submit">إرسال</button>
    </form>
</body>
</html>
EOF

# إنشاء صفحة HTML للموقع الثاني - Create HTML for site2
cat << EOF > ~/site2/index.html
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>الموقع الثاني - مرحبا</title>
</head>
<body>
    <h1>هلا يا ولد! Marhaba ya wld</h1>
    <p>أدخل شيئاً في الحقول التالية (مطلوب):</p>
    <form>
        <input type="text" required placeholder="أدخل نصاً هنا">
        <input type="text" required placeholder="أدخل نصاً آخر هنا">
        <button type="submit">إرسال</button>
    </form>
</body>
</html>
EOF

# إعداد Nginx لاستضافة الموقعين - Set up Nginx virtual hosts
mkdir -p $PREFIX/etc/nginx/sites-available $PREFIX/etc/nginx/sites-enabled

# ملف تكوين الموقع الأول - Site1 config
cat << EOF > $PREFIX/etc/nginx/sites-available/site1
server {
    listen 8080;
    server_name site1.example.com;

    root $HOME/site1;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# ملف تكوين الموقع الثاني - Site2 config
cat << EOF > $PREFIX/etc/nginx/sites-available/site2
server {
    listen 8080;
    server_name site2.example.com;

    root $HOME/site2;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# ربط الملفات - Link to enabled
ln -s $PREFIX/etc/nginx/sites-available/site1 $PREFIX/etc/nginx/sites-enabled/site1
ln -s $PREFIX/etc/nginx/sites-available/site2 $PREFIX/etc/nginx/sites-enabled/site2

# تعديل nginx.conf ليشمل المواقع - Modify nginx.conf to include sites
NGINX_CONF="$PREFIX/etc/nginx/nginx.conf"
sed -i '/http {/a \    include '"$PREFIX"'/etc/nginx/sites-enabled/*;' $NGINX_CONF

# إعادة تشغيل Nginx - Restart Nginx
nginx -s reload || nginx

echo "Nginx مُعد! Sites ready at http://localhost:8080 (but will use domains via tunnel)."

# إعداد Cloudflared - Set up Cloudflared
echo "تسجيل الدخول إلى Cloudflare... Logging into Cloudflare..."
cloudflared tunnel login

echo "إنشاء نفق... Creating tunnel..."
cloudflared tunnel create my-termux-tunnel

# إنشاء ملف التكوين - Create config.yml
mkdir -p ~/.cloudflared
cat << EOF > ~/.cloudflared/config.yml
tunnel: my-termux-tunnel
credentials-file: /data/data/com.termux/files/home/.cloudflared/my-termux-tunnel.json

ingress:
  - hostname: site1.example.com
    service: http://localhost:8080
  - hostname: site2.example.com
    service: http://localhost:8080
  - service: http_status:404
EOF

# توجيه DNS - Route DNS (replace with your domains)
echo "الآن، قم بتوجيه DNS لنطاقاتك في لوحة Cloudflare."
cloudflared tunnel route dns my-termux-tunnel site1.example.com
cloudflared tunnel route dns my-termux-tunnel site2.example.com

# تشغيل النفق - Run the tunnel
echo "تشغيل النفق... Running tunnel..."
nohup cloudflared tunnel run my-termux-tunnel > tunnel.log 2>&1 &

echo "تم! الآن، استبدل site1.example.com و site2.example.com بنطاقاتك الخاصة في config.yml وأعد تشغيل النفق."
echo "للتشغيل في الخلفية، استخدم nohup nginx & و nohup cloudflared tunnel run my-termux-tunnel &"
echo "تحقق من السجلات: cat tunnel.log"
echo "لدعم الخط العربي في تيرمكس، تأكد من أن الخط يدعم العربية (يمكن تثبيت خطوط إضافية عبر pkg install fonts-arabic أو مشابه)."
