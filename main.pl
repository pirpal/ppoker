#!/usr/bin/perl

use v5.36;

use lib '.';
use Cards;
use Player;
use List::Util 'shuffle';

sub print_deck(@deck) {
    my $count = 0;
    foreach (@deck) {
	if ($count % 13 == 0) {
	    print "\n";
	}
	$_->present;
	$count += 1;
    }
    print "\n";
}


my @ply_names = qw(Alice Bob Charlie Denise \
		   Eugene Fish Gina);
push(@ply_names, $ENV{USER});
@ply_names = shuffle(@ply_names);

my @players = ();
foreach (@ply_names) {
    my $p = Player->new(
	name  => $_,
	money => 1000);
    push(@players, $p);
}

foreach (@players) {
    $_->log(1);
}

my $tux = Dealer->new(name => "Tux");
my $popped = $tux->deck->remove_card;
print "Tux has popped a Card from his Deck:\n"
$popped->present;




print "\n\n";
#____________
