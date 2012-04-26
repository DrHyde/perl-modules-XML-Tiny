use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'XML::Tiny',
    META_MERGE => {
        license => 'other',
        resource => {
	    repository => 'https://github.com/DrHyde/perl-modules-XML-Tiny'
        }
    },
    VERSION_FROM => 'lib/XML/Tiny.pm', # finds $VERSION
    PREREQ_PM    => {
        # no pre-reqs!
    }
);
