from flask import Flask
app = Flask(__name__)

@app.route("/")
def alive():
    return "✅ I'm alive and ready for SSH!", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)
