variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "EC2 키 페어 이름"
  type        = string
}

variable "my_ip" {
  description = "SSH 및 Gateway 접속을 허용할 내 공인 IP (예: 1.2.3.4)"
  type        = string
}
