a. Project Name
  Rocket Math

b. Team Members
  Morgan Weaver 
  Ella Hedman 
  Rashne Hassan 
  Hugrun Helgadottir

c. Link to your Project Demo Video

d. Overview of the Project
  Our project is a fun math game targeted towards kids learning simple addition, subtraction, and multiplication. The user can type answers based on an equation that pops up 
  on the screen with randomly generated numbers. 
  There are 2 modes, a multiple choice mode, and a mode where the user enters their answer on a keyboard. The user is also able to choose with switches if they want to work on 
  addition, subtraction, or multiplication. 
e. How to run your project
  This project runs from the top module, top.v and uses the VGA, and FPGA seven segment display, LED's, and buttons. 

  
f. Overview of the code structure (what code does what)
  Our top module combines the LFSM (Random Number Generator), ALU, FSM, and answer check modules. The random number generator creates the 2 random numbers for our equation. The ALU Generates the correct answer, and compares that with the keyboard entered answer from the keyboard module. This then flags the entered value as right or not right, lighting up an LED and adding a point if right ==1. We also have our 3 screens, in the code, the game over, multiple choice, and 2 digit screen. Our FSM outputs everything to the 7 segment displays, calculating points, and displaying the stopwatch in the same module. 

g. Anything else you feel is relevant.
