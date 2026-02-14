output "instance_id" {
  description = "EC2 인스턴스 ID"
  value       = aws_instance.openclaw.id
}

output "public_ip" {
  description = "Elastic IP 주소"
  value       = aws_eip.openclaw.public_ip
}

output "public_dns" {
  description = "퍼블릭 DNS"
  value       = aws_eip.openclaw.public_dns
}

output "ssh_command" {
  description = "SSH 접속 명령어"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_eip.openclaw.public_ip}"
}
