### Pré-requisitos:

1. **WordPress** e **MySQL** devem rodar no mesmo container.
2. O blog deve ser acessível na porta **8080** do host.
3. O container deve garantir persistência dos dados, armazenando-os localmente.
4. O ambiente deve ser configurado com **apenas um Dockerfile**, sem utilizar o `docker-compose`.
5. Deve ser possível iniciar o ambiente com um simples comando `docker build` e `docker run`.

Passos para Construir e Executar

1. Construir a Imagem Docker:

No terminal, navegue até o diretório que contém o Dockerfile e start.sh.

Execute:

`docker build -t meu_wordpress_mysql_ubuntu .`

2. Executar o Contêiner:

Execute o contêiner mapeando a porta 80 do contêiner para a porta 8080 do host:

`docker run -d -p 8080:80 --name meu_blog_ubuntu meu_wordpress_mysql_ubuntu`

Isso deve configurar o ambiente com MySQL e WordPress rodando no mesmo contêiner, acessível na porta 8080 do host.

Vamos ver isso em ação? 🚀✨