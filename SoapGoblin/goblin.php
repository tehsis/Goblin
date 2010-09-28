<!-- #Copyright 2010 Pablo Terradillos <tehsis@gmail.com>
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
# along with "The Goblin Search Engine".  If not, see <http://www.gnu.org/licenses/>.
-->

<!-- This file was made only for testing porpuses -->

<html>
<head>
<title>Goblin Search Engine - Web client</title>
<body>
<h1>The Goblin Search Engine (Beta)</h1>
<form>
<input type="text" name="search" id="search" />
<input type="submit" value="Search with Goblin" />
</form>

<?php

$client = new SoapClient(null,array("location"=>"http://localhost/Goblin/SoapSearch.cgi","uri"=>"http://localhost/SoapSearch"));

$search = explode(" ",($_GET['search']));


print $client->hsearch($search);

?>

</body>
</html>
