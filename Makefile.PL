use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

my %WriteMakefile_args = (
    NAME             => 'App::multiwhich',
    AUTHOR           => q{A. Sinan Unur <nanis@cpan.org>},
    VERSION_FROM     => 'lib/App/multiwhich.pm',
    ABSTRACT_FROM    => 'lib/App/multiwhich.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    EXE_FILES        => [ 'script/multiwhich' ],
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::Exception' => 0,
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'namespace::sweep' => '0.006',
        'File::Basename' => 0,
        'File::Spec::Functions' => '3.47',
        'Perl::OSType' => '1.006',
        'YAML::XS' => '0.48',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'App-multiwhich-*' },
);

# TODO: I can't figure out THE right way to do this,
# hope it is good enought for now

if ($ExtUtils::MakeMaker::VERSION >= 6.68) {
    $WriteMakefile_args{META_MERGE} = {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url => 'git://github.com/nanis/App-multiwhich.git',
                web => 'https://github.com/nanis/App-multiwhich',
            }
        },
    };
}

WriteMakefile(%WriteMakefile_args);

