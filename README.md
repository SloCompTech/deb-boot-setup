# Boot setup utils

This project enables you to configure device properties such as **hostname** using a file on `/boot` partition like you enable *ssh* or *wi-fi* on Raspberry Pi.

## Usage

- Create `bootsetup` folder in `/boot` partition (only partition seen in Windows), here will reside all config files (Note: Some files may disappear during configuration process).
- Configure different parameters, see [docs folder](docs).

## Installing

``` bash
# Build .deb file
make

# Copy .deb from dist/ to target device

# Install .deb
dpkg -i <name>.deb

# View logs
systemctl status bootsetup
```

## Config folder structure

```
/boot/bootsetup
	bashhistory # Clear bash history
	dockerlogs # Clear docker logs
	custom/	# Directory with custom scripts
	custom-docker/ # Directory with custom docker scripts
	hostname # Sets device hostname
	lock # Lock init & config scripts
	lock-init # Lock init scripts
	lock-docker # Lock docker scripts
	passwd-USER # Sets user password
	rootfs/	# Copies files to system (structured as from /)
	sshauth-USER # Add SSH keys to authorized_keys for user
	sshreset # Reset SSH keys
	upgrade # Update & upgrade using apt
```

## Contributing

### Make additional settings

- Create script for parameter in `root/etc/bootsetup/scripts`.
- Make script **EXECUTABLE !!**.
- Add info below *## Config folder structure*.
- Add detailed documentation in docs folder.
- Make pull request.

## Issues

Submit issue [here](https://github.com/SloCompTech/deb-boot-setup/issues).  

## Versioning

We use [Debian versioning](https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-version) for versioning.
