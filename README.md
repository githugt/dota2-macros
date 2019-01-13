# dota2-macros
Just some macros for some of the harder to use heroes in the game DOTA2.
Will add a proper section on instructions (with pictures) on how to use this set of macros.

The idea of this is basically to make the mechanically harder to play heroes
by automating the simply mechanical part via automation (In this case autohotkey macros. 
Might use lua as well, if I feel the need for it.)

# Invoker (Simple set of instructions)
- Space + Q : Invoke Cold Snap  
- Space + W : Invoke EMP  
- Space + E : Invoke Sun Strike  

- Space + Z : Invoke Tornado  
- Space + X : Invoke Chaos Meteor  
- Space + C : Invoke Deafening Blast  
- Space + V : Invoke Ice Wall  
- Space + R : Invoke Ghost Walk  
- Space + B (Panic Button) : Invoke Ghost walk, Cast Ghost Walk  
- Space + T : Invoke Alacrity  
- Space + F : Invoke Forge Spirits  

By default, after all invocations, it will also invoke all 3 instances of Wex.
To either change this behaviour to cast Exort instead, is very easy. You can easily disable
this behaviour as well.


On pressing enter, the script will suspend itself (so that you can type without issues).
If you press escape (added because sometimes I cancel the message box after pressing enter once),
it will unsuspend the script back.

- Numpad 5 : Toggle script suspension  
- Numpad 1 : Reload Script  
- Pause (This is the button - Pause, not in-game pause) : Suspend Script  
- Numpad 2 : Unsuspend Script  
- Numpad 9 : Kill Script (You will have to manually start script again, if you want it).  

# Meepo
- Space + Q : Toggle Earth Binds (Q is expected to be set to quick-cast)  
- R : Poof all meepos  
- Space + R : Poof all except main meepo  
- E : Blink Main meepo , Use Blink Guinsoo and one more item (all these items are togglable)  
- Space + E : Blink All meepos , Use Blink Guinsoo and one more item (all these items are togglable)  
- Numpad Add (+) : Click this, when number of meepos increases. i.e When you level up your ultimate,
	when you add aghas, when you get an image rune. Note that max possible meepos is set to 7.
	Therefore you cannot really have all meepos + aghas + manta + illusion rune.  
- Numpad Sub (-) : Click this to reduce the number of meepos.  
- Numpad 7 : Toggle blink status  
- Numpad 8 : Toggle Guinsoo status  
- Numpad 9 : Toggle Item 3 status - usually Ethereal / Bloodthorn  
- Numpad 4 : Toggle Aghas status  
- Numpad 6 : Toggle manta / Illusion satus  


# WIP 
* The meepo script suspension part is pretty much work in progress. Since the invoker part is working as I want it to, I'll probably copy that bit.
* Need to cleanup meepo script. I've kept a helpful function incase you want to debug some stuff (small GUI)
* Invoker : Might want to move things around, so that code is more readable and easier to understand.
	Also, might rewrite it, as I don't really want to use all those Gosubs.
* Add some pictures and small videos/gifs, to explain these macro a bit better.
* I'll probably add Earth-Spirit as well, because I find the guy quite hard to play. :/
* I'll also probably add Tinker as well, because I'm a filthy Tinker-spammer.

# Why?
* Sometimes, when I play Invoker, I goof up my button combos in the thick of a team-fight because I might 
	not remember the exact button sequence for a particular spell / sometimes I click too fast, and the game
	doesn't really register, due to which I end up casting the wrong spell, and that basically means a lost
	fight. Seems like a case of bad UX to me. I want to make playing this hero easier.
* My friends say that they have a hard time playing meepo, because they can't seem to quickly do the blink 
	+ Earthbind + Tab + w + Tab + w + Tab + w + Tab + Use item1, item2, item3. DOTA is already a hard game.
	Might as well, make some of these characters a little bit easier.
* People with fancy mice have such functionality built in, into the mice, where you can program such
	functions pretty easily. AFAIK such macros are not considered cheating. Valve did disable macros through source, but have not been clear wrt macros.

# Additional Notes
* Please don't hold me responsible for any infractions that you may have to shoulder because of using these macros. You hold all responsibility for these problems.
* This release is also alpha, I basically wrote this in a few hours time, and didn't exactly get time to test all scenarios, combinations. 
* Everything is VERY opinionated as of now. I've written things so that most of it is easily configurable. But yes, this will probably continue to remain super-opinionated.
* Although pretty much the entire thing has been re-written, some of the initial bits have been taken from some other projects, I need to credit them for their efforts.
* There is a lot of cleanup that needs to be done - especially for the meepo one.