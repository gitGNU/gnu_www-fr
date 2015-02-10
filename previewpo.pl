#!/usr/bin/perl -T

# previewpo.pl -- STDIN PO and STDOUT HTML translation preview
#
# Please, run with `-l' or `--license' to see copyright and license
# information or find it below.

use v5.14;
use strict;
use warnings FATAL => 'all';
use autodie;

sub main(@)
{
    use Getopt::Long;

    my @ARGS = @_;
    my $PN = substr($0, rindex($0, "/") + 1); # program name
    my $VERSION = "0.1";
    my $HTMLSTART =<<EOF;
<!DOCTYPE html>
<html dir="rtl">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8; ">
<title>$PN</title>
</head>
<body>
EOF
    my $HTMLEND =<<'EOF';
</body>
</html>
EOF

    my $help = 0;
    my $license = 0;
    my $version = 0;
    my $start = 1;
    my $trans = 0; # flag to copy translation
    my $count = 0;
    my $trstr = ""; # translated string

    GetOptions('help' => \$help,
               'license' => \$license,
               'version' => \$version) or exit 1;
    if ($help) {
        say "
Usage: $PN <article.lang.po >previewpo.html
-h
--help
        Display usage (this) information and exit successfully.
-l
--license
        Display copyright and license information and exit successfully.
-v
--version
        Display version information and exit successfully.
";
        exit 0;
    }
    if ($license) {
        say "
Copyright © 2014 Donatas Klimašauskas

$PN is free software: you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

$PN is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with $PN.  If not, see
<https://www.gnu.org/licenses/>.
";
        exit 0;
    }
    if ($version) {
        say "
$PN version $VERSION
";
        exit 0;
    }
    while (<>) {
        if (m/^msgstr/) {
            if ($start) {
                $start = 0;
                next;
            }
            $trans = 1;
            $count++;
            $trstr .= "<!-- $count -->\n";
            $_ = $1 if m/"(.+)"$/;
        } elsif (m/^$/) {
            $trans = 0;
            $trstr .= "<br><br>\n";
        }
        if ($trans) {
            s/^[\w\s]*"|"$|\n|\\n|\\(?=")//g;
            $trstr .= $_;
        }
    }
    $trstr =~ s/^(<br>){2}\n//;
    $trstr =~ s/<\/([a-z]+)><\g1>/<br>/ig;
    $trstr =~ s/(href=")(?=\/)/$1https:\/\/gnu\.org/ig;
    print "$HTMLSTART$trstr\n$HTMLEND";
    return 0;
}

exit main(@ARGV);
