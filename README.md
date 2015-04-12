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

* [Mac OS](http://1drv.ms/1azOUeh)
* [Windows](http://1drv.ms/1azOYuC)
* Windows 8: Download [Shoes](http://shoesrb.com/downloads/) and download this [.shy](http://1drv.ms/1HgSY04) file, then open it with Shoes.



*First time installation may take serveral minutes. Require [Shoes](http://shoesrb.com/downloads/) to interpret the package file (fyi).*

*Shoes installation is included in the package, so ya you don't need to do anything, just click and run.*

----

###Haw tu use dis 101:

1. Choose your server everytime before a search. It needs to know which region your account belongs to, cus logic.

2. Summoner search is case and space insensitive. That means you can freely type anything, no need to worry about spaces and capital letters in the name.

3. Search up to 5 summoners. Well, you can type more than 5 but it will only display 5, lel. Use commas to separate summoners names.

4. It's not freezing! It's LOADING!. Retrieving information from Rito's server takes time, so you have plenty of time to practice blinking eyes.

5. Keep both windows open please! Handsfree transfers information between these windows. It needs both to run.

6. Save your summoner names to a local text file for your convenience. The next time you fire up the program, just load in the file, no need to set up region or type in names! 

7. Boom! sit back and enjoy stalking people. With the help of Handsfree looping feature, your hands are freed from typing, use it for something else ;)


----

###Screenshots:

![1](https://raw.githubusercontent.com/LongPotato/Lol-status/master/pics/pic1.jpg)

![2](https://raw.githubusercontent.com/LongPotato/Lol-status/master/pics/pic2.jpg)

![3](https://raw.githubusercontent.com/LongPotato/Lol-status/master/pics/pic3.jpg)

![4](https://raw.githubusercontent.com/LongPotato/Lol-status/master/pics/pic4.jpg)


###A little note about the codes:

  This github is where I share my programming projects. I want to note that eventhough the program runs fine, the GUI file for this program, [`lol-status`](https://github.com/LongPotato/Lol-status/blob/master/lib/lol-status.rb) is very messy, and have bad code practices: such as overuse of global variables, repeated codes...

  Ruby Shoes itself has different elements, code blocks that refer to different 'self' objects. Therefore if a variable goes out of scope even if it is initialized, it will be lost. I did not plan ahead to prepare my command line codes for this issue and I was too eager to make the GUI to work as soon as possible. The fastest way that I chose to approach this problem is to make variables become class variables. Which act as global variables, never change between objects. In my opinion it's a bad habit.

  If you want to get an idea of how this program works. I suggest looking at the [`lol-com.rb`](https://github.com/LongPotato/Lol-status/blob/master/lib/lol-com.rb) file. It's way simpler and emphasizes the main functionalities.

  To run the command line version, with Ruby installed, type:

  ```
  $ ruby lol-com.rb
  ```

----

GG easy!


*Lol-status is intended for personal use. This program isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.*