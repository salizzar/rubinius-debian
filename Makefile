ROOTDIR   := /vagrant
SRCDIR    := $(ROOTDIR)/src
TMPDIR    := $(ROOTDIR)/tmp
DESTDIR   := /opt/rubinius
PKGDIR    := $(SRCDIR)/build
BUILDDIR  := $(SRCDIR)/rubinius

RUBINIUS_VERSION  := rubinius-2.0.0
RUBINIUS_PKG      := rubinius.tar.gz

download-stable:
	rm -rf $(TMPDIR) ; mkdir -p $(TMPDIR)
	cd $(TMPDIR) ; curl -o rubinius.tar.bz2 http://releases.rubini.us/$(RUBINIUS_VERSION).tar.bz2 ; bunzip2 -c < rubinius.tar.bz2 | gzip -c > $(RUBINIUS_PKG)

download-head:
	rm -rf $(TMPDIR) ; mkdir -p $(TMPDIR)
	cd $(TMPDIR) ; curl -o rubinius.tar.gz -L https://github.com/rubinius/rubinius/archive/master.tar.gz

clean:
	rm -f $(ROOTDIR)/*.{build,changes,deb,dsc,tar.gz}
	rm -rf $(BUILDDIR)/rubinius* $(SRCDIR)/rubinius*
	rm -rf $(PKGDIR)
	sudo rm -rf $(DESTDIR)
	sudo mkdir -p $(DESTDIR)
	sudo chown vagrant. $(DESTDIR)

extract:
	cd $(TMPDIR) ; tar xvf $(RUBINIUS_PKG) -C $(SRCDIR) ; mv $(SRCDIR)/rubinius-* $(BUILDDIR)

configure:
	cd $(BUILDDIR) ; bundle install --path vendor
	cd $(BUILDDIR) ; ./configure --prefix=$(DESTDIR)

install:
	cd $(BUILDDIR) ; bundle exec rake install

build-package:
	cd $(SRCDIR) ; cp -Rf $(DESTDIR) $(PKGDIR)
	cd $(SRCDIR) ; debuild -rfakeroot --no-tgz-check --no-lintian -us -uc

all: clean extract configure install build-package

