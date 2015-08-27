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

 The interface for this program is built using Ruby Shoes, a simple GUI libary for building desktop application. The code for this program's interface and logic are all contained in the same `rb` file.

  If you want to get an idea of how this program works. I suggest looking at the [`lol-com.rb`](https://github.com/LongPotato/Lol-status/blob/master/lib/lol-com.rb) file, the command-line version. It's way simpler and emphasizes the main functionalities.

  To run the command line version, with Ruby installed, type:

  ```
  $ ruby lol-com.rb
  ```

----

GG easy!


*Lol-status is intended for personal use. This program isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.*
