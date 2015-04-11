#Lol-status

This is a little program that I make for my favorite game: League of Legends. 

This program calls REST APIs from [Riot games](https://developer.riotgames.com/api/methods) to retrieve information about servers and players status.

The GUI was built by using [Ruby Shoes](http://shoesrb.com) toolkit.

###Features:

* Quick check for server status.
* Display current patch.
* Get in game status, view information about champion, game mode and game length.
* Handsfree: Automatic checking every 3 minutes.
* Look up summoner profile from ['op.gg'](http://www.op.gg) or current game matchup at ['lolnexus'](http://www.lolnexus.com).
* Look up up to 5 summoners at a time.
* Save and load friendlists.

###Download:

* [Mac OS](http://1drv.ms/1DtP3vl)
* [Windows](http://1drv.ms/1DtPaXM)

*First time installation may take serveral minutes. Require [Shoes](http://shoesrb.com/downloads/) to interpret the package file (fyi).*

*Shoes installation is included in the package, so ya you don't need to do anything, just click and run.*

----

###Haw tu use dis 101:

1. Choose your server everytime before a search. It needs to know which region your account belongs to, cus logic.

2. Summoner search is case and space insensitive. That means you can freely type anything, no need to worry about spaces and capital letters in the name.

3. Search up to 5 summoners. Well, you can type more than 5 but it will only display 5 lel. Use commas to separate summoners names.

4. It's not freezing! It's LOADING!. Retrieving information from Rito's server takes time, so go grab a snack or something.

5. Keep both windows open please! Handsfree needs both to run.

6. Save your summoner names to a local text file for your convenience. The next time you fire up the program, just load in the file, no need to set up region or type in names! 

7. Boom! sit back and enjoy stalking people, because of handsfree no need to use your hands ;)

----

###Screenshots:

![1](https://raw.githubusercontent.com/LongPotato/Lol-status/master/pics/pic1.jpg)

![2](https://raw.githubusercontent.com/LongPotato/Lol-status/master/pics/pic2.jpg)

![3](https://github.com/LongPotato/Lol-status/blob/master/pics/p3.jpg)

![4](https://github.com/LongPotato/Lol-status/blob/master/pics/pic4.jpg)


###A little note about the codes:

  This github is where I share my self-learning projects in programming. I want to note that the GUI file for this program, `lol-status` is very messy, and have bad code practices: such as global varibles over uses, repeated codes...

  Ruby Shoes itself has different elements, code blocks that refer to different 'self' objects. Therefore if a variable goes out of scope even if it is initialized, it will be lost. I did not plan ahead to prepare my commandline codes for this issue because I eager to make the GUI to work as soon as possible. The fastest way to approach this problem is to make variables become class variables. Which act as global variables, never change between objects. 

  If you want to get an idea of how this program works. I suggest looking at the [`lol-com.rb`](https://github.com/LongPotato/Lol-status/blob/master/lib/lol-com.rb) file. It's way simpler and emphasizes the main functionalities.

  To run the command line version, with Ruby installed, type:

  ```
  $ ruby lol-com.rb
  ```




GG easy!


*Lol-status is intended for personal use. This program isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.*










