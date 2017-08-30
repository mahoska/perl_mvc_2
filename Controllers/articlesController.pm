package Controllers::articlesController;

use strict;
use warnings;


sub showAllAction;

sub new{
    my $class = ref($_[0])||$_[0];
    return bless{}, $class;
}


sub showAllAction
{
 my ($self, $request) = @_;

 return "Hello from controller";
}

1;
