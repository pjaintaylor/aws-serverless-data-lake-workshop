module "kinesis_data_generator" {
  source = "./kinesis_data_generator"
}

module "lab2" {
  source = "./module1/lab2"
}
