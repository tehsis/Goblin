<?php
/*
 * Name: The Goblin Search Client
 * Author: Pablo E. Terradillos <tehsis@gmail.com>
 * Description: This is (or try to be) an API Client for The Goblin Search Engine.
 * It relies on the SOAP interface.
 *
 * Copyright 2010 Pablo Terradillos <tehsis@gmail.com>
 *
 * This file is part of "The Goblin search engine".
 *
 * "The Goblin search engine" is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * "The Goblin Search Engine" is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with "The Goblin Search Engine".  If not, see <http://www.gnu.org/licenses/>.
 *
 */


class GoblinClient {
  private $client;
  private $found;
  private $time;

// To make a new Client object, you need to provide the uri and proxy of
// the Soap server 
  public function __construct($uri,$proxy) {
    $this->client = new SoapClient(null,array("location"=>$proxy,"uri"=>$uri));
  }

  public function search($tags) {
    $timeBefore = microtime(true);
    $this->found = $this->client->hsearch(explode(" ",$tags));
    $timeAfter = microtime(true);
    $this->time = $timeAfter - $timeBefore; 
    return $this->found;
  }

  public function search_memcache($tags) {
    $timeBefore = microtime(true);
    $memcache_obj = new Memcache;
    $memcache_obj->connect('localhost',11211);
    if(strcmp($memcache_obj->get('LastTag'),$tags) == 0) {
      $this->found = $memcache_obj->get('search');
    } else {	
      $memcache_obj->replace('LastTag', $tags,0,0);
      $this->found = $this->client->hsearch(explode(" ",$tags));
      $memcache_obj->set('search',$this->found,0,0);
    }
      $timeAfter = microtime(true);
      $this->time = $timeAfter - $timeBefore;
      return $this->found;
    }

    public function found() {
      return $this->found;
    }

    public function time() {
      return $this->time;
    }
}
