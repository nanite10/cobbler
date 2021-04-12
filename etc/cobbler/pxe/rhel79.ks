#version=DEVEL
# System authorization information
install
auth --enableshadow --passalgo=sha512
## Use CDROM installation media
#cdrom
## Use graphical install
#graphical
url --url http://192.168.1.94/cobbler/ks_mirror/rhel79-x86_64/
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda,sdb
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network --onboot no --bootproto=dhcp --device=enp0s3 --ipv6=auto --activate
network  --hostname=ao-l-pxetest01

repo --name="Server-HighAvailability" --baseurl=file:///run/install/repo/addons/HighAvailability
repo --name="Server-ResilientStorage" --baseurl=file:///run/install/repo/addons/ResilientStorage
# Root password
rootpw --iscrypted $6$wr09D2BVAcstog1a$sXE7pMZBsuw8t8raXAQQnBjybl76KN1yqJsmcjS.f/MzELf9BauiloYnw1rx//jExw38jHl4pXo/mmvdSy3He1
# System services
services --enabled="chronyd"
# System timezone
timezone America/New_York --isUtc
user --groups=wheel --name=andrew --password=$6$w0NJ4m.SEYyr9EXc$lfCSoHXKw5EA3GsiggvzFEUO4OUbAI.Iz/zrKEFmagOnZlTpgWsAaxkuTNNnJS9LYBu8TnlH3KAzjhX74OY4X0 --iscrypted --gecos="andrew"
# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part raid.713 --fstype="mdmember" --ondisk=sdb --size=18940
part raid.475 --fstype="mdmember" --ondisk=sda --size=513
part raid.481 --fstype="mdmember" --ondisk=sdb --size=513
part raid.293 --fstype="mdmember" --ondisk=sda --size=1025
part raid.707 --fstype="mdmember" --ondisk=sda --size=18940
part raid.299 --fstype="mdmember" --ondisk=sdb --size=1025
raid / --device=root --fstype="xfs" --level=RAID1 raid.707 raid.713
raid /boot --device=boot --fstype="xfs" --level=RAID1 raid.293 raid.299
raid /boot/efi --device=boot_efi --fstype="efi" --level=RAID1 --fsoptions="umask=0077,shortname=winnt" raid.475 raid.481

%packages
@^minimal
@core
chrony

%end

%addon com_redhat_kdump --disable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
