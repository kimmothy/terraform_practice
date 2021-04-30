variable "countindex" {
    type = number
    default = 21
}

output "sample" {
    value = join("",[substr("000", 0, 1),tostring(var.countindex)])
}

output "formattest" {
    value = "vpc-chan-sample-${format("%.3d", var.countindex)}"
}