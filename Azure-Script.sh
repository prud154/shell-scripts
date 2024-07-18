#!/bin/bash
echo "Running the script now..!!"
 
echo "Creating Azure Resource Group"
az group create -l eastus -n AZUREB8


echo "Creating Azure Virtual Network"
az network vnet create -g AZUREB8 -n AZUREB8-vNET1 --address-prefix 10.1.0.0/16 \
--subnet-name AZUREB8-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus

az network vnet create -g AZUREB8 -n AZUREB8-vNET2 --address-prefix 10.10.0.0/16 \
--subnet-name AZUREB8-Subnet-1 --subnet-prefix 10.10.1.0/24 -l eastus
 
az network vnet create -g AZUREB8 -n AZUREB8-WEST-vNET1 --address-prefix 10.2.0.0/16 \
--subnet-name AZUREB8-WEST-Subnet-1 --subnet-prefix 10.2.1.0/24 -l westus
 
echo "Creating Azure Subnets"
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET1 -n AZUREB8-Subnet-2 \
--address-prefixes 10.1.2.0/24
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET1 -n AZUREB8-Subnet-3 \
--address-prefixes 10.1.3.0/24
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET2 -n AZUREB8-Subnet-2 \
--address-prefixes 10.10.2.0/24
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET2 -n AZUREB8-Subnet-3 \
--address-prefixes 10.10.3.0/24
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-WEST-vNET1 -n AZUREB8-WEST-Subnet-2 \
--address-prefixes 10.2.2.0/24
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-WEST-vNET1 -n AZUREB8-WEST-Subnet-3 \
--address-prefixes 10.2.3.0/24
 
echo "Creating Azure NSG & Rules"
az network nsg create -g AZUREB8 -n AZUREB8_NSG1
az network nsg rule create -g AZUREB8 --nsg-name AZUREB8_NSG1 -n AZUREB8_NSG1_RULE1 --priority 100 \
--source-address-prefixes '*' --source-port-ranges '*'     --destination-address-prefixes '*' \
--destination-port-ranges '*' --access Allow     --protocol Tcp --description "Allowing All Traffic For Now"

az network nsg create -g AZUREB8 -n AZUREB8_WEST_NSG1 --location westus
az network nsg rule create -g AZUREB8 --nsg-name AZUREB8_WEST_NSG1 -n AZUREB8_NSG1_RULE1 --priority 100 \
--source-address-prefixes '*' --source-port-ranges '*'     --destination-address-prefixes '*' \
--destination-port-ranges '*' --access Allow     --protocol Tcp --description "Allowing All Traffic For Now"
 
 
echo "Creating Azure Availibility Set"
az vm availability-set create --name EAST-AVSET1 -g AZUREB8 --location eastus \
--platform-fault-domain-count 3 --platform-update-domain-count 5

az vm availability-set create --name EAST-AVSET2 -g AZUREB8 --location eastus \
--platform-fault-domain-count 3 --platform-update-domain-count 5

az vm availability-set create --name WEST-AVSET1 -g AZUREB8 --location westus \
--platform-fault-domain-count 3 --platform-update-domain-count 5

az vm create --resource-group AZUREB8 --name AZUREB8TestVM1 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B2s \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1
 
az vm create --resource-group AZUREB8 --name AZUREB8TestVM2 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-2 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1

az vm create --resource-group AZUREB8 --name AZUREB8TestVM3 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-3 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1

az vm create --resource-group AZUREB8 --name AZUREB8TestVM4 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-3 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--nsg AZUREB8_NSG1
 
az vm create --resource-group AZUREB8 --name AZUREB8TestVM2 --image UbuntuLTS --vnet-name AZUREB8-vNET2 \
--subnet AZUREB8-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1
=================================================================================
WEST US VMS:
az vm create --resource-group AZUREB8 --name AZUREB8WestVM1 --image UbuntuLTS --vnet-name AZUREB8-WEST-vNET1 \
--subnet AZUREB8-WEST-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set WEST-AVSET1 --nsg AZUREB8_WEST_NSG1 --location westus

az vm create --resource-group AZUREB8 --name AZUREB8WestVM2 --image UbuntuLTS --vnet-name AZUREB8-WEST-vNET1 \
--subnet AZUREB8-WEST-Subnet-2 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set WEST-AVSET1 --nsg AZUREB8_WEST_NSG1 --location westus

az vm create --resource-group AZUREB8 --name AZUREB8WestVM3 --image UbuntuLTS --vnet-name AZUREB8-WEST-vNET1 \
--subnet AZUREB8-WEST-Subnet-3 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set WEST-AVSET1 --nsg AZUREB8_WEST_NSG1 --location westus
=================================================================================
 
urn="MicrosoftWindowsServer:WindowsServer:2016-Datacenter-smalldisk:14393.3085.1907121547"
az vm create --resource-group AZUREB8 --name WINVM8GB --image $urn --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username adminsree --admin-password "India@123456" --size Standard_B2ms \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1
 
#Creating vNET Peering with HUBRG
VNet1Id=$(az network vnet show --resource-group HUBRG --name HUBRG-vNET1 --query id --out tsv)
VNet2Id=$(az network vnet show --resource-group AZUREB8 --name AZUREB8-vNET1 --query id --out tsv)
az network vnet peering create -g HUBRG -n HUB-to-AZUREB8 --vnet-name HUBRG-vNET1 --remote-vnet $VNet2Id --allow-vnet-access
az network vnet peering create -g AZUREB8 -n AZUREB8-to-HUB --vnet-name AZUREB8-vNET1 --remote-vnet $VNet1Id --allow-vnet-access
 

------------------FOR LOAD BALANCERS-------------------------------

az vm create --resource-group AZUREB8 --name AZUREB8EastVM1 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--nsg AZUREB8_NSG1 --zone 1
 
 
az vm create --resource-group AZUREB8 --name AZUREB8EastVM2 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-2 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--nsg AZUREB8_NSG1 --zone 2


az vm create --resource-group AZUREB8 --name AZUREB8WestVM1 --image UbuntuLTS --vnet-name AZUREB8-WEST-vNET1 \
--subnet AZUREB8-WEST-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--nsg None --location westus
 
 
az vm create --resource-group AZUREB8 --name AZUREB8WestVM2 --image UbuntuLTS --vnet-name AZUREB8-WEST-vNET1 \
--subnet AZUREB8-Subnet-2 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--nsg None --location westus

--------------------------FOR VNET Peering Machines----------------------------------------------------
az vm create --resource-group AZUREB8 --name AZUREB8TestVM1 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1

az vm create --resource-group AZUREB8 --name AZUREB8TestVM2 --image UbuntuLTS --vnet-name AZUREB8-vNET2 \
--subnet AZUREB8-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set EAST-AVSET2 --nsg AZUREB8_NSG1


az vm create --resource-group AZUREB8 --name AZUREB8TestVM3 --image UbuntuLTS --vnet-name AZUREB8-WEST-vNET1 \
--subnet AZUREB8-WEST-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set WEST-AVSET1 --nsg AZUREB8_WEST_NSG1