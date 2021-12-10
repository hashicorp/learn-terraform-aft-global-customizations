variable "trusted_entities" {
  description = "Trusted entities allowed to assume the itv-root role. Defaults to ITV root account "
  type        = list(string)
  default     = ["arn:aws:iam::655028521085:root"]
}
