#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';

use Perl::OSType qw( is_os_type );
use Test::Exception;
use Test::More;
use App::multiwhich;

run();

sub run {
    test_die_with_no_arguments();
}

sub test_die_with_no_arguments {
    dies_ok { App::multiwhich->new->run } 'Dies with no arguments';
}

done_testing;

