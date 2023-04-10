package Cards;
use v5.36;
use Exporter 'import';
our @EXPORTER_OK = qw(Card Dealer);


our @COLORS = qw(heart diamond spade club);
our @VALUES = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13);
our @FACES = ("A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K");



package Card;
use Moose;
use utf8;
use Term::ANSIColor;

has 'face', (is => 'ro', => isa => 'Str');
has 'value', (is => 'ro', => isa => 'Num');
has 'col', (is => 'ro', isa => 'Str');


sub present($self) {
    binmode(STDOUT, ":utf8");
    print $self->face;
    if ($self->col eq "heart") {
	print colored("\N{BLACK HEART SUIT} ", 'red');    # ♥
    } elsif ($self->col eq "diamond") {
	print colored("\N{BLACK DIAMOND SUIT} ", 'blue'); # ♦
    } elsif ($self->col eq "spade") {
	print colored("\N{BLACK SPADE SUIT} ", 'yellow'); # ♠
    } elsif ($self->col eq "club") {
	print colored("\N{BLACK CLUB SUIT} ", 'magenta'); # ♣
    }
}


no Moose;
__PACKAGE__->meta->make_immutable;

# --- Deck ---
package Deck;
use Moose;

has 'cards', (traits => [ 'Array' ],
	      is => 'ro',
	      isa => 'ArrayRef[Card]',
	      default => sub { [] },
	      handles => {
		  push_card => 'push',
		  burn_card => 'pop',
		  deal_card => 'pop',
		  no_card   => 'is_empty',
	      });

no Moose;
__PACKAGE__->meta->make_immutable;


# --- Dealer ---
package Dealer;
use Moose;
use List::Util 'shuffle';
use Card;

has 'name', (is => 'ro', isa => 'Str');
has 'deck', (is => 'ro', isa => 'Deck', builder => '_shuffled_deck');

sub _ordered_deck($self) {
    my @deck = ();
    foreach my $col (@COLORS) {
	foreach my $v (@VALUES) {
	    #print "-debug- $col $v ", $FACES[$v-1], "\n";
	    my $card = Card->new(
		face => $FACES[$v-1],
		col => $col,
		value => $v
		);
	    push @deck, ($card);
	}
    }
    return @deck;
}

sub _shuffled_deck($self) {
    my @shuffled = shuffle($self->_ordered_deck);
    return \@shuffled;
}




no Moose;
__PACKAGE__->meta->make_immutable;

#___
1;
