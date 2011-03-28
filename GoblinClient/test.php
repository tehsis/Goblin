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

<!-- IMPORTANT: This file was made only for testing porpuses -->

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

// Check this data in order to get the example working.
$proxy ="http://localhost/GoblinServer/Goblin.cgi";
$uri = "http://localhost/Goblin";

require('goblinclient.php');

$c = new GoblinClient($uri,$proxy);

if ($_GET) {
  $search = $_GET['search'];
  $c->search_memcache($search); //To search without memcache just use search
  print $c->found();
  print "<span style='background-color: #eaf666;'> <em>La b&uacute;squeda llev&oacute;: <strong>".$c->time()."</strong> segundos</em></span>";
}

?>

</body>
</html>

