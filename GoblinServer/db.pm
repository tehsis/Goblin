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

package db;

use MongoDB;

sub new {
  my $class = shift;	
  my $self = {
    engine => undef,
    data => {},
    coll => undef,
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
  my $id = $self->{coll}->insert($self->{data});	
  return $id;
}

sub exists {
  my $self = shift;
  if(@_) {
  my $search = shift;
    return 1 if $self->{coll}->find_one($search);	
  }
  return 0;
}

sub search {
  my $self = shift;
  if(@_) {
    return $self->{coll}->find(shift);
  }
  return 0;
}

sub self {
  my $self = shift;
  return $self;
}

sub connect {
  $self = shift;
  if(@_) {
    my $engine = shift; 
    my $host = (shift or "localhost:27017");
    my $conn = MongoDB::Connection->new("host" => $host) if ($engine = "mongodb");
    my $db = $conn->sengine;
    return 1 if $self->{coll} = $db->sites;
  }
  return 0;
}
1;

