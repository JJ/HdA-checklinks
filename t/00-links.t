# -*- cperl -*-

use lib qw(lib ../ lib);
use Utils;
use File::Slurp;
use Test::More;
use Data::Dumper;
use v5.14;


my $text= read_file("data/test1.txt");

my @links = extractLinksFromText( $text );
cmp_ok( $#links, ">=", 10);

my %report = checkAllLinks( @links );
say keys(%report);
cmp_ok( scalar keys %report , ">=", 10 );

foreach my $link (keys %report ) {
  say Dumper $report{$link};
  if ( $report{$link}->{'status'} eq "200 OK" ) {
    ok( $report{$link}->{'title'}, "$link has title" );
  }
}
done_testing();
