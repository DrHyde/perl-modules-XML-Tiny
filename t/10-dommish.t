use strict;
$^W=1;

print "1..17\n";
require "t/test_functions";

use XML::Tiny qw(parsedommish);

my $c = parsedommish('t/rsnapshot.conf.xml');

ok($c->isa('XML::Tiny::DOMmish::Node'), "instantiate an object");
ok($c->configversion eq '2.0', "get attrib of root node");
ok($c->snapshotroot->isa('XML::Tiny::DOMmish::Node'),
  "child nodes are also objects");
ok($c->snapshotroot->nocreateroot == 1, "attrib of child node");
ok(''.$c->snapshotroot eq '/.snapshots/', "objects stringify");

eval { no warnings; ''.$c->externalprograms() };
ok($@, "... but not if they contain other nodes");

ok($c->externalprograms->cp->binary eq '/bin/cp', "attribs work on deeply nested nodes");
ok(''.$c->externalprograms->rsync->shortargs->arg eq '-a', "... as does stringification");
ok($c->externalprograms->rsync->shortargs->arg eq '-a', "... and stringy equality checks");
ok($c->externalprograms->rsync->shortargs->arg ne '-b', "... and stringy inequality checks");

is_deeply(
    [$c->externalprograms->rsync->longargs->values()],
    [qw(--delete --numeric-ids --relative --delete-excluded)],
    "values() works when there are values"
);
is_deeply(
    [$c->externalprograms->cp->values()],
    [],
    "... and when there aren't"
);

ok($c->intervals->interval(0)->name eq 'alpha', "can get an individual child which exists several times");
ok($c->intervals->interval(2)->name eq 'gamma', "... and not just the first of 'em!");
eval { $c->intervals->interval(4); };
ok($@, "... but not if there's not enough children");

my @intervals = $c->intervals->interval('*');
ok($intervals[0]->name eq 'alpha' && $intervals[1]->name eq 'beta' &&
   $intervals[2]->name eq 'gamma' && $intervals[3]->name eq 'delta',
    "can get all child nodes as objects");

ok($c->intervals->interval('beta')->retain == 7,
    "can get a named child node");
