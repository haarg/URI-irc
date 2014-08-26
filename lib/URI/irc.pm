package URI::irc;
use strict;
use warnings;

use URI::Escape qw(uri_escape uri_unescape);
use URI::QueryParam;

use parent 'URI::_server';

sub default_port { 6667 }

sub canonical {
  my $self = shift;
  my $other = $self->SUPER::canonical;

  if (my $channel = $other->channel) {
    $other = $other->clone if $other == $self;
    $other->channel($channel);
  }
  $other;
}

sub channel {
  my $self = shift;
  if (@_) {
    my $channel = shift;
    $channel =~ s/^(?![#~!+])/#/;
    $self->path('/'.uri_escape($channel));
    $self->fragment(undef);
    $self->query_param_delete('channel');
    return $channel;
  }

  my $path = $self->path;
  $path =~ s{^/}{};
  my $channel = $self->fragment || $self->query_param('channel') || uri_unescape($path);
  $channel =~ s/^(?![#~!+])/#/;
  return $channel;
}

1;
