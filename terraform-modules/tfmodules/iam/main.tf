resource "aws_iam_user" "user1" {
    name = "tf-user-1"
  
}

resource "aws_iam_group" "tf-group-1" {
    name = "tf-group-1"
  
}

resource "aws_iam_user_group_membership" "group-member" {
    user = aws_iam_user.user1.name
    groups = [aws_iam_group.tf-group-1.name]

}