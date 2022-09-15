# apple 프로젝트 구현

다음 프로젝트 레이아웃을 기반으로 VPC 와 EC2 리소스를 정의하고 프로비저닝 하세요 
```
.
├── resources
│   ├── bastion
│   │   └── env
│   └── vpc
│       └── env
└── README.md
```

## 요구 사항 
- AWS 리소스의 이름은 여러 프로젝트 및 복잡한 고객 환경을 고려하여 일관된 리소스 이름과 태깅 속으로 관리 되어야 합니다.     
- 프로젝트 이름으로 관련된 모든 리소스를 식별 할 수 있어야 합니다.
- Environment 속성으로 Stack 환경(dev, prd) 을 구분할 수 있어야 합니다.  
- Team 과 Owner 를 식별할 수 있어야 합니다.

### VPC
- AWS VPC 를 구성하며 DHCP 및 DNS 서비스를 할 수 있어야 합니다.
- VPC CIDR 블럭은 넉넉하게 65535 이하로 구성이 가능해야 합니다.
- 서비스를 위한 컴퓨팅 자원은 외부 접속으로부터 안전하게 보호되어야 합니다.
- 가용성을 위해 AZ 을 2개 이상 구성 하여야 합니다.
- 인터넷 사용자가 서비스를 제공 받을 수 있어야 합니다.

### EC2
- AMI 는 ubuntu-20.04 기본 이미지 배포판으로 아키텍처는 x86_64 여야 합니다. 
- 인스턴스 타입은 t3.micro 및 t3.small 로만 구성을 할 수 있습니다.
- 인터넷을 통한 접근이 가능 해야 하며, 운영자의 접근이 가능하도록 운영자의 아이피와 SSH 포트만 허용합니다.
- 볼륨 타입은 gp3 이며 10 GB 볼륨을 사용 합니다. 
- Bastion EC2 는 필요에 따라 생성 및 제거 할 수 있으며, EC2 가 다시 생성되더라도 관리자는 고정된 IP 주소로 Bastion 에 접속이 가능해야 합니다.
- Bastion EC2 가 제거 되더라도 VPC 에 영향을 주어선 안됩니다. 
- keypair 는 apple-keypair 로 사전에 등록되어 있어야 합니다.

## AWS 리소스 참고
- [AWS 리소스](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [EC2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [SecurityGroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [KeyPair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair)
- [Elastic IP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
