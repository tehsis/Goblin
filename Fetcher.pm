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

package Fetcher;

use strict;
use warnings;

sub new {
	my $class = shift;
	
	my $self = {
		url => undef,
		content => undef,
	};
	
	bless($self,$class);
	
	return $self;
}

sub content {
	my $self = shift;
	
	if(@_) {
	use LWP::UserAgent;
	$self->{url} = shift;
	
	my $ua = LWP::UserAgent->new;
	
    my $response = $ua->get($self->{url});
    
    $self->{content} = $response->decoded_content;
	
	}
	
	return $self->{content};
	
} 

1;