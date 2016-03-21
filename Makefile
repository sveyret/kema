###############################################################################
# Copyright © 2016 Stéphane Veyret stephane_DOT_veyret_AT_neptura_DOT_org
#
# This file is part of kema.
#
# kema is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# kema is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# kema.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################

SRC= $(wildcard po/*.po)
MO= $(SRC:.po=.mo)

all: $(MO)

# Building po files:
# xgettext -o lang.po -j -L shell --from-code UTF-8 usr/sbin/kema usr/libexec/kema/kema-*
%.mo: %.po
	msgfmt -o $@ $<

.PHONY: clean mrproper install

clean:
	rm -f po/*.mo

mrproper: clean

