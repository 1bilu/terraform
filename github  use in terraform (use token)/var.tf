variable "repo" {
    type = string
    default = "terraform_repository"    /*        note:   we can  override the default variable value   on the fly   
                                                   use terraform plan -var="repo" ="newname"            */
  
}