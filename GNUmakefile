# This is -*-makefile-gmake-*-, because we adore GNU make.
# Copyright (C) 2008, 2009 Free Software Foundation, Inc.

# This file is part of GNUnited Nations.

# GNUnited Nations is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# GNUnited Nations is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNUnited Nations.  If not, see <http://www.gnu.org/licenses/>.

########################################################################
### TRANSLATORS: Rename this file as GNUmakefile and install it in the #
### root of your project's *Sources* repository.  For details, see the #
### section "PO Files and Team" in the manual.                         #
########################################################################

### DEPENDENCIES ###
# GNU make >= 3.81 (prereleases are OK too)
# GNU gettext >= 0.14
# CVS
# Subversion (if the www-LANG repository is SVN)

SHELL = /bin/bash

# Set this variable to your language code.
TEAM := fr

# The relative path to the working copy of the master "www"
# repository; must end with a trailing slash.
wwwdir := ../www/

# Adjust these variables if you don't have the programs in your PATH.
MSGMERGE := msgmerge
MSGFMT := msgfmt
CVS := cvs
SVN := svn

translations := $(shell find -name '*.$(TEAM).po' | sort)

# Determine the VCS.
REPO := $(shell (test -d CVS && echo CVS) || (test -d .svn && echo SVN))
ifndef REPO
$(error Système de contrôle de version non supporté)
endif

# For those who love details.
ifdef VERBOSE
$(info translations = $(translations))
MSGMERGEVERBOSE := --verbose
ECHO := echo $$file: ;
CVSQUIET :=
endif

# If not in VERBOSE mode, suppress the output from cvs/svn.
CVSQUIET ?= -q

# The command to update the CVS repositories.
define cvs-update
$(CVS) $(CVSQUIET) update -d -P
endef

# The command to update the Subversion repository.
define svn-update
$(SVN) $(CVSQUIET) update
endef

.PHONY: all
all: update sync

# Update the master and the team repositories.
.PHONY: update
update:
ifeq ($(VCS),yes)
	@echo Mise à jour des entrepôts...
	cd $(wwwdir) && $(cvs-update)
ifeq ($(REPO),CVS)
	$(cvs-update)
else
	$(svn-update)
endif
else
	$(info Les entrepôts n'ont pas été mis à jour, vous voulez peut-être faire "make VCS=yes".)
endif

# Synchronize (update) the PO files from the master POTs.
.PHONY: sync
sync: update
	@for file in $(translations) ; do \
	  $(ECHO) $(MSGMERGE) $(MSGMERGEVERBOSE) --quiet --update $$file \
	  $(wwwdir)`dirname $$file`/po/`basename $${file/.$(TEAM).po/.pot}` ; \
	done
ifeq ($(VCS),yes)
ifeq ($(REPO),CVS)
	$(CVS) commit -m "Fusion automatique à partir de l'entrepôt maître."
else
	$(SVN) commit -m "Fusion automatique à partir de l'entrepôt maître."
endif
endif

# Helper target to check which articles have to be updated.
.PHONY: report
report:
	@for file in $(translations) ; do \
	  LC_ALL=C $(MSGFMT) --statistics -o /dev/null $$file 2>&1 \
	    | egrep '(fuzzy|untranslated)' \
	      && echo "$${file#./} doit être mis à jour." || true ; \
	done
