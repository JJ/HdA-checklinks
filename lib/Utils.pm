use LWP::Simple;
use v5.14;

sub extractLinksFromText {
  my $text = shift;
  my @links = $text =~ /\b(https?:\/\/.+?)\s+/g;
  return @links;
}

sub checkAllLinks {
  my @links = @_;
  my $bot = LWP::UserAgent->new( timeout => 20 );
  my %report;
  for my $link (@links) {
    my $response = $bot->get( $link );
    my %result;
    if ( $response->is_success ) {
      $result{'URL'} = $response->request->uri->as_string;
      my $content = $response->decoded_content;
      my ($title) = $content =~ m{<TITLE>(.*?)</TITLE>}gism;
      $result{'title'} = $title;
    }
    $result{'status'} = $response->status_line;
    $report{$link} = \%result;
  }
  return %report;
}

"Sad but true";
