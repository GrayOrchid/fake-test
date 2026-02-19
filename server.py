import os
import json
import subprocess
import signal
import sys
import time

def create_config():
    """Создает конфиг для shadowsocks"""
    password = os.environ.get('SS_PASSWORD', 'desertFire11')
    port = int(os.environ.get('PORT', 10000))
    
    config = {
        "server": "0.0.0.0",
        "server_port": port,
        "password": password,
        "method": "aes-256-gcm",  # Современный метод шифрования
        "fast_open": false,
        "timeout": 300,
        "workers": 1
    }
    
    with open('/etc/shadowsocks.json', 'w') as f:
        json.dump(config, f)
    
    return config

def run_server():
    """Запускает shadowsocks сервер"""
    # Создаем конфиг
    config = create_config()
    
    # В Python 3 используем ssserver из пакета shadowsocks-fixed
    cmd = ['ssserver', '-c', '/etc/shadowsocks.json']
    
    # Запускаем процесс
    process = subprocess.Popen(cmd)
    
    # Обработка сигналов остановки
    def handle_signal(signum, frame):
        process.terminate()
        sys.exit(0)
    
    signal.signal(signal.SIGTERM, handle_signal)
    signal.signal(signal.SIGINT, handle_signal)
    
    # Держим процесс в живых
    process.wait()

if __name__ == '__main__':
    run_server()