resource "random_password" "this" {
  length = 16
  special = true
}

resource "random_string" "this" {
  length = 16
}
