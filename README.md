# FinalProjectFall2015-BillyWongMatthewZhu #

# Directions to use #
1) Go to Pokemon Folder and open Pokemon.pde

2) Click the play button

3) Use "z" for ok and "x" for cancel/go back and use the arrow keys to go up,left,right,down, with respect to the arrows

4) Choose 3 pokemon to use for your team(You may scroll down using the arrow keys for more since menu does not have a scroll bar)

4.5) If you make a mistake when choosing Pokemon, close the window and repeat steps 2-4.

5) Choose an opponent difficulty (Easy,Normal,Hard)

6) "Fight" allows you to use one of four moves your pokemon has, press z to use it or x to go back to the previous menus.

7) "Pkmn" allows you to swap pokemon, press z to choose the pokemon you wish to swap into or x to go back to the previous menu.

8) Run and Item are not inplemented and therefore will not be used.

9) To win, you need to defeat Professor Oak.


# CURRENT BUGS #
-If an critical hit causes a Pokemon to faint, the last bit of text is skipped over and goes straight to faint

-Some attack text may displayed during wrong times

-A white rectangle may appear during the switch screen

-When you click Pkmn to switch, it immediately says the Pokemon is battling in the switch screen

# NITPICKS #
Program currently uses a decent amount of memory since it loads image and prints text over and over


# NEXT PLANS #
Program cpu usage fix

Work on Hard AI 

# CHANGELOG #

## 1/25/16 ##
-Adjustments to Hard AI


## 1/24/16 ##
-Added Pokemon selection screen

-Fixed major bugs with AI_switching

-Fixed major bugs with AI_attacking

~~-Hard AI now chooses when it is optimal to attack/heal/buff~~ -Hard AI currently chooses the most damaging move or a status move when appropriate

-AI no longer switches 24/7


## 1/23/16 ##
-Fixed Explosion Bug

-Worked on collect info method for Hard AI (Fixed bug for storePokemon and finished storeAttack)

## 1/22/16 ##
-added StoreAttacks for AI

-Started working on the Explosion bug and reorganization of state changing


## 1/21/16 ##
-Discovered bug that causes Pokemon that used sucide to not faint if it fainted the target

-Bug that affects multi hit attacks with type effectiveness not equal to 1

-Added swap that checks preemptive attacks from player

-Added swap to include status

-Added multi-hit text

-Fixed bug that shows status immediately as turn starts

## 1/20/16 ##
-Changed AI_Hard attack algorithmn to only choose strongest move and it's effectiveness

-Fixed bug that shows attack text even if the Pokemon was unable to attack

-Added option for Hard_Ai to switch

-Added CollectInfo for Pokemon Attacks + pokemon

-Made AI_Hard comapare attack effectiveness as well.

-Introduced a bug that causes pokemon to switch a lot.

-Found bug: opponent switches after you do so it always knows what to switch to for best option (OUTPREDICTED!)

-Fixed the bugs regarding switches

-Added suicide attacks

-Added more info to attack database

