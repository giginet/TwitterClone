#
# Tweet.pm
# created by giginet on 2011/8/16
#
package Bird::Tweet;
#use DateTime;

sub new{
  my ($class, $bird, $text) = @_;
  my $self = {
    bird => $bird,
    text => $text,
#    created_at => DateTime->new( time_zone => 'local' )
  };
  return bless $self, $class;
}

sub text{
  $self = shift;
  return $self->{"text"};
}

1;
