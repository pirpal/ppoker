#!/usr/bin/perl

package Player;
use v5.36;
use Moose;
use Cards;
use Term::ANSIColor;
use Exporter 'import';
our @EXPORT_OK = qw(Player);


has 'name', (is => 'ro', isa => 'Str'); 
has 'money', (is => 'rw', isa => 'Num');
has 'cards', (is => 'rw',
	      isa => 'ArrayRef[Card]',
	      default => sub { [] });


sub log($self, $debug) {
    my $p = \$self;
    print "[ Player $p '", $self->name, "'\n";
    print "  ", int($self->money), " \$ ";
    if (@{$self->{cards}} != 0) {
	foreach (@{$self->{cards}}) {
	    $_->present;
	}
    } else {
	print colored("? ? ", 'red');
    }
    print "]\n";
}


no Moose;
__PACKAGE__->meta->make_immutable;

#___
1;


