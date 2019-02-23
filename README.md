### Project Wonyun

In January 2019, upon making some life changing decision, I found an old repo in bitbucket, which was no less than a forgotten project. The source was written for love2d 0.92, which was before love2d officially supported Android. The touch control unfortunately broke and doesn't work as of time of writing.

What shocked me more than most was how shockingly feature-complete this was. Barring some polishing and balancing, a lot of feature is functioning and playable, including multiple weapons, regenerating shield, and the game's signature ability: bullet capture, which signified its central gameplay around ammo management.'

I had a great trip of nolstagia upon finding this and decided to make it public for everyone.



-----------------------------

Project Wonyun, the long lost sequel and prequel to rymdangra saga.


Revamp kaedeni assets

Firing behaviour
bullet capture
Diegetic UI ammo counter

UI distance counter
UI incoming

Bitmap font
Revamp main menu
Revamp result
Revamp pause menu
Revamp main menu background











TODO

typeid and baseid are now a mess


Known bug

Player unpredicatably moves upon starting playState
Android taking Gamepad as initial Input
Bullet capture indicator not lit right away upon start
-- bullets are not recycling [Too few of them. Now there are 700]

-- Dulce from 2101 drops bombs less frequently [Cause we're moving upwards]








Create basic object
Create inheritance
Resize player
Resize bullets
Resize enemy
Movable smokes
Create bitmap fonts

Resize main menu
Resize remaining menu

TODO list

E:generic enemy ship
E:hostile bullets
Gameplay: death and loop
Gameplay: distance counting and finish
Gameplay: fail result screen
Powerup: ammunition
Powerup: shield
-- Above is roughly done

-- Trailer stuff
State: trailerState
GFX: riley
GFX: augustus
GFX: dulce
GFX: hammerhead
GFX: koltar
Decor: tunnel
Decor: tunnel light
Decor: a couple more of sky colors
Decor: distant asteroid shadows
Audio: tunnel light passby
Audio: tunnel light
Audio: dramatic awe upon exiting the tunnel
Decor: gusts of air
Audio: mild engine sound
Entity: meteor
Decor: dust/smoke
Decor: Messsage "incoming meteor"
Audio: dramatic closing sound



Gameplay: keadani individual behaviour and shot round
Gameplay: enemy formation
E:asteroids
E:Large asteroids
Gameplay: intervals
Gameplay: ending
Gameplay: pause menu (resume, abort)
Gameplay: confirm quit screen
-- Game leaves alpha here
P:Screenshake
P:Playership tweening and throttle
P:Explosion
P:Chains explosion
G:Attempt counting
P:Explosion fragments
P:Moving air
Additional: monologue lines
P:Stars
P:Background asteroids
P:Background tunnels and swapping of background colors
Additional: Multiple ammo types (piercing, spread, burst)
Additional: camera and parallax background