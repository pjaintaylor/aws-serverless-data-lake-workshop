output "kinesis_data_generator_url" {
  value = "https://awslabs.github.io/amazon-kinesis-data-generator/web/producer.html?${jsondecode(data.aws_lambda_invocation.this.result)["Querystring"]}"
}
output "username" {
  value = random_string.this.result
}
output "password" {
  value = random_password.this.result
}
