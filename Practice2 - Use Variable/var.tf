variable location{
    type = map(string)
    default = {
        "long" = "koreacentral"
        "short" = "kc"
    }
}

variable vmsku{
    type = string
}

variable vmcount{
    type = number
}

variable localips{
    type = list
}

variable password{
    type = string
}
