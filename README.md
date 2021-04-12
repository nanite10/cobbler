# cobbler
1. sudo ansible-playbook setup_cobbler.yml
2. mount -t iso9660 -o loop,ro /path/to/isos/rhel-server-7.9-x86_64-dvd.iso /mnt/cdrom
3. sudo cobbler import --name=rhel79 --arch=x86_64 --path=/mnt/cdrom
4. sudo cobbler profile add --name=rhel79 --distro=rhel79-x86_64 --kickstart=/var/lib/cobbler/kickstarts/rhel79.ks
5. sudo cobbler profile report --name=rhel79
6. sudo cobbler system add --name=ao-l-pxetest01 --profile=rhel79 --interface=eth0 --mac=1c:1b:0d:08:22:4f --ip-address=192.168.1.129 --netmask=255.255.255.0 --static=1 --dns-name=ao-l-pxetest01.homelab
