a. Project Name
  Rocket Math

b. Team Members
  Morgan Weaver 
  Ella Hedman 
  Rashne Hassan 
  Hugrun Helgadottir

c. Link to your Project Demo Video
https://youtu.be/ElcR1AjFy-8

d. Overview of the Project
  Our project is a fun math game targeted towards kids learning simple addition, subtraction, and multiplication. The user can type answers based on an equation that pops up 
  on the screen with randomly generated numbers. 
  There are 2 modes, a multiple choice mode, and a mode where the user enters their answer on a keyboard. The user is also able to choose with switches if they want to work on 
  addition, subtraction, or multiplication. 
e. How to run your project
  This project runs from the top module, top.v and uses the VGA, and FPGA seven segment display, LED's, and buttons. 

  
f. Overview of the code structure (what code does what)
  Our top module combines the LFSR (Random Number Generator), ALU, FSM, and answer check modules. The random number generator creates the 2 random numbers for our equation. The ALU Generates the correct answer of the two random numbers and feeds that into the "answer check" module. The user's answer entered from the keyboard is also fed into the "answer check" module. These two values are compared and then flag the entered value as right or not right, lighting up an LED and adding a point if the answer is correct and right == 1. We also have our 4 vga screens in the code, the single digit, the game over, multiple choice, and 2 digit screen. The vga is utilized to display the equation and the multiple choice choice options in the multiple choice module. Our FSM module outputs everything besides the equation to the 7 segment displays. There is a counter module that displays a stopwatch, a points_counter module that calculates the points, and the keyboard modules that output the typed number from the keyboard.

g. Anything else you feel is relevant.
