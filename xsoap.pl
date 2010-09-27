use strict;
use warnings;
use Sites;

use SOAP::Lite;

my $search = SOAP::Lite
->uri('http://localhost/SoapSearch')
->proxy('http://localhost/cgi-bin/Goblin/SoapSearch.cgi')
->xsearch(\@ARGV);

print $search->result;


