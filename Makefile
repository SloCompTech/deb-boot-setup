#
#		Build into package
#

build:
	mkdir -p dist/bootsetup
	cp -r debian/* dist/bootsetup/
	cp -r root/* dist/bootsetup/
	cp LICENSE.md dist/bootsetup/usr/share/doc/bootsetup/copyright
	gzip --best dist/bootsetup/usr/share/doc/bootsetup/changelog
	gzip --best dist/bootsetup/usr/share/doc/bootsetup/changelog.Debian
	cd dist && fakeroot dpkg-deb --build bootsetup
	#rm -rf dist/bootsetup
	
clean:
	rm -rf dist