/* Setup our aws provider */
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_default_region}"
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
