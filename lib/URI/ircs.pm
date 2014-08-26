package URI::ircs;
use strict;
use warnings;

use parent 'URI::irc';

sub default_port { 6697 }

sub secure { 1 }

1;
