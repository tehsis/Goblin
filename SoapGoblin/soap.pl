use strict;
use warnings;
use Sites;

use SOAP::Lite;

my $ns = 'http://localhost/SoapSearch';
my $host = 'http://path/to/SoapSearch.cgi';

my $search = SOAP::Lite
->uri($ns)
->proxy($host)
->search(\@ARGV);

my @sites = $search->paramsout;

push(@sites,$search->result); 


foreach my $result(@sites) {
print $result->title."\n";
print $result->desc."\n";
print $result->url."\n";
}

