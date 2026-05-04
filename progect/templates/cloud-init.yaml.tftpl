#cloud-config
package_update: true
package_upgrade: true

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg
  - lsb-release

write_files:
  - path: /opt/app/.env
    content: |
      DB_HOST=${db_host}
      DB_PORT=3306
      DB_USER=${db_user}
      DB_PASSWORD=${db_password}
      DB_NAME=${db_name}
  - path: /opt/app/docker-compose.yml
    content: |
      services:
        web:
          image: cr.yandex/${registry_id}/web-app:latest
          container_name: web-app
          restart: unless-stopped
          ports:
            - "80:80"
          env_file:
            - .env
          healthcheck:
            test: ["CMD", "python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:80/')"]
            interval: 30s
            timeout: 10s
            retries: 3

runcmd:
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  - echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  - sudo apt-get update
  - sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  - sudo usermod -aG docker ubuntu
  - cd /opt/app && sudo docker compose up -d