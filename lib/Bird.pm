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

sub friends_timeline{
  my $self = shift;
  my @tweets = @{$self->{"tweets"}};
  foreach ($self->following){
    push(@tweets, @{$_->{"tweets"}});
  }
  $self->_quick_sort(\@tweets, 0, $#tweets);
  @tweets = reverse @tweets;  
  return \@tweets;
}

sub tweet{
  my ($self, $message) = @_;
  my $tweet = Bird::Tweet->new($self, $message);
  unshift(@{$self->{"tweets"}}, $tweet);
}

sub timeline{
  my $self = shift;
  my $timeline = $self->{"tweets"};
  return $timeline;
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
