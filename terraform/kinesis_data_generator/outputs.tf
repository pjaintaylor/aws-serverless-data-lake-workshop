output "kinesis_data_generator_url" {
  value = aws_cloudformation_stack.this.outputs["KinesisDataGeneratorUrl"]
}
output "username" {
  value = random_string.username.result
}
output "password" {
  value = random_string.password.result
}
