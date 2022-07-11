prepare:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible
	ansible-galaxy install angstwad.docker_ubuntu

setup:
	ansible-playbook -i hosts setup.yml --ask-become-pass -vvvv

check:
	ansible-playbook -i hosts setup.yml --ask-become-pass --check -vvvv
