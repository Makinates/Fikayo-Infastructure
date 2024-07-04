# resource "aws_iam_role" "developers"{
#     name = "Developers"

#     assume_role_policy = jsondecode({
#         version = "2012-10-17"
#         Statement = [{
#             Action = "sts"
#         }]
#     })
# }