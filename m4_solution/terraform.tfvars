instance_type = "t3.micro"
vpc_network_info = {
  vpc_cidr = "10.0.0.0/16"
  public_subnets = {
    subnet1 = "10.0.0.0/24"
    subnet2 = "10.0.1.0/24"
  }
}
project = "burrito-barn"
tags = {
  BillingCode = "8675309"
  Owner       = "Ozzy Osbourne"
}
