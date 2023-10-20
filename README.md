# Nutrifolio_API Infrastructure as Code (IaC)

The purpose of this repository is to provide the necessary Infrastructure as Code (IaC) scripts to deploy the [Nutrifolio_API](https://github.com/Nutrifolio/Nutrifolio_API) project.

## Prerequisites

- A DigitalOcean Personal Access Token, which can be [created](https://docs.digitalocean.com/reference/api/create-personal-access-token/) via the DigitalOcean control panel.
- A DigitalOcean Space Keys pair, which can be [created](https://docs.digitalocean.com/products/spaces/how-to/manage-access/) via the DigitalOcean control panel.
- An SSH key named `nutrifolio-api-env` added to DigitalOcean and GitHub accounts.
- A personal domain [pointed](https://docs.digitalocean.com/tutorials/dns-registrars/) to DigitalOcean’s nameservers.

## Ansible Control Node Setup

The Control Node, the machine on which Ansible is installed, is responsible for executing Ansible Playbooks to configure the Ansible Hosts - the target servers that Ansible manages. The suggested OS for the Control Node is `Ubuntu 22.04 x64`.Unlike other configuration management tools, Ansible is agentless, meaning that it does not require any specialized software to be installed on the Ansible Hosts being managed.

### Installation Guide

- #### Update Packages

  `sudo apt update`

- #### Install pip3

  `sudo DEBIAN_FRONTEND=noninteractive apt install python3-pip -y`

- #### Install Ansible

  `pip3 install ansible==7.5.0`

- #### Generate an SSH key pair without a passphrase (change <your_email_address>)

  `ssh-keygen -t rsa -C <your_email_address> -f /root/.ssh/tf-digitalocean -N ""`

- #### [Add](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) the contents of the SSH public key `tf-digitalocean.pub` to your GitHub account. Moreover, [add](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/to-team/) the contents of the SSH public key `tf-digitalocean.pub` to your DigitalOcean account and give it the name of `nutrifolio-api-env`.

  `cat /root/.ssh/tf-digitalocean.pub`

- #### Add github.com to known hosts

  `ssh-keyscan github.com >> ~/.ssh/known_hosts`

- #### Clone IaC scripts

  `git clone -c "core.sshCommand=ssh -i /root/.ssh/tf-digitalocean" git@github.com:Nutrifolio/Nutrifolio_IaC.git`

- #### Change Directory

  `cd ./Nutrifolio_IaC`

- #### Execute Ansible Playbook

  `ansible-playbook init.yml`

- #### Export Environment Variables

  `export DIGITALOCEAN_TOKEN=<your_API_token>`

  `export SPACES_ACCESS_KEY_ID=<your_ACCESS_KEY>`

  `export SPACES_SECRET_ACCESS_KEY=<your_SECRET>`

- #### Change Directory

  `cd ./nutrifolio_api_env/nutrifolio-infrastructure/`

- #### Execute terraform apply (change <your_domain_name>, <your_digitalocean_ssh_key_name>, <Development or Production>, <your_vpc_name>, <your_space_bucket_name>, <your_db_cluster_name>)

<pre>
  terraform apply \
    -var="domain-name=&lt;your_domain_name&gt;" \
    -var="ssh-key-name=&lt;your_digitalocean_ssh_key_name&gt;" \
    -var="environment=&lt;Development or Production&gt;" \
    -var="vpc-name=&lt;your_vpc_name&gt;" \
    -var="sb-name=&lt;your_space_bucket_name&gt;" \
    -var="db-cluster-name=&lt;your_db_cluster_name&gt;" \
    --auto-approve
</pre>

- #### Get the values of the variables required to setup the `nutrifolio-api-env` Droplet

  `cat variables.output`

- #### Change Directory

  `cd ../`

- #### Setup the `nutrifolio-api-env` Droplet (change \<nutrifolio-api-env-ipv4\>, <your_domain_name>, <your_email_address>, <db_host>, <db_port>, <db_name>, <db_user>, <db_password>, <secret_key>, <do_access_key>, <do_secret_key>, <sb_url>, <dsn>, <pgadmin_email> & <pgadmin_password>)

<pre>
  ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
    -u root \
    -i '&lt;nutrifolio-api-env-ipv4&gt;,' \
    -e 'domain_name=&lt;your_domain_name&gt;' \
    -e 'email_address=&lt;your_email_address&gt;' \
    -e 'db_host=&lt;db_host&gt;' \
    -e 'db_port=&lt;db_port&gt;' \
    -e 'db_name=&lt;db_name&gt;' \
    -e 'db_user=&lt;db_user&gt;' \
    -e 'db_password=&lt;db_password&gt;' \
    -e 'secret_key=&lt;secret_key&gt;' \
    -e 'do_access_key=&lt;do_access_key&gt;' \
    -e 'do_secret_key=&lt;do_secret_key&gt;' \
    -e 'sb_url=&lt;sb_url&gt;' \
    -e 'dsn=&lt;dsn&gt;' \
    -e 'pgadmin_email=&lt;pgadmin_email&gt;' \
    -e 'pgadmin_password=&lt;pgadmin_password&gt;' \
    -e 'pub_key=/root/.ssh/tf-digitalocean.pub' \
    --private-key /root/.ssh/tf-digitalocean \
    setup_droplet.yml
</pre>

## Author

- Ioannis Papadatos
