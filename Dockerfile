# Используем базовый образ Ubuntu
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Устанавливаем необходимые зависимости: python3.10 и библиотеки разработки PostgreSQL
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl sudo python3.11 python3.11-dev python3-venv python3-pip libpq-dev bash && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

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

# Создаем пользователя для запуска code-server с bash как оболочкой
RUN useradd -m -s /bin/bash code-server-user

# Устанавливаем рабочую директорию
WORKDIR /home/code-server-user

# Устанавливаем Python 3.13 как версию по умолчанию
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

# Открываем порты:
EXPOSE 8000
EXPOSE 8080
EXPOSE 5173

# Запускаем code-server с использованием переменных окружения
USER code-server-user
CMD ["bash", "-c", "code-server --host 0.0.0.0 --port 8080 --auth password"]
