from flask import Flask, request, render_template
from datetime import datetime

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

    print("="*50)
    print(now, ip)
    print(t1)
    print(t2)
    print("="*50)

    return "تم الإرسال ✓"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
