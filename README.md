# br.dev.ardc.iac

This repository is dedicated to Infrastructure as Code (IaC) using Terraform for managing an Azure Subscription and its resources.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You will need to have Terraform installed on your machine. Here's how to do it on Windows, Linux, and MacOS:

#### Terraform - Windows

1. Download the Terraform zip file from the [Terraform downloads page](https://www.terraform.io/downloads.html).
2. Extract the contents of the zip file to a location of your choice, e.g., `C:\terraform`.
3. Add the path where you extracted the Terraform binary to your system's PATH environment variable.

#### Terraform - Linux

1. Download the Terraform zip file from the [Terraform downloads page](https://www.terraform.io/downloads.html).
2. Extract the contents of the zip file with `unzip`, e.g., `unzip terraform_0.12.0_linux_amd64.zip`.
3. Move the Terraform binary to a location on your PATH, e.g., `sudo mv terraform /usr/local/bin/`.

#### Terraform - MacOS

1. Download the Terraform zip file from the [Terraform downloads page](https://www.terraform.io/downloads.html).
2. Extract the contents of the zip file with `unzip`, e.g., `unzip terraform_0.12.0_darwin_amd64.zip`.
3. Move the Terraform binary to a location on your PATH, e.g., `sudo mv terraform /usr/local/bin/`.

### Azure CLI

To use Azure CLI, follow these steps:

1. Install Azure CLI by following the instructions on the [Azure CLI documentation](https://docs.microsoft.com/cli/azure/install-azure-cli).
2. Open a terminal or command prompt.
3. Run the `az login` command to sign in to your Azure account. Follow the prompts to complete the login process.

Once you have logged in using Azure CLI, you can manage your Azure resources using the command-line interface.

### Local Development

Run `terraform init` after you are done logging into Azure to have terraform scaffold the state locally.

1. After changing files run `terraform fmt` to format files
2. Use `terraform plan` to dry-run and see what changes would be applied
3. Finally, if everything looks fine, run `terraform apply` and review the changes before typing `yes` for changes to be applied in Azure.
