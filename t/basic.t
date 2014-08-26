use strict;
use warnings;
use Test::More;
use URI;

isa_ok(URI->new('irc://irc.perl.org/'), 'URI::irc');
for my $url (
  'irc://irc.perl.org/perl',
  'irc://irc.perl.org/#perl',
  'irc://irc.perl.org/%23perl',
  'irc://irc.perl.org/?channel=perl',
  'irc://irc.perl.org?channel=perl',
  'irc://irc.perl.org/%23notperl?channel=perl',
  'irc://irc.perl.org/%23notperl?channel=notperl2#perl',
) {
  my $uri = URI->new($url);
  is $uri->channel, '#perl',
    "correct channel from $url";
  is $uri->canonical->as_string, 'irc://irc.perl.org/%23perl',
    "correct canonicalization of $url";
}

isa_ok(URI->new('ircs://irc.perl.org/'), 'URI::ircs');
for my $url (
  'ircs://irc.perl.org/perl',
  'ircs://irc.perl.org:6697/perl',
) {
  my $uri = URI->new($url);
  is $uri->port, 6697,
    "correct port from $url";
  is $uri->canonical->as_string, 'ircs://irc.perl.org:6697/%23perl',
    "correct canonicalization of $url";
}

done_testing;
