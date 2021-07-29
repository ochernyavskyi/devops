output "bt_env_dns_name" {
  description = "Show U dns name of beanstalk"
  value = aws_elastic_beanstalk_environment.docker-env.cname
}