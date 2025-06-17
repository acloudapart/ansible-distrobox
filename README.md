### To use this repo, first create the distrobox container for tool use

``` bash
distrobox create --name ansible --image ubuntu:24.04 --init-hooks "bash $HOME/devops/ansible-distrobox/provision.sh"
```