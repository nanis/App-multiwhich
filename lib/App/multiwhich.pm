package App::multiwhich;

use utf8;
use 5.006;
use strict;
use warnings FATAL => 'all';

our $VERSION = '0.001';
$VERSION = eval $VERSION;

use namespace::sweep;
use File::Spec::Functions qw( canonpath catfile path );
use File::Basename qw( fileparse );
use Perl::OSType qw(is_os_type);

sub new {
    my $class = shift;
    my $self = [ @{ $_[0] } ];
    bless $self => $class;
}

sub run {
    my $self = shift;

    @$self or $self->usage;

    my @path = path;
    my @pathext = ('');

    if (is_os_type('Windows')) {
        push @pathext, map lc,
            map /\A([.][A-Za-z0-9]{1,32})\z/,
            split /;/, $ENV{PATHEXT}
        ;
    }

    my @ret;

    LOOKFOR:
    for my $lookfor ( @$self ) {
        if ($lookfor ne fileparse $lookfor) {
            warn "Skipped '$lookfor': Argument is not a plain file name\n";
            next LOOKFOR;
        }

        my %results = ( $lookfor => [] );
        my ($results) = values %results;

        for my $dir ( @path ) {
            for my $ext ( @pathext ) {
                my $p = catfile $dir => "$lookfor$ext";
                if (-x $p) {
                    push @$results, canonpath $p;
                }
            }
        }

        push @ret, \%results;
    }
    return \@ret;
}

sub usage {
    my $self = shift;

    die "Usage: multiwhich name1 name2 name3 ... namex\n";
}

__DATA__

=encoding utf8

=head1 NAME

App::multiwhich - The great new App::multiwhich!

=head1 VERSION

Version 0.001

=head1 SYNOPSIS

The standard Unix utility C<which> locates executables in the user's path.
This module installs a command line program called C<multiwhich> to locate
if identically named executables exist in multiple directories in your
path.

For example, on my L<MacBook
Pro|http://blog.nu42.com/2014/06/did-i-really-need-to-put-ssd-in-my.html>,
using L<YAML::XS> as the output driver, I get:

    $ multiwhich perl
    ---
    - perl:
      - /Users/auser/perl/5.20.0/bin/perl
      - /opt/local/bin/perl
      - /usr/bin/perl

The first one is my build, the second one is
L<MacPorts|https://www.macports.org/>' default, and the third one is the
system C<perl>.

=head1 METHODS

=head2 new

The constructor takes a reference to an array of program names. Directories
in the user's C<$PATH> are searched for those executables.

=head2 run

Actually performs the search, and returns the results in a refernce to an
array of hashrefs. The sole key in each hashref is the name of the program
which is being sought, and the values is a reference to an array of
directories where executables with that name exist.

=head2 usage

Dies with a short usage message.

=head1 AUTHOR

A. Sinan Unur, C<< <nanis at cpan.org> >>

=head1 BUGS

I am sure there are more than a few.

Please report any bugs or feature requests to C<bug-app-multiwhich at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-multiwhich>.  I will be
notified, and then you'll automatically be notified of progress on your bug
as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::multiwhich

You can also look for information at:

=over 4

=item * L<RT: CPAN's request tracker (report bugs here)|http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-multiwhich>

=item * L<AnnoCPAN: Annotated CPAN documentation|http://annocpan.org/dist/App-multiwhich>

=item * L<CPAN Ratings|http://cpanratings.perl.org/d/App-multiwhich>

=item * L<Search CPAN|https://metacpan.org/pod/App::multiwhich/>

=back

=head1 ACKNOWLEDGEMENTS

My sincere thanks to everyone who have made Perl such a useful and enjoyable
tool, and to those who keep it going.

=head1 LICENSE AND COPYRIGHT

Copyright © 2014 A. Sinan Unur.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

