resource "harbor_project" "vessel" {
  name = "vessel"
}

resource "harbor_user" "captain" {
  username  = "kube"
  password  = "Password12345!"
  full_name = "Captain Kube"
  email     = "captain.kube@kubernetes.com"
}

resource "harbor_project_member_user" "kube" {
  project_id = harbor_project.vessel.id
  user_name  = harbor_user.captain.username
  role       = "developer"
}

resource "harbor_robot_account" "vessel" {
  name        = harbor_project.vessel.name
  description = "Robot account used to push and pull images from harbor"
  project_id  = harbor_project.vessel.id
  actions     = ["push", "pull"]
}

locals {
  robot-prefix = "robot$"
}

resource "vault_generic_secret" "vessel" {
  path = "secret/service_accounts/harbor/${harbor_robot_account.vessel.name}"
  data_json = jsonencode(
    {
      "username" = "${local.robot-prefix}${harbor_robot_account.vessel.name}",
      "password" = "${harbor_robot_account.vessel.token}"
    }
  )
}