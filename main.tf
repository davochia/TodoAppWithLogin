terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  
  subscription_id = "fdc197e5-e589-473f-b7b2-12bd7cd2842a"
  client_id       = "44b62c5d-e321-49c7-8e0e-ae603f5aa64f"
  client_secret   = "L.NkzIw397_iN.YYdw8yQDAmFHOgiSjjda"
  tenant_id       = "b1732512-60e5-48fb-92e8-8d6902ac1349"
  
  features {}
}

resource "azurerm_resource_group" "devops" {
  name     = "devops-2"
  location = "West Europe"
}

resource "azurerm_virtual_network" "devops" {
  name                = "network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.devops.location
  resource_group_name = azurerm_resource_group.devops.name
}

resource "azurerm_subnet" "devops" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.devops.name
  virtual_network_name = azurerm_virtual_network.devops.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "devops" {
  name                = "network-interface"
  location            = azurerm_resource_group.devops.location
  resource_group_name = azurerm_resource_group.devops.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devops.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { value = tls_private_key.example_ssh.private_key_pem }

resource "azurerm_linux_virtual_machine" "devops" {
  name                  = "virtual-machine"
  resource_group_name   = azurerm_resource_group.devops.name
  location              = azurerm_resource_group.devops.location
  network_interface_ids = [azurerm_network_interface.devops.id]
  size                  = "Standard_DS1_v2"
  
  
  
  os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  
  
  computer_name  = "virtual-machine"
  admin_username = "adminuser"
  disable_password_authentication = true
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.example_ssh.private_key_pem
  }
  
  #boot_diagnostics {
   #     storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    #}

    #tags = {
    #    environment = "Terraform Demo"
   # }
  
}


