# Vamos usar o Ubuntu 16.04 como S.O. base
FROM ubuntu:16.04

# Mantenedor do Container
MAINTAINER Jose Valente <jmlcv@yahoo.com>

RUN apt-get update && apt-get install -y \
    apache2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Criar diretorio de 'lock' e ajustar o dono
RUN mkdir -pv /run/lock/apache2 && chown www-data /run/lock/apache2

# Conforme melhores praticas, vamos criar um volume para areas atualizaveis pelo usuário
VOLUME ["/var/www/html"]

# Setar as variaveis para execucao do Apache
ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOCK_DIR=/run/lock/apache2
ENV APACHE_PID_FILE=/var/run/apache2.pid APACHE_LOG_DIR=/var/log/apache2

# Executar o Apache - APENAS uma diretiva CMD
CMD ["/usr/sbin/apache2","-D","FOREGROUND"]

# Expor a porta 80 para o mundo externo
EXPOSE 80
