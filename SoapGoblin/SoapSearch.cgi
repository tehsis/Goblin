#Copyright 2010 Pablo Terradillos <tehsis@gmail.com>
#
# This file is part of "The Goblin search engine".
#
# "The Goblin search engine" is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# "The Goblin search engine" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.


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

   my $class = shift;

   my $search = Engine->new;

   my $harr = $search->search(@_);

   my @arr = @$harr;

   my $result = shift @arr;

   return $result;

} 
