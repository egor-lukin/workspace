install:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible

deps:
	ansible-galaxy install -fr requirements.yml

setup_localhost:
	ansible-playbook -i hosts setup.yml --ask-become-pass -vvvv

check_local_changes:
	ansible-playbook -i hosts setup.yml --ask-become-pass --check -vvvv

setup_remote_host:
	ansible-playbook -i hosts remote.yml --ask-become-pass -vvvv

check_remote_changes:
	ansible-playbook -i hosts remote.yml --ask-become-pass --check -vvvv
