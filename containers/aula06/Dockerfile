# Use a imagem base do Ubuntu
FROM ubuntu:latest

# Atualize o sistema e instale pacotes necessários
RUN apt-get update && apt-get install -y \
    apache2 \
    mysql-server \
    php \
    libapache2-mod-php \
    php-mysql \
    wget \
    unzip

# Baixe e instale o WordPress
RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mv wordpress/* /var/www/html/ \
    && chown -R www-data:www-data /var/www/html/ \
    && rm -rf wordpress latest.zip

# Copie o script de inicialização
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exponha a porta 80
EXPOSE 80

# Comando de entrada
ENTRYPOINT ["/start.sh"]
