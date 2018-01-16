#!/bin/bash

key='ed25519'
domain='.random.org'
server=(sever-1 server-2 server-3)
user=$(whoami)
pub="/home/$user/.ssh/$user"

function keygen() {
  if [ -f "$pub" ]; then
    pub="$pub$domain"
  fi
    ssh-keygen -t $key -q -C $user -f $pub
  for i in ${server[@]}; do
    ssh-copy-id -i $pub $user@$i$domain
  done
    clear
}

if [ `id -u` == 0 ]; then
  echo 'dont use sudo - noob!'
  exit 1;
fi

if [ ! -d "/home/$user/.ssh" ]; then
  mkdir /home/$user/.ssh
fi

  keygen
  #config ~/.bashrc - start ssh-agent & ssh-add
  cat $(pwd)/ssh.conf >> ~/.bashrc
  clear
  sed -ie "s,ssh-add,ssh-add $pub,g" ~/.bashrc

#config ~/.ssh/config - $server
for i in ${server[@]}; do
  printf "\nHost $i\n\tuser $user\n\thostname $i$domain\n\tidentityfile $pub\n\tport 22" >> /home/$user/.ssh/config
done

  chmod 600 /home/$user/.ssh/config

printf '\n----\ncommands:\n----\n'

for i in ${server[@]}; do
  printf "ssh $i\n"
done

echo ''

