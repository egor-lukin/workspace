install:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible

deps:
	ansible-galaxy install -fr requirements.yml

sync:
	ansible-playbook -i hosts dev.yml --ask-become-pass -vvvv

upgrade:
	ansible-playbook -i hosts upgrade.yml --ask-become-pass -vvvv
