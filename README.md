# Project Dev Palace

**This is a messy work-in-progress and the content of this repo is not well abstractized to be reused. It might contain hard-coded resource names.**

In the same way you might have different rooms in a palace for different purposes, the same way you could have different development environments for different use cases. The goal of this project is to serve as a proof-of-concept for having development environments as code using Docker, Windows Subsystem for Linux 2 (WSL2) and Windows Terminal.

In this repo, multiple development environments are defined as Dockerfiles, for different purposes. Each of them is in a separate git submodule and repo and they are configured to be built and pushed to Azure Container Registry. The Docker images depend on each other and ACR provides automatic builds when a base image changes using build tasks.

ACR registry, build tasks and first runs can be configured using provided ARM template (`setup.json`) and using the following Powershell command:

```powershell
New-AzResourceGroupDeployment -Name 'project-dev-palace-test' `
 -ResourceGroupName alexchiri `
 -TemplateFile .\setup.json `
 -acrTaskGitUser $GIT_USER `
 -acrTaskGitToken $GIT_PAT `
 -wslUserPass $WSL_USER_PASS
```

The heavy lifting of updating the development environments locally is done by [dragon](https://github.com/alexchiri/dragon) a CLI built in Rust, which is currently a work-in-progress.

## Submodule related commands

```bash
git submodule add --name azure https://github.com/alexchiri/project-dev-palace-azure azure
git submodule add --name basic https://github.com/alexchiri/project-dev-palace-basic basic
git submodule add --name docker https://github.com/alexchiri/project-dev-palace-docker docker
git submodule add --name k8s https://github.com/alexchiri/project-dev-palace-k8s k8s
git submodule add --name k8s-with-docker https://github.com/alexchiri/project-dev-palace-k8s-with-docker k8s-with-docker
git submodule add --name learn.alexchiri.com https://github.com/alexchiri/project-dev-palace-learn.alexchiri.com learn.alexchiri.com

git config --global diff.submodule log
git config status.submodulesummary 1
```

## Obsolete

Create an Azure Principal to be able to login:

```bash
az ad sp create-for-rbac --name UploadImagesToContainer
```

Delete an Azure Principal:

```bash
az ad sp delete --id
```