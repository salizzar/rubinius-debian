ROOTDIR   := /vagrant
SRCDIR    := $(ROOTDIR)/src
TMPDIR    := $(ROOTDIR)/tmp
DESTDIR   := /opt/rubinius
PKGDIR    := $(SRCDIR)/build
BUILDDIR  := $(SRCDIR)/rubinius

RUBINIUS_VERSION  := rubinius-2.0.0
RUBINIUS_PKG      := $(RUBINIUS_VERSION).tar.bz2

download:
	cd $(TMPDIR) ; curl -O http://releases.rubini.us/$(RUBINIUS_PKG)

clean:
	rm -f $(ROOTDIR)/*.{build,changes,deb,dsc,tar.gz}
	rm -rf $(BUILDDIR) $(PKGDIR)
	sudo rm -rf $(DESTDIR)
	sudo mkdir -p $(DESTDIR)
	sudo chown vagrant. $(DESTDIR)

extract:
	cd $(TMPDIR) ; tar xjvf $(RUBINIUS_PKG) -C $(SRCDIR) ; mv $(SRCDIR)/$(RUBINIUS_VERSION) $(BUILDDIR)

configure:
	cd $(BUILDDIR) ; bundle install --path vendor
	cd $(BUILDDIR) ; ./configure --prefix=$(DESTDIR)

install:
	cd $(BUILDDIR) ; bundle exec rake install

build-package:
	cd $(SRCDIR) ; cp -Rf $(DESTDIR) $(PKGDIR)
	cd $(SRCDIR) ; debuild -rfakeroot --no-tgz-check --no-lintian -us -uc

all: clean extract configure install build-package

