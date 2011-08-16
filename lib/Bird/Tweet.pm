#
# Tweet.pm
# created by giginet on 2011/8/16
#
package Bird::Tweet;

$id = 0;

sub new{
  my ($class, $bird, $text) = @_;
  my $self = {
    bird => $bird,
    text => $text,
    created_at => time,
    id=> ++$id,
  };
  return bless $self, $class;
}

sub created_at{
  $self = shift;
  return $self->{"created_at"};
}

sub id{
  $self = shift;
  return $self->{"id"};
}

sub message{
  $self = shift;
  return $self->{"text"};
}

1;
