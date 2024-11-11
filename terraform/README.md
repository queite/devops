# Arquitetura
![alt text](arquitetura.png)

Este projeto cria uma infraestrutura AWS usando o Terraform.

## Cloud Front
Exitem duas distribuições do cloudfront, uma com origin configurado para o S3 e outra para o load balancer da aplicação.

## Comandos básicos terraform
aws sts get-caller-identity<br>
terraform --help<br>
terraform init<br>
terraform fmt -check -diff -recursive<br>
terraform validate<br>
terraform plan<br>
terraform plan -out=plano.saida<br>
terraform show plano.saida<br>
terraform apply<br>
terraform destroy<br>

## Links de alguns recursos da documentação utilizados

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

https://developer.hashicorp.com/terraform/language/values/outputs

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
