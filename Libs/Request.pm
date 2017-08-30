package Libs::Request;

use strict;
use warnings;
use Data::Dumper;

sub getRoute;
sub post;
sub isPost;

sub new{
    my $class = ref($_[0])||$_[0];
    return bless{}, $class;
}

sub getRoute{
    my ($self, $route, $default) = @_;
    my ($buffer, @pairs, $pair, $name, $value);
    my %get = ();
    
    # Read get params
    # $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
    # if ($ENV{'REQUEST_METHOD'} eq "GET")
    # {
       $buffer = $ENV{'QUERY_STRING'};
    # }
   
    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);


     foreach $pair (@pairs)
     {
        ($name, $value) = split(/=/, $pair);
       
       $value =~ tr/+/ /;
       $value =~ s/%(..)/pack("C", hex($1))/eg;
  
        $get{$name} = $value;
        
        #if($name==$route){ return $value;}
     }
   
     
      return $get{$route} if exists $get{$route};
      
      return $default;
      
}

sub isPost{
  my ($self) = @_;
  $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
  if ($ENV{'REQUEST_METHOD'} eq "POST")
  {
     return 1;
  }
  return 0;
 }


sub post{
  my ($self, $key, $default) = @_;
  my ($buffer, @pairs, $pair, $name, $value);
  my %post = ();
  
 
  $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
  if ($ENV{'REQUEST_METHOD'} eq "POST")
  {
     read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
  }
  else 
  {
     $buffer = $ENV{'QUERY_STRING'};
  }
  # Split information into name/value pairs
  @pairs = split(/&/, $buffer);
  foreach $pair (@pairs)
  {
     ($name, $value) = split(/=/, $pair);
     $value =~ tr/+/ /;
     $value =~ s/%(..)/pack("C", hex($1))/eg;
     $post{$name} = $value;
  }

  return $post{$key} if exists $post{$key};
      
  return $default;

}
   


   sub get{
    my ($self, $key, $default) = @_;
    my ($buffer, @pairs, $pair, $name, $value);
    my %get = ();
    
    # Read get params
     $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
     if ($ENV{'REQUEST_METHOD'} eq "GET")
     {
       $buffer = $ENV{'QUERY_STRING'};
     }
   
    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);


     foreach $pair (@pairs)
     {
        ($name, $value) = split(/=/, $pair);
       
       $value =~ tr/+/ /;
       $value =~ s/%(..)/pack("C", hex($1))/eg;
  
        $get{$name} = $value;
        
        #if($name==$route){ return $value;}
     }
   
     
      return $get{$key} if exists $get{$key};
      
      return $default;
      
}

1;