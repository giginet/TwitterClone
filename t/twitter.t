#
# twitter.t
# created by giginet on 2011/8/16
#
package test::Twitter;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Bird;

sub init : Test(1){
  new_ok 'Bird';
}

sub follow :Tests{
  my $bird0 = Bird->new(name => "Kaname Madoka");
  my $bird1 = Bird->new(name => "Miki Sayaka");
  $bird0->follow($bird1);
  is_deeply [$bird0->following], [$bird1], "followできるかどうか";
  $bird0->unfollow($bird1);
  is_deeply [$bird0->following], [], "unfollowできるかどうか";
}

sub show_friends_timeline :Tests{
  my $bird0 = Bird->new(name => "QB");
  my $bird1 = Bird->new(name => "Kaname Madoka");
  my $bird2 = Bird->new(name => "Tomoe Mami");
  $bird0->tweet("僕と契約して魔法少女になってよ！");
  $bird1->tweet("そんなの絶対おかしいよ");
  $bird2->tweet("もう何も恐くない");
  $bird0->follow($bird2);
  is $bird0->friends_timeline->[0]->message, "もう何も恐くない", "つぶやきが新しい順に並ぶ";
  $bird2->tweet("わけがわからないよ");
  $bird0->follow($bird1);
  is $bird0->friends_timeline->[0]->message, "わけがわからないよ", "つぶやきが新しい順に並ぶ";
  is $bird0->friends_timeline->[2]->message, "そんなの絶対おかしいよ", "つぶやきが新しい順に並ぶ";
}

sub tweet : Tests{
  my $bird = Bird->new(name => "Akemi Homura");
  $bird->tweet("ほむほむ");
  is_deeply $bird->timeline->[0]->message, "ほむほむ", "つぶやいてタイムラインが取得できるか";
  
}

__PACKAGE__->runtests;

1;
