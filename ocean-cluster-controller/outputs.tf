output "instance_profile" {
  value = data.aws_iam_instance_profiles.profile.arns
}