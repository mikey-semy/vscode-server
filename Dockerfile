# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && \
    apt-get install -y curl sudo && \
    apt-get clean

# Устанавливаем переменную VERSION
ARG VERSION=4.93.1

# Загружаем и устанавливаем code-server
RUN apt-get update && apt-get install -y wget && \
    wget https://github.com/coder/code-server/releases/download/v${VERSION}/code-server_${VERSION}_amd64.deb && \
    sudo dpkg -i code-server_${VERSION}_amd64.deb && \
    rm code-server_${VERSION}_amd64.deb

# Создаем пользователя для запуска code-server
RUN useradd -m code-server-user

# Устанавливаем рабочую директорию
WORKDIR /home/code-server-user

# Открываем порт 8080
EXPOSE 8080

# Устанавливаем переменные окружения для пользователя и пароля
ENV USERNAME=code-server-user

# Запускаем code-server с использованием переменных окружения
USER code-server-user
CMD ["sh", "-c", "echo \"password: $PASSWORD\" > /home/code-server-user/.config/code-server/config.yaml && code-server --host 0.0.0.0 --port 8080 --auth password"]
