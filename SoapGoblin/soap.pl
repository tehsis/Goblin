use strict;
use warnings;
use Sites;

use SOAP::Lite;

my $search = SOAP::Lite
->uri('http://localhost/SoapSearch')
->proxy('http://localhost/cgi-bin/Goblin/SoapSearch.cgi')
->search(\@ARGV);

my @sites = $search->paramsout;

push(@sites,$search->result); 


foreach my $result(@sites) {
print $result->title."\n";
print $result->desc."\n";
print $result->url."\n";
}

