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
  my ($self, $other) = @_;
  push(@{$self->{"followings"}}, $other);
}

sub following{
  my $self = shift;
  return @{$self->{"followings"}};
}

sub name{
  my $self = shift;
  return $self->{"name"};
}

sub friend_timeline{
  my $self = shift;
  my @tweets = @{$self->{"tweets"}};
  foreach ($self->following){
    push(@tweets, @{$_->{"tweets"}});
  }
  $self->_quick_sort(\@tweets, 0, $#tweets);
  my @timeline;
  foreach (@tweets){
    push(@timeline, $_->text);
  }
  return reverse @timeline;
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

sub unfollow{
  my ($self, $other) = @_;
  my @followings = @{$self->{"followings"}};
  my $count = @followings;
  foreach (0..($count-1)){
    if ($followings[$_]->name eq $other->name){
      splice(@{$self->{"followings"}}, $_, 1);
      last;
    }
  }
}

sub _quick_sort(){
  my ($self, $values, $begin, $end) = @_;
  my ($i, $j, $pivot);
  if ($begin < $end) {
    ($i, $j) = ($begin, $end);
    $pivot = $values->[($begin+$end)/2]->id;
    while($i <= $j){
      ++$i while ($values->[$i]->id < $pivot);
      --$j while ($values->[$j]->id > $pivot);
      if ($i <= $j) {
        ($values->[$i], $values->[$j]) = ($values->[$j], $values->[$i]);
        ++$i, --$j;
      }
    }
    $self->_quick_sort($values, $begin, $j);
    $self->_quick_sort($values, $i, $end);
  }
}

1;
