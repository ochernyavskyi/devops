provider "aws" {
  region = var.region
}

resource "aws_elastic_beanstalk_application" "docker-app" {
  name        = "docker3"
}

resource "aws_elastic_beanstalk_environment" "docker-env" {
  name                = "Docker-env3"
  application         = aws_elastic_beanstalk_application.docker-app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.3 running Docker"
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
}
