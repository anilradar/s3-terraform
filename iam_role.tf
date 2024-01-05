resource "aws_iam_role" "my_test_iam_role" {
  name = "test_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "test_role"
  }
}

resource "aws_iam_policy" "my_test_iam_policy" {
  name        = "test_policy"
  description = "test iam policy for test bucket"
  policy      = jsonencode({
  Version    = "2012-10-17"
  
  Statement = [
      {
        Action   = ["s3:ListBucket"]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.s3_test_bucket.arn]
      },
      {
        Action   = ["s3:GetObject", "s3:PutObject"]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.s3_test_bucket.arn}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test_policy_attachment" {
  role       = aws_iam_role.my_test_iam_role.name
  policy_arn = aws_iam_policy.my_test_iam_policy.arn
}
