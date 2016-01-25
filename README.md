# FinalProjectFall2015-BillyWongMatthewZhu #

# Directions to use #
1) Go to Pokemon Folder and open Pokemon.pde
2) Click the play button
3) Use "z" for ok and "x" for cancel/go back and use the arrow keys to go up,left,right,down, with respect to the arrows
4) Choose 3 pokemon to use for your team( You may scroll down for more since menu does not have a scroll bar)
5) Choose an opponenet difficulty(Easy,Normal,Hard)
6) "Fight" allows you to use one of four moves your pokemon has, press z to use it or x to go back to the previous menus.
7) "Pkmn" allows you to swap pokemon, press z to choose the pokemon you wish to swap into or x to go back to the previous menu.
8) Run and Item are not inplemented and therefore will not be used.
9)To win, you need to defeat Professor Oak. 

# CURRENT BUGS: #
-If an critical hit causes a Pokemon to faint, the last bit of text is skipped over and goes straight to faint

# NITPICKS #
-Program currently uses a decent amount of memory since it loads image and prints text over and over


# NEXT PLANS #
-Program cpu usage fix
-Add flinching
-Add healing
-Work on Hard AI information storage

# CHANGELOG #


## 1/24/16 ##
-Added Pokemon selection screen
-Fixed major bugs with AI_switching
-Fixed major bugs with AI_attacking
-AI now chooses when it is optimal to attack/heal/buff
-AI no longer switches 24/7

## 1/23/16 ##
-Fixed Explosion Bug\n
-Worked on collect info method for Hard AI (Fixed bug for storePokemon and finished storeAttack)

## 1/22/16 ##
-added StoreAttacks for AI\n
-Started working on the Explosion bug and reorganization of state changing


## 1/21/16 ##
-Discovered bug that causes Pokemon that used sucide to not faint if it fainted the target\n
-Bug that affects multi hit attacks with type effectiveness not equal to 1\n
-Added swap that checks preemptive attacks from player\n
-Added swap to include status\n
-Added multi-hit text\n
-Fixed bug that shows status immediately as turn starts

## 1/20/16 ##
-Changed AI_Hard attack algorithmn to only choose strongest move and it's effectiveness\n
-Fixed bug that shows attack text even if the Pokemon was unable to attack\n
-Added option for Hard_Ai to switch\n
-Added CollectInfo for Pokemon Attacks + pokemon\n
-Made AI_Hard comapare attack effectiveness as well.\n
-Introduced a bug that causes pokemon to switch a lot.\n
-Found bug: opponent switches after you do so it always knows what to switch to for best option (OUTPREDICTED!)\n
-Fixed the bugs regarding switches\n
-Added suicide attacks\n
-Added more info to attack database\n

