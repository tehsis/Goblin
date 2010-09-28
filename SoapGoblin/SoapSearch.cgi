#Copyright 2010 Pablo Terradillos <tehsis@gmail.com>
#
# This file is part of "The Goblin search engine".
#
# "The Goblin search engine" is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# "The Goblin Search Engine" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with "The Goblin Search Engine".  If not, see <http://www.gnu.org/licenses/>.


#!/usr/bin/perl

use SOAP::Transport::HTTP;
use Engine;
use strict;
use warnings;

SOAP::Transport::HTTP::CGI
->dispatch_to('SoapSearch')
->handle;

package SoapSearch;


#Just to test the connection.
sub test {

return "Everything Ok \n";

}


#Make the search using the given parameters. Returns an array of Sites
sub search {                    
   my $self = shift;

   my $search = Engine->new;

   my $harr = $search->search(shift);

   my @arr = @$harr;

   my $result = shift @arr;

   return $result;

} 

#Make the search using the given parameters. Returns the
#sites with a XML syntax. 
sub xsearch {
   my $self = shift;

   my $search = Engine->new;

   my $harr = $search->search(shift);

   my @arr = @$harr;


   use Sites;

   my $s = "<engine> \n";

   foreach my $site(@arr) {
     $s        = $s."<site> \n".   
                "<name>".$site->title."</name>\n".
                 "<desc>".$site->desc."</desc>\n".
                 "<url>".$site->url."</url>\n".
                 "</site> \n";
   };

   $s = $s."</engine>\n";


   return $s;

}

#Make the search using the given parameters. Returns the
#sites with a HTML syntax. 
sub hsearch {
   my $self = shift;

   my $search = Engine->new;

   my $harr = $search->search(shift);

   my @arr = @$harr;


   use Sites;

   my $s = "<div id='goblin_results'> \n";

   foreach my $site(@arr) {
     $s        = $s."<div id='goblin_site'> \n".
                "<span class='title'><a href='".$site->url."'>".$site->title."</a></span> <br />\n".
                 "<span class='desc'>".$site->desc."</span> <br />\n".
                 "</div> \n";
   };

   $s = $s."</div>\n";


   return $s;

}

