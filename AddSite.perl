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
# along with "The Goblin search engine".  If not, see <http://www.gnu.org/licenses/>.

 use strict;
 use warnings;
 
 
 print "Please wait while we add the site...";
 store(shift);
 print "Done! \n";

 sub store { 
 	#TODO: Make this sub cleaner. Actually is a mess. 
 	
 	#This makes a new site and store it into a MongoDB.
 	#The data needed is extracted from the site itself.
 	#If one of the site attributes is not available,
 	#site's url will be used.
 	
 	use Sites;
 	use Fetcher;
 	use db;
 	
 	my $url = shift;
 	
 	my $nsite = Sites->new;
 	$nsite->url($url);
 	
 	my $fetch = Fetcher->new;
 	
 	$fetch->content($nsite->url);
 	
 	(my $ht,my $ntags) =  ($fetch->content =~ m!<meta (name=['"]keywords['"] content=["'](.+)["'])|
 	                      (content=["'](.+)["'] name=['"]keywords['"])!i);
 	                      
 	($ntags) = $nsite->url =~ m!http://(.+)! unless $ntags;
 	                      
 	
 	($ht,my $ndesc) = ($fetch->content =~ m!<meta (name=["']description["'] content=['"](.+)["'])|
 	                    (content=['"](.+)["'] name=["']description["'])!i);
 	                    
 	 $ndesc = $nsite->url unless $ndesc;
 	
 	
 	($ht, my $tag, my $ntitle) = $fetch->content =~ m!(<meta (name=["']Title["'] content=["'](.+)["'])|
 	               (content=["'](.+)["'] name=["']title["']))!i;
 	               
 	$ntitle = $fetch->content =~ m!<title>(.+)</title>!i unless $ntitle;
 	
 	$ntitle = $nsite->url unless $ntitle;
 	
 	
 	$nsite->title($ntitle) unless not defined $ntitle;
 	$nsite->desc($ndesc) unless not defined $ndesc;
    $nsite->tags($ntags) unless not defined $ntags;	
    
    my $db = db->new();
    $db->data($nsite->self());
    return $db->save("localhost:27017");
 	
 	} 


 1; 
