# Azure Infrastructure as Code with Bicep

This repository contains **Infrastructure as Code (IaC)** definitions for deploying Azure resources using **Bicep**.

Bicep is a domain-specific language (DSL) for deploying Azure resources declaratively. It simplifies authoring Azure Resource Manager (ARM) templates and provides better readability, modularization, and tooling support.

This project demonstrates how to deploy a **Resource Group** using a modular Bicep architecture.

---

# Project Structure

```
bicep-iac
│
├── main.bicep                 # Root deployment template
│
├── modules
│   └── resource-group.bicep   # Resource group module
│
└── params
    └── dev.bicepparam        # Environment parameter file
```

---

# Prerequisites

Before deploying the infrastructure, ensure the following tools are installed:

* Azure CLI
* Bicep CLI
* Azure Subscription

---

# Install Azure CLI

The Azure CLI is used to authenticate and deploy resources.

## Windows

Download and install Azure CLI:

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows

Or install via **PowerShell**:

```
winget install Microsoft.AzureCLI
```

## macOS

```
brew update
brew install azure-cli
```

## Linux

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verify installation:

```
az version
```

---

# Install Bicep

Bicep can be installed directly through Azure CLI.

```
az bicep install
```

Verify installation:

```
az bicep version
```

Upgrade Bicep if necessary:

```
az bicep upgrade
```

---

# Install VS Code Extension (Optional but Recommended)

For the best development experience install the **Bicep extension** in VS Code.

Search for:

```
Bicep
```

Published by Microsoft.

This provides:

* IntelliSense
* Syntax validation
* Linting
* Autocomplete

---

# Authenticate with Azure

Login to your Azure account:

```
az login
```

If you have multiple subscriptions:

```
az account set --subscription "<subscription-id>"
```

Verify current subscription:

```
az account show
```

---

# Deployment Steps

This project deploys resources at the **subscription scope**, because resource groups must be created at this level.

## Step 1: Navigate to the Project Folder

```
cd bicep-iac
```

## Step 2: Deploy the Infrastructure

Run the following command:

```
az deployment sub create \
  --location eastus \
  --parameters params/dev.bicepparam
```

Explanation:

| Parameter      | Description                                  |
| -------------- | -------------------------------------------- |
| `sub create`   | Deploy at subscription scope                 |
| `--location`   | Location for deployment metadata             |
| `--parameters` | Parameter file for environment configuration |

---

# Verify Deployment

After deployment completes, verify the resource group:

```
az group list --output table
```

You should see something similar to:

```
Name                     Location
-----------------------  ---------
rg-bicep-sample-dev      eastus
```

You can also verify in the **Azure Portal**.

---

# Parameter Files

The project uses **`.bicepparam` files** to manage environment configurations.

Example:

```
params/dev.bicepparam
```

Example contents:

```
using '../main.bicep'

param resourceGroupName = 'rg-bicep-sample-dev'
param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'vikash'
}
```

---

# Cleaning Up Resources

To delete the resource group:

```
az group delete --name rg-bicep-sample-dev --yes --no-wait
```

---

# Best Practices Used in This Repository

* Modular Bicep architecture
* Environment parameter files
* Reusable modules
* Tagging strategy
* Subscription-level deployment

---

# Additional Resources

* Azure Bicep Documentation
  https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/

* Azure CLI Documentation
  https://learn.microsoft.com/en-us/cli/azure/

---

# License

This project is licensed under the MIT License.
