# -*- cperl -*-

use lib qw(lib ../ lib);
use Utils;
use File::Slurp;
use Test::More;
use v5.14;

my $text= read_file("data/test1.txt");

my @links = extractLinksFromText( $text );
say @links;
cmp_ok( $#links, ">=", 13);
done_testing();
