import random
import time
player1Name=input("First Player Faka igama:")
player2Name=input("Second Player aziye name:")
print("ARIQALE........")
print()

dice_art = {
    1: ("┌─────────┐",
        "│         │",
        "│    ●    │",
        "│         │",
        "└─────────┘"),
    2: ("┌─────────┐",
        "│  ●      │",
        "│         │",
        "│      ●  │",
        "└─────────┘"),
    3: ("┌─────────┐",
        "│  ●      │",
        "│    ●    │",
        "│      ●  │",
        "└─────────┘"),
    4: ("┌─────────┐",
        "│  ●   ●  │",
        "│         │",
        "│  ●   ●  │",
        "└─────────┘"),
    5: ("┌─────────┐",
        "│  ●   ●  │",
        "│    ●    │",
        "│  ●   ●  │",
        "└─────────┘"),
    6: ("┌─────────┐",
        "│  ●   ●  │",
        "│  ●   ●  │",
        "│  ●   ●  │",
        "└─────────┘")
}



while True:
 play=input("Press s to star the game (again) or p to not play anymore:")  
 if play.lower()=='s':
  diceTot1=0
#dice=[]
  playerDice1=random.randint(1,6)
#dice.append(playerDice1)
  playerDice2=random.randint(1,6)
#dice.append(playerDice2)

#i=len(dice)
#z=0
#while z<i:
  diceTot1=  playerDice1+playerDice2         #dice[z]
  #  z+=1
   
  for i in range(1,4):
     time.sleep(1)
     print(".",end=" ")
     
  print()
     

  print(f"Dice1={playerDice1}   Dice2={playerDice2}   Total={diceTot1}")
  for num in dice_art.get(playerDice1):
        print(num)
  for num2 in dice_art.get(playerDice2):
        print(num2)
  print()

  if diceTot1==7 or diceTot1==11:
     print(f"popo!! {player1Name} danko poi ,you can ake the money")
  else:
    print(f"{player2Name} has to roll")
    roll=input(f"{player2Name} press r to roll poi:")
    if roll.lower()=="r":
     diceTot2=0
     player2Dice1=random.randint(1,6)
     player2Dice2=random.randint(1,6)
     diceTot2=player2Dice1 + player2Dice2
    
     for i in range(1,4):
      time.sleep(1)
      print(".",end=" ")
      
     print()

     print(f"Dice1= {player2Dice1}   Dice2={player2Dice2}   Dtotal ={diceTot2}")
     for num in dice_art.get(player2Dice1):
        print(num)
     for num2 in dice_art.get(player2Dice2):
        print(num2)
     print()

     for i in range(1,4):
      time.sleep(1)
      print(".",end=" ")
      print()
  
     if (diceTot2>diceTot1):
      print(f"{player1Name} wins")
     else:
      print(f"{player2Name} wins")
      

    else:
      print(f"{player2Name} does not want to play:(")
    
 else:
     print("Game over")
     break