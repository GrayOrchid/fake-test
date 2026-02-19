FROM python:3.10-slim

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libsodium-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем requirements.txt
COPY requirements.txt .

# Обновляем pip и ставим зависимости
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Копируем код
COPY server.py .
COPY config.json .

# Создаем директорию для конфига
RUN mkdir -p /etc/shadowsocks

EXPOSE 10000

CMD ["python", "server.py"]