resource "aws_s3_bucket" "B1" {
  count  = 3
  bucket = local.variablebilu.data[count.index]
  tags = {
    Name       = local.variablebilu.name[count.index]
    Enviroment = local.variablebilu.team[count.index]
  }
}
# resource "aws_s3_bucket" "B2" {
#     bucket = "mybukybilu"

#     tags = {
#       Name = "bilu77928411"
#       Enviroment = "dev"
#     }
# }
# resource "aws_s3_bucket" "B3" {
#     bucket = "mybukybilu"
#     tags = {
#       Name = "bilu779284"
#       Enviroment = "deploy"
#     }
# }