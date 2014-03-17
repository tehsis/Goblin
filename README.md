The Goblin search engine
=

Introduction
-

The "Goblin Search Engine" started as a project which it main goal
was to aim me in my own way to learning Perl.
Actually, it have been separated in two. The Goblin Server and Client.
In order to communicate each other, Goblin Server and Client relies in 
SOAP. Read below to get into details of each one.



Goblin Server
=

Description
-
  
  The "Goblin Server" pretends to be an "Open search engine"
which you could install or modify so you can use it for your
own project.
  To get it working you need an http server with perl support
(look below for libs dependencies)
  Actually, it relies on MongoDB. So you'll need it working
if you want to use this.

  Remember that Goblin (for now) comes with no indexed sites.
You must add some sites with "addSite.pl" script if you
want to see something working.
  As i've said before, Goblin relies in MongoDB. Actually,
it doesn't make searches more sophisticated than a simple
"search by tags". This will be improved in the future,
but for now is not more than that.

  Last but not least, for now it is on a HEAVY development
state and is distributed with no more goals than you
can mess with it and test it, so if you are not
interested in development, i recommend you to look for
another solution.

Installation
-

  Just copy the files included in SoapServer folder to
a working http server path (it has been tested with
lighttpd and Apache2). 
Remember that your http server must have perl support
with the following libs:
 
LWP
MongoDB
SOAP::Lite

To add a site to the database, just run "AddSite.pl http://weburl.com"
and it will take the title, description and tags from the site.
(This is not very well implemented now, but have to work with most
"well formed" sites)


Goblin Client
=

Description
-  

It is just an API to make searches using the Goblin Server.
It use SOAP to make the connection between both Goblins.
 Also, i provided a "test.php" example if you want to see how 
to use it. For now, is not more complicated than instantiate
a "GoblinClient" object, make the search using the
search($tags) method and show the results with found().

Example:

```php
  <?php
     require("goblinclient.php");
 
     $uri = 'http://my.soap.services.com/Goblin';
     $host = 'http://my.soap.services.com/GoblinServer/Goblin.cgi';
     $tags = 'linux development'; //it will look for those sites with both, linux and development tags
     
     $c = new GoblinClient($uri,$host);
    
     $c->search($tags);

     print $c->found();

  ?>
```

