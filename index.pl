#!"C:\xampp\perl\bin\perl.exe"

use strict;
use warnings;
use Data::Dumper;

use File::Basename qw(dirname);
use lib dirname(__FILE__).'/Views/';
use lib dirname(__FILE__).'/Libs/';
use lib dirname(__FILE__).'/Controllers/';
use CGI::Carp qw(fatalsToBrowser); 

use Libs::Request;

use vars qw($loyout $content $error);

my $request = Libs::Request->new();
my $route_str = $request->getRoute('route','articles/showAll');
  
my @route = split m|/|, $route_str;
my $route_size = @route;
 if($route_size <2)
 {
	 @route = qw(articles/showAll);       #redirect from articles/showAll
 }	
my $controller = $route[0].'Controller';	
my $action = $route[1].'Action';

eval
{
     require $controller.".pm";
     my $controller_class = "Controllers::$controller";
     $controller = $controller_class->new();
    
     #if method exists
     if($controller->can($action))
     {
	$content = $controller->$action($request);
	
	 require 'layout.pl';
         print "Content-type: text/html; charset=utf-8\n\n";
         print $loyout;
     }
     else
     {
	  print "Content-type: text/html; charset=utf-8\n\n";
	  require 'error.pl';
	  print $error;
      }
     
 };
 if($@)
 {
     print "Content-type: text/html; charset=utf-8\n\n";
     require 'error.pl';
     print $error;
  
 }

