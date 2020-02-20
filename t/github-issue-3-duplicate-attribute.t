use strict;
use lib '.';

use XML::Tiny qw(parsefile);

use Test::More skip_all => 'known bug';

require "t/test_functions";
print "1..1\n";

$^W = 1;
$SIG{__WARN__} = sub { die("Caught a warning, making it fatal:\n\n$_[0]\n"); };

ok(parsefile(\*DATA), "didn't barf");

__END__
<tabpage>
   <control type='labelh' text='VEhFUkU=' />
   <control type='faderh' />
</tabpage>
