# FinalProjectFall2015-BillyWongMatthewZhu #



# CURRENT BUGS: #
-If an critical hit causes a Pokemon to faint, the last bit of text is skipped over and goes straight to faint

# NITPICKS #
-Program currently uses a decent amount of memory since it loads image and prints text over and over


# NEXT PLANS #
-Program cpu usage fix
-Add multi hit attacks
-Add flinching
-Add healing
-Work on Hard AI information storage
-Status appearance time

# CHANGELOG #
## 1/22/16
-added StoreAttacks for AI


## 1/21/16 ##
-Discovered bug that causes Pokemon that used sucide to not faint if it fainted the target
-Bug that affects multi hit attacks with type effectiveness not equal to 1
-Added swap that checks preemptive attacks from player
-Added swap to include status

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

