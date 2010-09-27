#!/usr/bin/perl

use SOAP::Transport::HTTP;
use Engine;
use strict;
use warnings;

SOAP::Transport::HTTP::CGI
->dispatch_to('SoapSearch')
->handle;

package SoapSearch;

sub test {

return "Everything Ok \n";

}

sub search {                    
   my $self = shift;

   my $search = Engine->new;

   my $harr = $search->search(shift);

   my @arr = @$harr;

   my $result = shift @arr;

   return $result;

} 

sub xsearch {
   my $self = shift;

   my $search = Engine->new;

   my $harr = $search->search(shift);

   my @arr = @$harr;

   my $s = "<site>\n";

   use Sites;

   foreach my $site(@arr) {
    $s        =  
                $s."<title>".$site->title."</title>\n".
                 "<desc>".$site->desc."</desc>\n".
                 "<url>".$site->url."</url>\n"
   };

   $s = $s."</site>\n";

   return $s;

}
      
  


