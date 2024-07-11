use LWP::Simple;
use v5.14;

sub extractLinksFromText {
  my $text = shift;
  my @links = $text =~ /((?:https?:\/\/|www)\S+?)[\s)]+/g;
  return @links;
}

sub checkAllLinks {
  my @links = @_;
  my $bot = LWP::UserAgent->new( timeout => 20 );
  my %report;
  for my $link (@links) {
    my $url=  $link =~ /^www/ ? "https://$link" : $link;
    my $response = $bot->get( $url );
    my %result;
    if ( $response->is_success ) {
      $result{'URL'} = $response->request->uri->as_string;
      my $content = $response->content;
      my ($title) = $content =~ m{<TITLE>(.*?)</TITLE>}gism;
      $result{'title'} = $title;
    }
    $result{'status'} = $response->status_line;
    $report{$link} = \%result;
  }
  return %report;
}

"Sad but true";
