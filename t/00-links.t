# -*- cperl -*-

use lib qw(lib ../ lib);
use Utils;
use File::Slurp;
use Test::More;
use Data::Dumper;
use v5.14;


my $text= read_file("data/test1.txt");

my @links = extractLinksFromText( $text );
cmp_ok( $#links, ">=", 13);

my %report = checkAllLinks( @links );
say keys(%report);
cmp_ok( scalar keys %report , ">=", 13 );
done_testing();
