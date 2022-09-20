# Terraform State 소개

Terraform 기본 명령어와 프로비저닝 흐름을 이해 합니다. 

<br>

## Terraform 명령어

<br>

### terraform 버전 확인
terraform 버전을 확인 합니다. 참고로 terraform 은 하위 호환성을 지켜주지 않으므로 버전 정의는 아주 중요합니다.  
```shell
terraform -version
```

### terraform --help
```shell
terraform --help

Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Experimental support for module integration testing
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.****
```

### terraform 주요 명령어

- terraform plan: 작성된 코드를 통해 REAL 인프라가 어떻게 적용 될 것인지 미리 계획을 보여 줍니다. 또한 작성된 코드의 오류가 없는지도 확인 합니다. 

```shell
terraform plan 
```

<br>

- terraform apply: 명령을 통해 작성된 Code 를 REAL 인프라에 적용 합니다. 

```shell
terraform apply  
```

<br>

- terraform destroy: 명령을 통해 현재 Code 에 대응하여 REAL 인프라에 구성된 모든 리소스를 제거 합니다.

```shell
terraform destroy  
```

<br>
<br>

## Terraform 상태 관리 
terraform 프로비저닝 흐름은 다음과 같습니다. 

![](../images/img_16.png)


### terraform code
Provider, Resource, Data Source, Output, Variable 을 통해 코드를 작성 합니다.

### terraform.tfstate
plan / apply 를 통해 코드가 REAL 인프라에 적용된 결과 상태를 저장 합니다.

### Real Infrastructure
AWS, AZure, GCP 와 같은 클라우드에 네트워크, 컴퓨팅 리소스, 소프트웨어 서비스가 구성된 가상의 데이터 센터 입니다. 


<br>

## tfstate 로컬 관리
프로젝트의 Workspace 기준으로 REAL 인프라를 구성하고 여기에 대응하는 tfstate 상태 파일을 로컬 환경(PC)에서 관리 합니다. 
공동 작업을 위해선 terraform code(*.tf) 뿐만 아니라 현재 REAL Infra 에 대응하는 최신의 terraform.tfstate 파일을 공유하여야 합니다.   
```shell
Workspace
├── templates
│   └── MFAPolicy.json
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf
```

<br>

### tfstate 분할 관리
stack 의 의존성을 제거하고 

- 로컬 관리
- 분할 관리
- 리모트 관리
