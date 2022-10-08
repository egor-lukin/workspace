### Dotfiles

1. Prepare: `make install && make deps`
2. Setup: `make setup`

fix ./roles/angstwad.docker_ubuntu/vars/python2.yml

_python_packages:
  - python2-dev
  - python-pip

_pip_executable: pip2

