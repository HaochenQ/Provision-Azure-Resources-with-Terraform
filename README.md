# Provision an Azure Web App in a Azure VNET

In this demo project, we will provision a Linux PHP web app and integrate this app with a Azure Virtaul Network using Terraform.

## Authentication

The authentication is achieved by using Azure Service Principal, an identity created for use with applications, hosted services, and automated tools to access Azure resources.

Export **ARM_CLIENT_ID**, **ARM_CLIENT_SECRET**, **ARM_TENANT_ID**, and **ARM_SUBSCRIPTION_ID** as environment variables.

## Store Terraform state in Azure Storage

We will use a pre-configured Azure storage to store remote Terraform state. Remmber to export **ARM_ACCESS_KEY** as an environment.

## Modularization

Customized App service module is created for reuse.
