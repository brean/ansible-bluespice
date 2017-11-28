# for virtualbox: mount first using "sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) ansible-bluespice ~/ansible-bluespice" after install virtualbox guest addons
# install ansible first "apt install ansible"


# generate random passwords for MySQL on the client that runs ansible
sudo apt install -y passwdqc
if [ ! -f ./variables.yml ]; then
  cp templates/variables.yml variables.yml

  MYSQL_ROOT_PW=`pwqgen`
  echo MySQL root password: $MYSQL_ROOT_PW
  sed -i -e 's/MYSQL_ROOT_PW/'$MYSQL_ROOT_PW'/g' variables.yml

  MYSQL_USER_PW=`pwqgen`
  echo MySQL user password: $MYSQL_USER_PW
  sed -i -e 's/MYSQL_USER_PW/'$MYSQL_USER_PW'/g' variables.yml
fi

sudo ansible-playbook -i localhost, -c local bluespice-all.yml
