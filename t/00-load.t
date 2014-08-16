#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'App::multiwhich' ) || print "Bail out!\n";
}

diag( "Testing App::multiwhich $App::multiwhich::VERSION, Perl $], $^X" );
