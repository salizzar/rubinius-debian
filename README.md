rubinius-debian
===============

NOTICE: Rubinius 2.0.0 with Bundler breaks due for this isse: [https://github.com/rubinius/rubinius/issues/2646]

After a lot of research in the interwebs without success, I resolved to create a way to easy build/package Rubinius on Debian Wheezy using Vagrant, rbenv, build-essentials, dh-make and friends.

This project uses a Debian Wheezy Vagrant custom box created by me, but you can use any of your preference. All dependencies are installed with a trivial shell script to provision guest machine.

To start and run vagrant machine, type in your terminal (assuming that you have a vagrant box called debian-wheezy-amd64-base and a host with 4 cpus, of course):

    $ git clone git://github.com/salizzar/rubinius-debian.git
    $ vagrant up

To download Rubinius stable tarball:

    $ vagrant ssh
    $ cd /vagrant
    $ make download-stable

To download Rubinius HEAD tarball:

    $ vagrant ssh
    $ cd /vagrant
    $ make download-head

To configure, compile, install and build Debian package:

    $ vagrant ssh
    $ cd /vagrant
    $ make all

TODO
====

* Use chroot to build
* Improve Makefile
* Find a way to make package more friendly to Debian conventions

Marcelo Pinheiro
==================

