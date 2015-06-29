build: boot2docker-vagrant_1-6-0.iso

prepare: clean boot2docker-vagrant_1-6-0.iso

boot2docker-vagrant_1-6-0.iso:
	vagrant up
	vagrant ssh -c 'cd /vagrant && sudo ./build-iso.sh'
	vagrant destroy --force

packer-all: packer-parallels packer-virtualbox packer-vmware

packer-parallels:
	time (packer build -only=parallels-iso -parallel=false template.json)

packer-virtualbox:
	time (packer build -only=virtualbox-iso -parallel=false template.json)

packer-vmware:
	time (packer build -only=vmware-iso -parallel=false template.json)


clean:
	rm -rf *.iso *.box

.PHONY: clean prepare build
