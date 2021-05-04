variable subnet_count {
    type = number
    description = "number of subnets"
    default = 4
}

variable cidr_block {
    type = string
    description = "cidr block of main vnet"
    default = "192.168.0.0/16"
}