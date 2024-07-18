echo "Running the script now..!!"
 
echo "Creating Azure Resource Group"
az group create --location eastus -n AZUREB8
 
echo "Creating Azure Virtual Network"
az network vnet create -g AZUREB8 -n AZUREB8-vNET1 --address-prefix 10.1.0.0/16 \
--subnet-name AZUREB8-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus

echo "Creating Azure Subnets"
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET1 -n AZUREB8-Subnet-2 \
--address-prefixes 10.1.2.0/24
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET1 -n AZUREB8-Subnet-3 \
--address-prefixes 10.1.3.0/24

echo "Creating Azure NSG & Rules"
az network nsg create -g AZUREB8 -n AZUREB8_NSG1
az network nsg rule create -g AZUREB8 --nsg-name AZUREB8_NSG1 -n AZUREB8_NSG1_RULE1 --priority 100 \
--source-address-prefixes '*' --source-port-ranges '*'     --destination-address-prefixes '*' \
--destination-port-ranges '*' --access Allow     --protocol Tcp --description "Allowing All Traffic For Now"

echo "Creating Azure Availibility Set"
az vm availability-set create --name EAST-AVSET1 -g AZUREB8 --location eastus \
--platform-fault-domain-count 3 --platform-update-domain-count 5

az vm create --resource-group AZUREB8 --name AZUREB8TestVM1 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1

urn="MicrosoftWindowsServer:WindowsServer:2016-Datacenter-smalldisk:14393.3085.1907121547"
az vm create --resource-group AZUREB8 --name WINVM --image $urn --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username adminsree --admin-password "India@123456" --size Standard_B2ms \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1

az vm create --resource-group AZUREB8 --name AZUREB8TestVM1 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ls \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1 --custom-data cloud-init.txt

az vm create --resource-group AZUREB8 --name AZUREB8TestVM2 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-2 --admin-username testuser --admin-password "India@123456" --size Standard_B1s \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1 --custom-data cloud-init.txt

az vm create --resource-group AZUREB8 --name AZUREB8TestVM3 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-3 --admin-username testuser --admin-password "India@123456" --size Standard_B1s \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1 --custom-data cloud-init.txt

az vm create --resource-group AZUREB8 --name AZUREB8TestVM4 --image UbuntuLTS --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-3 --admin-username testuser --admin-password "India@123456" --size Standard_B1s \
 --nsg AZUREB8_NSG1 --custom-data cloud-init.txt

#Standard_B2ms=8GB Standard_B2s=4GB Standard_B1s=1GB Standard_B1ls=.5GB
urn="MicrosoftWindowsServer:WindowsServer:2016-Datacenter-smalldisk:14393.3085.1907121547"
az vm create --resource-group AZUREB8 --name WINVM8GB --image $urn --vnet-name AZUREB8-vNET1 \
--subnet AZUREB8-Subnet-1 --admin-username adminsree --admin-password "India@123456" --size Standard_B2ms \
--availability-set EAST-AVSET1 --nsg AZUREB8_NSG1

ls

https://adamtheautomator.com/azure-devops-variables-complete-guide/
https://stefanstranger.github.io/2019/06/26/PassingVariablesfromStagetoStage/