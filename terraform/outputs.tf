output "web_public_ip" {
  description = "Public IP of the web server - open http://<this IP> in a browser"
  value       = aws_instance.web.public_ip
}

output "web_private_ip" {
  description = "Private IP of the web server"
  value       = aws_instance.web.private_ip
}

output "db_private_ip" {
  description = "Private IP of the MongoDB server (no public IP)"
  value       = aws_instance.db.private_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "ssh_web" {
  description = "SSH into the web server"
  value       = "ssh -i ${var.private_key_path} ubuntu@${aws_instance.web.public_ip}"
}

output "ssh_db_via_bastion" {
  description = "SSH into the DB server through the web server"
  value       = "ssh -i ${var.private_key_path} -J ubuntu@${aws_instance.web.public_ip} ubuntu@${aws_instance.db.private_ip}"
}

output "app_url" {
  value = "http://${aws_instance.web.public_ip}"
}
