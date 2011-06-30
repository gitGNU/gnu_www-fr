# This is -*-makefile-gmake-*-, because we adore GNU make.
# Copyright (C) 2008, 2009, 2010 Free Software Foundation, Inc.

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
# GNU gettext >= 0.16
# CVS
# Subversion (if the www-LANG repository is SVN)
# GNU Bzr (if the www-LANG repository is Bzr)
# Git (if the www-LANG repository is Git)
# Mercurial (if the www-LANG repository is Hg)
# GNU Arch (if the www-LANG repository is Arch)

SHELL = /bin/bash

# Set this variable to your language code.
TEAM := fr

# The relative or absolute path to the working copy of the master
# "www" repository; must end with a trailing slash.
wwwdir := ../www/

# Adjust these variables if you don't have the programs in your PATH.
MSGMERGE := msgmerge
MSGFMT := msgfmt
MSGCAT := msgcat
CVS := cvs
SVN := svn
BZR := bzr
GIT := git
HG  := hg
# Baz can be used alternatively; its commands are compatible.
TLA := tla

translations := $(shell find -name '*.$(TEAM).po' | sort)
log := "Automatic merge from the master repository."
# Warning message for the `publish' rule.
pubwmsg := "Warning (%s): %s\n  does not exist; (either obsolete or \`cvs\
update\' in $(wwwdir) needed).\n"

_have-compendium := $(shell test -f compendium.$(TEAM) && echo yes)

# Determine the VCS.
REPO := $(shell (test -d CVS && echo CVS) || (test -d .svn && echo SVN) \
	  || (test -d .bzr && echo Bzr) || (test -d .git && echo Git) \
	  || (test -d .hg && echo Hg) || (test -d \{arch\} && echo Arch))
ifndef REPO
$(error Unsupported Version Control System)
endif

# For those who love details.
ifdef VERBOSE
$(info Repository: $(REPO))
$(info translations = $(translations))
MSGMERGEVERBOSE := --verbose
ECHO := echo $$file: ;
CVSQUIET :=
# Applicable for Bzr, Git and Hg.
QUIET := --verbose
else
CVSQUIET := -q
QUIET := --quiet
endif

# The command to update a PO file from the POT.
# $(1) = PO file
# $(2) = POT file
ifeq ($(_have-compendium),yes)

#  When there is a compendium, use msgcat to remove msgids which are
#  found in compendium (to make sure that translation comes from there),
#  and then call msgmerge
define update-po
cat compendium.$(TEAM) |\
   $(MSGCAT) --use-first --less-than=2 -o $(1) $(1) compendium.$(TEAM) - ; \
   $(MSGMERGE) $(MSGMERGEVERBOSE) -C compendium.$(TEAM) --quiet \
	--update --previous $(1) $(2)
endef

else

define update-po
$(MSGMERGE) $(MSGMERGEVERBOSE) --quiet \
	--update --previous $(1) $(2)
endef

endif

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
	@echo Updating the repositories...
	cd $(wwwdir) && $(cvs-update)
ifeq ($(REPO),CVS)
	$(cvs-update)
else ifeq ($(REPO),SVN)
	$(svn-update)
else ifeq ($(REPO),Bzr)
	$(BZR) pull $(QUIET)
else ifeq ($(REPO),Git)
	$(GIT) pull $(QUIET)
else ifeq ($(REPO),Hg)
# The "fetch" extension is not guaranteed to be available, and/or
# enabled in user's ~/.hgrc.
	$(HG) pull --update $(QUIET)
else ifeq ($(REPO),Arch)
	$(TLA) update
endif
else
	$(info Repositories were not updated, you might want "make VCS=yes".)
endif

# Synchronize (update) the PO files from the master POTs.
.PHONY: sync
sync: update
	@for file in $(translations); do \
	  potdir=$(wwwdir)`dirname $$file`/po; \
	  potfile=`basename $${file/.$(TEAM).po/.pot}`; \
	  if [ ! -f $$potdir/$$potfile ]; then \
	    echo "Warning: $(notdir $$file) has no equivalent .pot in www."; \
	  else \
	    $(ECHO) $(call update-po,$$file,$$potdir/$$potfile); \
	  fi; \
	done
ifeq ($(VCS),yes)
ifeq ($(REPO),CVS)
	$(CVS) commit -m $(log)
else ifeq ($(REPO),SVN)
	$(SVN) commit -m $(log)
else ifeq ($(REPO),Bzr)
# The behavior of `bzr commit' is not very script-friendly: it will
# exit with an error if there are no changes to commit.
	if $(BZR) status --versioned --short | grep --quiet '^ M'; then \
	  $(BZR) commit $(QUIET) -m $(log) && $(BZR) push $(QUIET); \
	else \
	  true; \
	fi
else ifeq ($(REPO),Git)
# Git (`git commit', to be precise) will exit with an error if there
# are only untracked files present (a common situation).  Sadly, there
# doesn't seem to be a decent workaround, so exit status is ignored.
	-$(GIT) commit --all $(QUIET) -m $(log)
	$(GIT) push $(QUIET)
else ifeq ($(REPO),Hg)
	$(HG) commit $(QUIET) -m $(log) && $(HG) push $(QUIET)
else ifeq ($(REPO),Arch)
# Arch is so dumb that it will do a bogus commit (adding another
# absolutely useless revision) even if there are no changes.
# Fortunately, the exit status of `tla changes' is sane.
	$(TLA) changes >/dev/null || $(TLA) commit -s $(log)
endif
endif

# Helper target to check which articles have to be updated.
.PHONY: report
report:
	@for file in $(translations) ; do \
	  LC_ALL=C $(MSGFMT) --statistics -o /dev/null $$file 2>&1 \
	    | egrep '(fuzzy|untranslated)' \
	      && echo "$${file#./} needs updating." || true ; \
	done

# Helper target to rewrap all PO files; avoids spurious diffs when
# they get remerged by the official build.
.PHONY: format
format:
	@echo Formatting .po files with msgcat:
	@for file in $(translations); do \
	  if [ `LC_ALL=C <$$file wc --max-line-length` -gt 80 ]; then \
	    $(MSGCAT) -o $$file $$file && echo "  $${file#./}"; \
	  fi; \
	done

# Helper target to copy all (supposedly) modified files to the `www'
# master repository.  A warning is printed if the corresponding
# directory in `www' cannot be found, or if the template is missing
# (which in almost all cases means that the original article has been
# renamed or deleted).
.PHONY: publish
publish: format
	@echo Copying edited .po files back to $(wwwdir):
	@for file in $(translations); do \
	  wwwfdir=$(wwwdir)`dirname $$file`/po; \
	  wwwfpot=$${wwwfdir}/`basename $${file/.$(TEAM).po/.pot}`; \
	  wwwfile=$${wwwfdir}/`basename $$file`; \
	  if [ ! -d $$wwwfdir ]; then \
	    printf $(pubwmsg) "$${file#./}" "directory $$wwwfdir"; \
	    continue; \
	  fi; \
	  if [ ! -f $$wwwfpot ]; then \
	    printf $(pubwmsg) "$${file#./}" "template $$wwwfpot"; \
	    continue; \
	  fi; \
	  if [ $$file -nt $$wwwfile ]; then \
	    cp $$file $$wwwfile && echo "  $${file#./}"; \
	  fi; \
	done

# Helper target to delete common auto-generated files.
.PHONY: clean
clean:
	@echo -n Deleting unnecessary auto-generated files...
	@for file in $(translations); do \
	  $(RM) $$file~; \
	  $(RM) $${file/.po/.mo}; \
	  $(RM) $$file.bak; \
	done
	@echo " done."
