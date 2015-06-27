build: boot2docker-vagrant_1-6-0.iso
	time (packer build -parallel=false template.json)

prepare: clean boot2docker-vagrant_1-6-0.iso

boot2docker-vagrant_1-6-0.iso:
	vagrant up
	vagrant ssh -c 'cd /vagrant && sudo ./build-iso.sh'
	vagrant destroy --force

clean:
	rm -rf *.iso *.box

.PHONY: clean prepare build
