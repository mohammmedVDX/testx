#!/data/data/com.termux/files/usr/bin/bash

# Auto-update check (silent)
REPO_URL="https://raw.githubusercontent.com/mohammmedVDX/testx/refs/heads/main/main.sh"
CURRENT="$1"
curl -s "$REPO_URL" > ~/.tmp.sh 2>/dev/null
if [ -s ~/.tmp.sh ] && ! cmp -s "$CURRENT" ~/.tmp.sh; then
    mv ~/.tmp.sh "$CURRENT"
    chmod +x "$CURRENT"
    exec "$CURRENT"
fi
rm -f ~/.tmp.sh >/dev/null 2>&1

pkg update -y -qq >/dev/null 2>&1
pkg install python cloudflared -y -qq >/dev/null 2>&1
pip install flask --quiet >/dev/null 2>&1

mkdir -p ~/testx

cat > ~/testx/app.py << 'EOF'
from flask import Flask, request
from datetime import datetime
import os

app = Flask(__name__, static_folder='.', static_url_path='')

LOG_FILE = "submissions.txt"

@app.route('/')
def index():
    return '''
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<title>تجربة</title>
<style>
  body {font-family:system-ui; background:#f0f4f8; padding:2rem; text-align:right; max-width:700px; margin:auto;}
  h1 {color:#1a5c38;}
  .box {margin:1.2rem 0;}
  input {width:100%; padding:0.9rem; font-size:1.2rem; border-radius:8px; border:1px solid #ccc;}
  button {background:#1a5c38; color:white; border:none; padding:0.9rem 2rem; font-size:1.2rem; border-radius:8px; cursor:pointer;}
</style>
</head>
<body>
<h1>السلام عليكم ✌️</h1>
<p>اكتب اللي تبي في الحقول:</p>

<form method="POST" action="/submit">
  <div class="box">
    <input type="text" name="text1" placeholder="الحقل الأول..." required>
  </div>
  <div class="box">
    <input type="text" name="text2" placeholder="الحقل الثاني..." required>
  </div>
  <button type="submit">إرسال</button>
</form>
</body>
</html>
    '''

@app.route('/submit', methods=['POST'])
def submit():
    text1 = request.form.get('text1', '').strip()
    text2 = request.form.get('text2', '').strip()
    
    if not text1 and not text2:
        return "ما كتبت شيء!", 400
    
    ip = request.remote_addr
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    line = f"[{now}] IP: {ip}  →  \"{text1}\"  |  \"{text2}\""
    
    with open(LOG_FILE, 'a', encoding='utf-8') as f:
        f.write(line + '\n')
    
    print("\033[92m" + "═" * 60)
    print(f"\033[96m{now}\033[0m   \033[93mIP: {ip}\033[0m")
    print(f"\033[92m{text1}\033[0m")
    print(f"\033[92m{text2}\033[0m")
    print("\033[92m" + "═" * 60 + "\033[0m\n")
    
    return '''
    <!DOCTYPE html>
    <html lang="ar" dir="rtl">
    <head><meta charset="UTF-8"><title>تم!</title></head>
    <body style="font-family:system-ui;text-align:center;padding:4rem;">
    <h1 style="color:#1a5c38;">تم الإرسال ✓</h1>
    <p>شكراً لك!</p>
    <a href="/">العودة</a>
    </body>
    </html>
    '''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)
EOF

pkill python 2>/dev/null
sleep 0.6

clear

echo ""
echo "ﻢﻜﻴﻠﻋ مﻼﺴﻟﺍ ﻢﺤﻤﺪ ✌️"
echo ""
echo "ﻲﻧﺎﺜﻟﺍ ﻂﺑﺍﺮﻟﺍ ﻪﺘﺤﺗﻭ ﺖﺤﺗ ﺦﺴﻨﻠﻟ ﻪﻟﻮﻃﻣ ﻪﻄﻐﺿ ﻂﺑﺍﺮﻟﺍ اﺫﺎﻫ"
echo ""
echo "   https://xxxxxxxxxxxx.trycloudflare.com/"
echo ""
echo "ﺮﻴﻏ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ ﻞﻜﺸﻳ"
echo ""

# Tunnel stays running in background, script doesn't stop
cloudflared tunnel --url http://localhost:8080 >/dev/null 2>&1 &

# Keep script alive so user can see submissions live
tail -f ~/testx/submissions.txt 2>/dev/null || true
