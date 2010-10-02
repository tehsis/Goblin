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

 use strict;
 use warnings;
 
 
 print "Please wait while we add the site... \n";
 if(store(shift)) {
  print "Done! \n";
 } else {
 	print "Couldn't add the new site. Are you running MongoDB and is a new site? \n";
 }

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
 	
 	my $host = "localhost:27017";
 	
 	
 	my $nsite = Sites->new; $nsite->url($url);
 	my $ntags = undef;
 	my $ntitle = undef;
 	my $ndesc = undef;
 	
 	my $fetch = Fetcher->new;
 	
 	$fetch->content($nsite->url);
 	
 	#Looks for tags
 	($ntags) =  $fetch->content =~ m!content=["']\s*(.+)\s*["'] name=['"]keywords['"]!i;
 	($ntags) =  $fetch->content =~ m!<meta name=['"]keywords['"] content=["']\s*(.+)\s*["']!;
 	                      
 	
 	#Looks for description
 	($ndesc) = $fetch->content =~ m!['"](.+)["'] name=["']description["']!i;
 	($ndesc) = $fetch->content =~ m!<meta name=["']description["'] content=['"](.+)["']!;
 	
 	#looks for title
 	($ntitle) = $fetch->content =~  m!content=["'](.+)["'] name=["']title["']!i;
 	($ntitle) = $fetch->content =~ m!<meta name=["']Title["'] content=["'](.+)["']!;
 	($ntitle) = $fetch->content =~ m!<title>\n*(.+)\n*</title>!i unless $ntitle;
 	
 	#If any of the previously looked site's attribute were not found, 
 	#it assign the url.
 	
 	$ntitle = $nsite->url unless $ntitle;
 	$ndesc = $nsite->url unless $ndesc;
 	($ntags) = $nsite->url =~ m!http://(.+)! unless $ntags;
 	
 	$nsite->title($ntitle);
 	$nsite->desc($ndesc);
    $nsite->tags($ntags);	
    
    my $db = db->new();
    $db->data($nsite->self());
    $db->connectMongo($host);
    
    return $db->save unless $db->exists({ URL => $nsite->url});
    
    return 0;
    
 	} 


 1; 
