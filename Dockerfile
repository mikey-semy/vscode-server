# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости: python3 и библиотеки разработки PostgreSQL
RUN apt-get update && \
    apt-get install -y curl sudo python3 python3-pip && \
    apt-get install -y libpq-dev && \
    apt-get clean

# Устанавливаем GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update && \
    apt-get install -y gh && \
    apt-get clean

# Устанавливаем Node.js и npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Устанавливаем yarn
RUN npm install --global yarn

# Устанавливаем переменную VERSION
ARG VERSION=4.93.1  # Замените на нужную версию

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

# Запускаем code-server с использованием переменных окружения
USER code-server-user
CMD ["sh", "-c", "code-server --host 0.0.0.0 --port 8080 --auth password"]
