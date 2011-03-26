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

# This package describes a website using the elements that 
# Goblin can handle.


package Sites;

use strict;
use warnings;

sub new {
  my $class = shift;
  my $self = {
    TITLE => undef,
    URL => undef,
    DESC => undef,
    TAGS => [],
  };
  bless($self);
  if(@_) {
    $self = {
      URL => $self->url(shift),
      TITLE => $self->title(shift),
      DESC => $self->desc(shift),
      TAGS => $self->tags(shift),
    };
  }
  bless($self,$class);
  return $self;
}


sub title {
  my $self = shift;
  if(@_) { $self->{TITLE} = shift}
  return $self->{TITLE};
}

sub url {
  my $self = shift;
  if(@_) {
    my $correcturl = shift;
    # Adds "http://" if url doesn't have it
    $correcturl = "http://".$correcturl if $correcturl !~ m!^http://!; 
    #Discards any malformed url
    return undef unless $correcturl =~ m!(^(http://)([(\w|\d|\-)]+[.][(\w|\d)]+)+$)!;
    $self->{URL} = $correcturl;
  }
  return $self->{URL};
}

sub desc {
  my $self = shift;
  if(@_) { $self->{DESC} = shift}
  return $self->{DESC};
}

sub tags {
  my $self = shift;
  if(@_) { 
    push(@{$self->{TAGS}},split(/\s*,\s*/,shift)); 
  }
  return @{$self->{TAGS}};
}

sub self {
  my $self = shift;
  return $self;
}

1;
