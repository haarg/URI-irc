package URI::ircs;
use strict;
use warnings;

use parent 'URI::irc';

sub default_port { 6697 }

sub secure { 1 }

sub canonical {
  my $self = shift;
  my $other = $self->SUPER::canonical(@_);
  if (!$other->_port) {
    $other = $other->clone if $other == $self;
    $other->port($other->port);
  }
  $other;
}

1;
