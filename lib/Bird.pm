#
# Bird.pm
# created by giginet on 2011/8/16
#
package Bird;
use strict;
use warnings;
use Bird::Tweet;

sub new{
  my $class = shift;
  my (@tweets, @followings);
  my %args = (
    name => "anonymous",
    @_
  );
  my $self = {
    name => $args{'name'},
    tweets => \@tweets,
  followings => \@followings,
  };
  return bless $self, $class;
}

sub follow{
}

sub friend_timeline{
}

sub tweet{
  my ($self, $text) = @_;
  my $tweet = Bird::Tweet->new($self, $text);
  unshift(@{$self->{"tweets"}}, $tweet);
}

sub timeline{
  my $self = shift;
  my @timeline = @{$self->{"tweets"}};
  my @tweets;
  foreach (@timeline){
    push(@tweets, $_->text);
  }
  return @tweets;
}

1;
