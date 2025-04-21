from flask import Flask, jsonify, request
import os

app = Flask(__name__)

SERVICE_DIR = "/var/run/services"

@app.route('/')
def home():
    return """
    <h1>VPS Control Panel</h1>
    <button onclick="fetch('/api/restart/openvpn').then(r => r.json()).then(alert)">Restart OpenVPN</button>
    <button onclick="fetch('/api/restart/v2ray').then(r => r.json()).then(alert)">Restart V2Ray</button>
    <button onclick="fetch('/api/status/openvpn').then(r => r.json()).then(alert)">Check OpenVPN Status</button>
    """

@app.route('/api/restart/<service>', methods=['GET'])
def restart_service(service):
    os.system(f"systemctl restart {service}")
    return jsonify({"message": f"{service} restarted successfully."})

@app.route('/api/status/<service>', methods=['GET'])
def service_status(service):
    status = os.system(f"systemctl status {service}")
    return jsonify({"status": "running" if status == 0 else "stopped"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)