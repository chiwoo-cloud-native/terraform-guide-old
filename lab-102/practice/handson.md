## Q1. 프로바이더를 정의 하세요.
- Terraform 버전을 1.2.1 에서만 동작하도록 정의 하세요.
- AWS 프로바이더를 추가 하고, 버전은 "4.22.0" 과 크거나 같아야 합니다. 
- terra 프로파일을 사용하며, '서울' 리전을 액세스 하여야 합니다.



## Q2. Bastion-EC2를 위한 `aws_instance` 리소스를 정의 하세요  
- 인스턴스 갯수는 1개 입니다. 
- 이름은 my-bastion 입니다.
- instance_type 은 t2.micro 입니다.
- ami 이미지 아이디는 "ami-08f869ae259b6bc98" 입니다.
- 태그 속성명으로 CreatedBy, Team, Owner 를 정의해야 하며, 적절한 값을 할당 하세요.
- 관리 콘솔을 통해 Default VPC 와 subnet 을 확인하여 원하는 subnet 에 EC2 를 배포(구성) 하세요.
- ebs 최적화는 비활성화 하세요.
- API 를 통한 종료방지 기능을 비활성화 하세요.

[terraform resource 참조](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)  

## Q3. 위에서 정의한 `aws_instance` 리소스 정의에서, 리소스 이름, 인스턴스 타입, ebs 최적화 옵션 및 api 종료 방지 기능 활성화 여부를 변수로 정의 하고, tfvars 파일을 통해 값을 전달 할 수 있도록 구현 하세요.  
ebs 최적화 옵션 및 api 종료 방지 기능 활성화 여부에 대한 값은 변수로 정의하지 않더라도 비활성화로 구성되도록 Terraform variables.tf 변수 파일을 정의 하시기 바랍니다.
