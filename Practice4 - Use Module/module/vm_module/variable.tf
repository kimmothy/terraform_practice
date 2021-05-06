variable subnet_id {
    type = string
    description = "subnet id"
}

variable location {
    type = map(string)
    description = "location"
    default = {
        "long" = "koreacentral"
        "short" = "kc"
    }
}

variable rgname {
    type = string
    description = "rgname"
}