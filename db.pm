#Copyright 2010 Pablo Terradillos <tehsis@gmail.com>
#
# This file is part of "The Goblin search engine".
#
# "The Goblin search engine" is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
#  "The Goblin search engine" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

package db;

sub new {
	my $class = shift;
	
	my $self = {
		data => {},
	};
	
	bless($self,$class);
	
	return $self;
}

sub data {
	my $self = shift;
	
	if(@_) {
		$self->{data} = shift;
	}
	
	return $self->{data};
}

sub save {
	my $self = shift;
	
	if(@_) {
	 use MongoDB;
	 my $host = shift;
	 my $conn = MongoDB::Connection->new("host" => $host);
	 my $db = $conn->sengine;
	 my $coll = $db->sites;
    my $id = return $coll->insert($self->{data});	
    
    return $id;
	}
	
	return 0;
}

1;
