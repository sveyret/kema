# kema, the Gentoo kernel manager

kema is a set of shell scripts used to ease management of a Linux kernel under Gentoo. Its main purposes are:
* Quickly upgrade kernel when a new version is delivered.
* Make some configuration tests on a kernel.
* Always keep a backup kernel, in case the kernel upgrade or test does not work as expected.

# Language/langue

Because French is my native language, finding all documents and messages in French is not an option. Other translations are welcome.

Anyway, because English is the language of programming, the code, including variable names and comments, are in English.

:fr: Une version française de ce document se trouve [ici](doc/fr/README.md).

# Licence

Copyright © 2016 Stéphane Veyret stephane_DOT_veyret_AT_neptura_DOT_org

kema is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

kema is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with kema.  If not, see <http://www.gnu.org/licenses/>.

# Install

A Makefile is provided to compile messages. Installation can simply done by copying files in appropiate locations.

    DEST=/
    LINGUAS=fr
    make
    cp -R usr etc ${DEST}
    cp po/${LINGUAS}.mo /usr/share/locale/${LINGUAS}/LC_MESSAGES/kema.mo
    mkdir -p /var/lib/kema

It is also recommanded to install _genkernel_ package if you need it to provide an _initramfs_.

# Usage

Before using kema, ensure that configuration file /etc/kema/kema.conf matches your needs. The default configuration file contains self-explanatory comments.

## Upgrade

When upgrading a kernel for the first time with kema, you may need to specify the version of the kernel you want to use:

    kema upgrade 4.1.15

This will also be the case if there are multiple possible kernels in the /usr/src directory. If you use kema each time a new kernel source is installed on your computer, the new version should be automatically detected, so you may simply use:

    kema upgrade

The current kernel will be kept for backup and your bootloader will be modified to select it if needed.

Upgrading kernel will open the kernel configuration menu. If you do not want to modify the current configuration, you can simply exit. The configuration of previous kernel is automatically imported.

If you leave _genkernel_ create the _initramfs_ file for you, it will have to be embedded in the kernel. It will be required to check the the kernel configuration option _CONFIG_INITRAMFS_SOURCE_ is left at _initramfs.cpio_. This same option must have the same value if you give an _initramfs_ file to be embedded.

It is also possible to specify an _initramfs_ option to be added to the kernel by the bootloader. In this case, you have to install this file at proper place by yourself.

## Test

If you want to test changes on current kernel options, you can execute:

    kema test

This will open the kernel configuration menu. Once your modifications are done, exit the menu. This will create a new kernel with the given options. The current options will be saved. If your tests are valid, terminate with the command:

    kema valid

This will replace the default kernel with the tested one. If your tests failed, you can cancel them with the command:

    kema cancel

This will set the default kernel back and delete the tested modifications.

## Other functions

If you want to have information about the current status (installed kernels, pending tests), you can use the following command:

    kema status

# Tasks

## Version 1.0

- [ ] Add message for each removed kernel.
- [ ] Do not remove kernels present in eselect (not unmerged), but display warning.
- [ ] Care for command return values and stop script if error.

## Future version

- [ ] Add other bootloaders.
- [ ] Add other translations.

