resource "aws_secretsmanager_secret" "my_secret" {
  name = "MySecret"  # Replace with your secret name
}

resource "aws_secretsmanager_secret_version" "my_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_secret.id
  secret_string = jsonencode({
    username = "my_username",
    password = "my_password"
    # Add more key-value pairs as needed
  })
}

output "secret_value" {
  value = aws_secretsmanager_secret_version.my_secret_version.secret_string
}