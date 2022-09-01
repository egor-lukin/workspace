install:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible

deps:
	ansible-galaxy install -fr requirements.yml --roles-path ./ansible-deps

setup:
	ansible-playbook -i hosts setup.yml --ask-become-pass -vvvv

update_packages:
	ansible-playbook -i hosts setup.yml --ask-become-pass -vvvv --tags "packages"

upgrade_packages:
	ansible-playbook -i hosts upgrade.yml --ask-become-pass -vvvv

check:
	ansible-playbook -i hosts setup.yml --ask-become-pass --check -vvvv
