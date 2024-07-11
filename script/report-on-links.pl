#!/usr/bin/env perl

use lib qw(../lib lib);
use Utils;
use File::Slurp;

my $fileName = shift || die "Need a file name";

my $content = read_file($fileName) || die "File $fileName does not work";

my @links = extractLinksFromText($content);
my %report = checkAllLinks( @links );

foreach my $link (keys %report ) {
  if ( $report{$link}->{'status'} eq "200 OK" ) {
    if ( $link eq $report{$link}->{'URL'} ) {
      $content =~ s/$link/$link → «$report{$link}->{'title'}»/;
    } else {
      $content =~ s/$link/\[ $link \] ➡ $report{$link}->{'URL'} → «$report{$link}->{'title'}»/
    }
  } else {
    $content =~ s/$link/✘ $link/
  }
}

print $content;
