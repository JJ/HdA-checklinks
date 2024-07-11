# -*- cperl -*-

use lib qw(lib ../ lib);
use Utils;
use File::Slurp;
use Test::More;
use v5.14;


my $text= read_file("data/test1.txt");

my @links = extractLinksFromText( $text );
cmp_ok( $#links, ">=", 10);

my %report = checkAllLinks( @links );
cmp_ok( scalar keys %report , ">=", 12 );

foreach my $link (keys %report ) {
  if ( $report{$link}->{'status'} eq "200 OK" ) {
    ok( $report{$link}->{'title'}, "$link has title" );
  }
}
done_testing();
