#!/bin/bash
dungeon_begin(){
	echo "You enter Floor $floor.
	|| 1) Enter shop
	|| 2) Fight $monster ($monsteratk|$monsterhp)
	|| 3) Loot chest
	|| 4) Check your stats"
	send_to_choice
}




send_to_choice(){
case $input in
1)
	test 
	;;
1)
	test2
	;;
*)
	echo "Invalid input!"
	;;
esac
}

# begins the loop
dungeon_begin