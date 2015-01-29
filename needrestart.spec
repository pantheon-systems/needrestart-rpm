# configure these
%define nr_ver  2.0
%define release_number 2

Name:		needrestart
Version:	%{nr_ver}
Release:	%{release_number}%{dist}
Summary:	Restart daemons after library updates.
License:	GPL
URL:        https://fiasko-nw.net/~thomas/tag/needrestart.html

Source0:	https://github.com/liske/needrestart/archive/v%{nr_ver}.tar.gz

BuildRequires:	perl-Module-ScanDeps
BuildRequires:  perl-Proc-ProcessTable
BuildRequires:  perl-Sort-Naturally
# @TODO(joe): Term::ProgressBar::Simple is listed as a dep by needrestart but it is not
#             available as an rpm on fedora-19. Nonetheless, it does not seem to interfere
#             with the most common use case. When we are no longer maintaing a fedora-19 build
#             we can uncomment this.
#BuildRequires:  perl-Term-ProgressBar-Simple
BuildRequires:  perl-Module-Find
BuildRequires:  perl-ExtUtils-MakeMaker

Requires:  perl-Module-ScanDeps
Requires:  perl-Proc-ProcessTable
Requires:  perl-Sort-Naturally
# @TODO(joe): see above. uncomment this after no longer maintaining a fedora-19 or older build.
#Requires:  perl-Term-ProgressBar-Simple
Requires:  perl-Module-Find
Requires:  perl-ExtUtils-MakeMaker

%description
Restart daemons after library updates.
https://fiasko-nw.net/~thomas/tag/needrestart.html
https://github.com/liske/needrestart

%prep
%setup -n needrestart-%{nr_ver}

%build
make

%install
make install DESTDIR=%{buildroot}

%files
# everything here is relative to the %{buildroot}
%config /etc/needrestart
/usr/lib64/perl5
/usr/sbin/needrestart
/usr/share/perl5/vendor_perl/NeedRestart
/usr/share/perl5/vendor_perl/NeedRestart.pm
/usr/share/polkit-1/actions/net.fiasko-nw.needrestart.policy

%changelog
* Wed Jan 28 2015 Joe Miller <joe@getpantheon.com>
- initial commit of .spec
