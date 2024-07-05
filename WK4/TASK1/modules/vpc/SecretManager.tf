resource "aws_secretsmanager_secret" "my_database_secret" {
  name = "databaseCredentials"  # Replace with your secret name
}

resource "aws_secretsmanager_secret_version" "my_database_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_secret.id
  secret_string = jsonencode({
    username = "my_username",
    password = "my_password"
    # Add more key-value pairs as needed
  })
}

resource "aws_secretsmanager_secret" "my_Api_secret" {
  name = "apiCredentials"  # Replace with your secret name
}

resource "aws_secretsmanager_secret_version" "my_Api_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_Api_secret.id
  secret_string = jsonencode({
    username = "my_username11",
    password = "my_password11"
    # Add more key-value pairs as needed
  })
}


# output "secret_value" {
#   value = aws_secretsmanager_secret_version.my_secret_version.secret_string
# }