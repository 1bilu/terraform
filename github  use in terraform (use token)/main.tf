resource "github_repository" "terra_repo" {
    name = var.repo
    description = "create first repo by use terraform "

    visibility = "public" 

  
}






# terraform plan -var="repo"="github-repo" -out="bilu.tf"   (use for to stire output )