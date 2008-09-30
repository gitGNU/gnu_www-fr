# Copyright (C) 2007, 2008 Free Software Foundation, Inc.

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
# along with GNUnited Nations. If not, see <http://www.gnu.org/licenses/>.

# TRANSLATORS: Add here your language code.  Please keep the
# alphabetical order.
TEMPLATE_LINGUAS := af ar bg ca es fr he it ml nl pt pt-br ru sr tr uk zh-cn

# TRANSLATORS: If you have committed home.LANG.po, add here your
# language code.
HOME_LINGUAS := ar bg ca es fr it nl ru sr tr uk zh-cn

### The variables below are edited by GNUN maintainers. ###

# List of articles for which GRACE do not apply; i.e. they are
# regenerated even if there are fuzzy strings.
no-grace-articles := $(addprefix $(rootdir)/, \
			server/po/takeaction)

ALL_DIRS :=	award \
		contact \
		copyleft \
		education \
		gnu \
		graphics \
		help \
		licenses \
		licenses/old-licenses \
		links \
		people \
		philosophy \
		philosophy/economics_frank \
		philosophy/sco \
		server \
		server/standards \
		software

ROOT :=		keepingup \
		provide

award :=	award \
		award-1998 \
		award-1999

contact :=	contact

copyleft :=	copyleft

education :=	education \
		freelearning \
		software

gnu :=		byte-interview \
		fs-user-groups \
		gnu \
		gnu-history \
		gnu-linux-faq \
		gnu-user-groups \
		gnu-users-never-heard-of-gnu \
		initial-announcement \
		linux-and-gnu \
		manifesto \
		rms-lisp \
		thegnuproject \
		why-gnu-linux

graphics :=	license-logos

help :=		evaluation \
		help

licenses :=	200104_seminar \
		210104_seminar \
		agpl-3.0 \
		fdl-1.2 \
		fdl-howto \
		fdl-howto-opt \
		gpl-3.0 \
		gpl-faq \
		gpl-howto \
		gpl-violation \
		gplv3-the-program \
		hessla \
		lgpl-3.0 \
		lgpl-java \
		license-list \
		licenses \
		NYC_Seminars_Jan2004 \
		quick-guide-gplv3 \
		rms-why-gplv3 \
		translations \
		why-assign \
		why-gfdl \
		why-not-lgpl

licenses/old-licenses :=	fdl-1.1 \
				gpl-1.0 \
				gpl-2.0 \
				gpl-2.0-faq \
				gpl-2.0-translations \
				lgpl-2.1 \
				lgpl-2.1-translations \
				library \
				old-licenses

links :=	companies

people :=	people

philosophy := 	15-years-of-free-software \
		amazon \
		amazon-nat \
		amazon-rms-tim \
		apsl \
		basic-freedoms \
		bdk \
		boldrin-levine \
		bsd \
		can-you-trust \
		categories \
		censoring-emacs \
		compromise \
		computing-progress \
		copyright-and-globalization \
		copyright-versus-community \
		dat \
		dmarti-patent \
		drdobbs-letter \
		ebooks \
		eldred-amicus \
		enforcing-gpl \
		fighting-software-patents \
		fire \
		free-doc \
		freedom-or-copyright \
		freedom-or-copyright-old \
		freedom-or-power \
		free-software-for-freedom \
		free-software-intro \
		free-sw \
		free-system-distribution-guidelines \
		free-world \
		free-world-notes \
		fs-translations \
		gates \
		gif \
		gnutella \
		gpl-american-dream \
		gpl-american-way \
		greve-clown \
		guardian-article \
		hague \
		historical-apsl \
		ICT-for-prosperity \
		ipjustice \
		java-trap \
		kevin-cole-response \
		kragen-software \
		lessig-fsfs-intro \
		linux-gnu-freedom \
		luispo-rms-interview \
		mcvoy \
		microsoft \
		microsoft-antitrust \
		microsoft-new-monopoly \
		microsoft-verdict \
		misinterpreting-copyright \
		moglen-harvard-speech-2004 \
		motif \
		motivation \
		ms-doj-tunney \
		my_doom \
		netscape \
		netscape-npl \
		netscape-npl-old \
		new-monopoly \
		nit-india \
		no-ip-ethos \
		no-word-attachments \
		nonsoftware-copyleft \
		not-ipr \
		open-source-misses-the-point \
		opposing-drm \
		papadopoulos-response \
		patent-practice-panel \
		patent-reform-is-not-enough \
		philosophy \
		plan-nine \
		pragmatic \
		privacyaction \
		protecting \
		push-copyright-aside \
		reevaluating-copyright \
		rieti \
		right-to-read \
		rms-comment-longs-article \
		rms-hack \
		rms-interview-edinburgh \
		rms-kol \
		rtlinux-patent \
		savingeurope \
		schools \
		second-sight \
		self-interest \
		selling \
		shouldbefree \
		social-inertia \
		software-libre-commercial-viability \
		software-literary-patents \
		software-patents \
		speeches-and-interview \
		stallman-kth \
		stallman-mec-india \
		stophr3028 \
		sun-in-night-time \
		sylvester-response \
		third-party-ideas \
		trivial-patent \
		ucita \
		udi \
		university \
		use-free-software \
		using-gfdl \
		vaccination \
		w3c-patent \
		wassenaar \
		why-audio-format-matters \
		why-copyleft \
		why-free \
		wipo-PublicAwarenessOfCopyright-2002 \
		words-to-avoid \
		wsis \
		wsis-2003 \
		x \
		your-freedom-needs-free-software

philosophy/economics_frank :=	frank

philosophy/sco :=	questioning-sco \
			sco \
			sco-gnu-linux \
			sco-preemption \
			sco-v-ibm \
			sco-without-fear \
			subpoena

server :=	sitemap \
		takeaction \
		tasks

server/standards :=	README.translations

software :=	devel \
		software
