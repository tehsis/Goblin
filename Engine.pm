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

package Engine;

use strict;
use warnings;

use Sites;

sub new {
	my $class = shift;
	
	my $self = {
		sites => [],
	};
	
	bless($self,$class);
	
	return $self;
}

sub search { 
	my $self = shift;
	
	if(@_) {
		use db;
		my $host = "localhost:27017";
		my $db = db->new;
		$db->connectMongo($host);
		
		my $cursor = $db->search({TAGS => {'$all' => @_}});
		
		foreach my $object ($cursor->next) {
			my $tempSite = Sites->new($object->{URL},$object->{TITLE},
			$object->{DESC},$object->{TAGS});
			
			push(@{$self->{sites}},$tempSite);
		}
	}
	
	return $self->{sites};
} 

1;
