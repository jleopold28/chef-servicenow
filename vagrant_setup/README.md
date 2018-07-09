# Chef Fundamentals

Contains a Vagrantfile that will create a lab environment. This lab has 1 chef server and 1 node.

## Getting Started

Follow the Instructions below to create the lab environement.

### Prerequisites

1. Download the latest version of Vagrant (https://www.vagrantup.com/)
2. Download the latest version of VirtualBox (https://www.virtualbox.org/wiki/Downloads)
3. Download the vagrant_files.zip from Google Drive


### Starting the VMs

1. Create a folder to work out of
```
~$ mkdir ~/chef-fundamentals
```
2. Copy the vagrant_files.zip file into the chef-fundamentals folder
```
~$ cp vagrant_files.zip ~/chef-fundamentals
```
3. From the ~/chef-training directory, unzip the vagrant_files.zip file
```
~/chef-training$ unzip vagrant_files.zip
```
4. From the ~/chef-training directory, run vagrant up
```
~/chef-training$ vagrant up
```
5. You should now have Virtual Box running with the virtual machines required for the lab.

### Setting up the Chef Server

Select the Chef Server VM from Virtual Box.
Vagrant should already have downloaded the latest chef-server-core.rpm into the /home/vagrant dir.

1. Install the Chef Server RPM
```
sudo rpm -Uvh ~/chef-server-core-*.rpm
```
2. Start all services, Configure server
```
sudo chef-server-ctl reconfigure
```
3. Make certs directory to store pem files
```
mkdir /home/vagrant/certs
```
4. Create admin user
```
sudo chef-server-ctl user-create admin Admin User admin@admin.com password --filename /home/vagrant/certs/admin.pem
```
5. Create organization
```
sudo chef-server-ctl org-create cheflab "Chef Lab Org" --association_user admin --filename /home/vagrant/certs/cheflab-validator.pem
```
6. Install Chef Manage (Server GUI)
```
sudo chef-server-ctl install chef-manage
sudo chef-server-ctl reconfigure
sudo chef-manage-ctl reconfigure --accept-license
```

### Verify Chef Server

On your local machine, go to https://192.168.123.10
Verify that you can log in to the Chef Server with admin/password

### Setting up the workstation

On your local machine, perform the following

1. Download and install latest version of ChefDK (https://downloads.chef.io/chefdk)
2. Download the Starter kit from the Chef Server
3. Unzip the starter kit in the working directory where the Vagrant file was
```
cd ~/chef-fundamentals
cp ~/Downloads/chef-starter.zip .
unzip chef-starter.zip
```
4. You will now have a chef-repo directory. There will be a USER.pem and knife.rb file in the ~/chef-fundamentals/chef-repo/.chef directory.
5. Edit the /etc/hosts file on the local machine
```
sudo vim /etc/hosts
```
Add the following lines:
```
192.168.123.10 chef-server
192.168.123.11 node1
```
6. Fetch the SSL keys from the Chef Server
```
knife ssl fetch
```
7. Check that the SSL keys are valid
```
knife ssl check
```
8. Test the knife utility by querying for a list of nodes
```
knife node list
```
This command should not return anything

### Bootstrap node1 to the Chef Server from Workstation

1. Run the knife bootstrap command
```
knife bootstrap 192.168.123.11 -N testnode -x vagrant -P vagrant --sudo
```
2. Verify that the node has bootstrapped correctly
```
knife node list
```


## Authors

* **James Leopold** - *Initial work*