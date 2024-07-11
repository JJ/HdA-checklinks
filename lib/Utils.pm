sub extractLinksFromText {
  my $text = shift;
  my @links = $text =~ /\b(https?:\/\/.+?)\s+/g;
  return @links;
}

"Sad but true";
