output "kinesis_data_generator_url" {
  value = aws_cloudformation_stack.this.outputs["KinesisDataGeneratorUrl"]
}
output "username" {
  value = random_string.this.result
}
output "password" {
  value = random_password.this.result
}
