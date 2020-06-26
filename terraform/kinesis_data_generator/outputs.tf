output "kinesis_data_generator_url" {
  value = aws_cloudformation_stack.this.outputs["KinesisDataGeneratorUrl"]
}
output "username" {
  value = local.username
}
output "password" {
  value = local.password
}
