# Terraform Basic

Provider, Resource, Variable, Output 을 이해하고 Terraform 을 기초를 이해 하도록 합니다.

Terraform이 인식하는 확장자는 HCL(Hashicorp Configuration Language) 언어로 작성된 *.tf 파일 입니다. Terraform은 파일 이름에 상관없이 디렉토리내의 모든 .tf
파이일을 프로비저닝 리소스를 정의하고 있다고 간주 합니다.  
또한 *.tfvars 는 테라폼 변수를 정의한 파일로 인식 합니다.


<br>

## Providers

AWS, GCP, AZure 와 같은 클라우드 환경에 리소스 및 서비스를 생성할 수 있도록 각각의 벤더가 제공하는 Open-API 를 통해 액세스하는 제공자 입니다. 이를 위해 CSP 벤더 + OpenSource
연합히 협력하여 프로바이더를 제공 합니다.

- AWS 클라우드를 액세스 하기위한 프로바이더 선언 예시

```hcl
provider "aws" {
  access_key = "<AWS_ACCESS_KEY>"
  secret_key = "<AWS_SECRET_KEY>"
  region     = "ap-northeast-2"
}
```

- GCP 클라우드를 액세스 하기위한 프로바이더 선언 예시

```hcl
provider "google" {
  project = "<MY-PROJECT-ID>"
  region  = "us-central1"
}
```

- AWS 및 GCP 를 모두 액세스 하는 멀티클라우드 프로비저닝을 위한 프로바이더 선언 예시

```hcl
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.22.0"
    }
    google = {
      version = "~> 4.0.0"
    }
  }
}

provider "aws" {
  access_key = "<AWS_ACCESS_KEY>"
  secret_key = "<AWS_SECRET_KEY>"
  region     = "ap-northeast-2"
}

provider "google" {
  project = "<MY-PROJECT-ID>"
  region  = "us-central1"
  zone    = "us-central1-c"
}
```

<br>

## Resources

리소스란 프로바이더가 제공해주는 코드(resource)로 정의하여 인스턴트를 생성/수정/삭제 가능한 대상의 단위입니다.  
예를 들어 AWS 프로바이더가 제공하는 aws_instance 리소스 타입은 Amazon EC2 가상 머신을 코드(resource)로 선언하고 관리해주는 것이 가능 합니다.

![](../images/img_6.png)


<br>

## Variables

리소스가 참조하는 값으로 `var.` 참조자로 값을 참조 할 수 있습니다.  
![](../images/img_8.png)

### local 변수 및 활용

로컬 scope(범위)내에서만 유효한 값을 정의하여 참조 합니다. `local.` 참조자로 값을 참조 합니다.   
![](../images/img_7.png)

### 변수 타입 정의

- Terraform 변수 타입을 정의 합니다.

```
# string 타입
variable "name" {
  type        = string 
}

# number 타입 
variable "listen_port" {
  type        = number
}

# Boolean 타입 
variable "enabled_ipv6" {
  type        = bool
}

# List 컬렉션
variable "subnet_ids" {
  type        = list(string)  
}

# Map 컬렉션
variable "tags" {
  type        = map(string) 
}

```

### 변수 입력 방식

- terraform apply 를 통한 콘솔에서의 입력

![](../images/img_9.png)

- Terraform 변수 파일 정의
  **terraform.tfvars** 예약된 변수 파일 정의

```hcl
name         = "my-bastion"
listen_port  = 80
enabled_ipv6 = false
subnet_ids   = ["sn-aslkf23123"]
tags         = {
  Team      = "BTC"
  CreatedBy = "Terraform"
}
```

- terraform apply 명령에서 -var-file 옵션을 통한 변수 파일 전달

```
terraform plan -var-file=./dev.tfvars
```

<br>


## Outputs
Terraform 을 통해 코드로 정의된 리소스 / 모듈이 프로비저닝 되어 인스턴스가 생성되면 해당 인스턴스가 가지는 속성을 output 으로 값을 보관할 수 있습니다.  
뿐만 아니라 사용자가 정의한 변수 역시 output 으로 값을 보관할 수 있습니다.    
이렇게 보관된 정보는 프로비저닝 결과를 확인 하거나 프로비저닝 과정에서 의존성이 있는 리소스에 전달 할 수 있습니다.

**outputs.tf** 파일 정의 예시 
```hcl
output "id" {
  description = "EC2 인스턴스 아이디 입니다."
  value       = aws_instance.ec2.id
}

output "arn" {
  description = "EC2 인스턴스 ARN 입니다."
  value       = aws_instance.ec2.arn
}

output "instance_state" {
  description = "EC2 인스턴스 상태 입니다. `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped` 의 값들 중 하나입니다."
  value       = aws_instance.ec2.instance_state
}

output "private_ip" {
  description = "EC2 인스턴스에 할당된 private_ip 입니다."
  value       = try(aws_instance.ec2.private_ip, "")
}

output "public_ip" {
  description = "EC2 인스턴스에 할당된 public_ip 입니다."
  value       = try(aws_instance.ec2.public_ip, "")
}

output "tags_all" {
  description = "EC2 인스턴스의 태그 및 속성 값들 입니다."
  value       = try(aws_instance.this.tags_all, {})
}

```

