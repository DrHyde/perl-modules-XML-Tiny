# $Id: pod-coverage.t,v 1.2 2007/10/29 22:48:48 drhyde Exp $
use strict;
$^W=1;

eval "use Test::Pod::Coverage 1.00";
if($@) {
    print "1..0 # Test::Pod::Coverage 1.00 required for testing POD coverage";
} else {
    all_pod_coverage_ok();
}
