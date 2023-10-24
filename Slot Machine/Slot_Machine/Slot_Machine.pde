//Name: nakshayan
//Date: April 7, 2022
//Description: a usable slot machine
//NOTE: Can become laggy on slower computers, especially with the many moving pictures when spinning... e.g. on my computer it only takes a couple of seconds for a spin but it might slowdown and feel like it's spinning a long time

import processing.sound.*;
// the user controls (the intro screen, the spinning screen, etc)
final int INTRO = 1;
final int WAITING = 2;
final int SPINNING = 3;
final int PAUSE = 4;
final int QUIT = 5;
final int LOSE = 6;


//USER CONTROLLED VARIABLES
int userState = INTRO; //the state that the user controls (intro to spinning etc)
int multiplier = 1; //the token multiplier that the machine has
int tokens = 50; // the amount of tokens the user has

int tokenAdd = 0; // the amount of tokens that the player has won (for tracking purposes)


// controls the fruit state for the slot machine (easily call a shape to appear in the methods below)
final int APPLE = 1;
final int ORANGE = 2;
final int WATERMELON = 3;

//Stores the position of each row on the slot machine (to easily move shapes to each row)
final int ROW1 = 0; // first fruit row of the slot machine, etc
final int ROW2 = 115;
final int ROW3 = 228;

//all of the icon image and fruit variables (example, appleImg stores the apple photo)
PImage appleImg;
PImage orangeImg;
PImage waterMelonImg;
PImage slotMachineImg;
PImage tokenImg;

//sound file variables
SoundFile startSound;
SoundFile winnerGagnant;
SoundFile noPrize;
//SoundFile bigWinner; //(file was too big)

//Stores the y position of each image for its movement (allows it to move down the slot machine)
int appleY = -50;
int orangeY = 75;
int waterMelonY = 125;

float handleY = -220; // the slot machine handle's y position for animation
int handleCall = 0; // to tell the handle whether to be moving up or down
float fruitCounter = 0; // to tell the fruits to stop or start spinning
int fruitCounter2 = 0; // tracking how many times the fruit spins

//token tracking variables
//position
int tokenY = 0;
int tokenXOne = width/2-50+int(random(1, 200));
int tokenXTwo = width/2-50+int(random(1, 200));
int tokenXSpeed = int(random(20, 50)); //token speed on the x axis (y speed is constant)
//number of token animations to be played (tokenCounter is the amount left, totalTokenCounter is the total).
float tokenCounter = 0;
int totalTokenCounter = 0;

//chooses a random fruit to display on the machine.
int fruitRandom1 = 1;
int fruitRandom2 = 2;
int fruitRandom3 = 3;
//chooses and stores a random fruit (for randomly picking objects to appear on the slot machine)
int fruitWinRandom1 = 1;
int fruitWinRandom2 = 2;
int fruitWinRandom3 = 3;

//Variable to track the display fruit (on the waiting screen, before the game starts), for appearence.
int displayFruitTop = 1;
int displayFruitBottom = 0;
//More variables to track which fruit appears at what time (just for the appearence of the program)
int fruitMove1 = 1;
int fruitMove2 = 2;
int fruitMove3 = 3;
//check if token has made it to its correct destination (just for appearence)
int fruitReady = 0;

//allows for the final winning shapes to appear on the screen before wiped away
int winLoseReadyApple = 0;
int winLoseReadyOrange = 0;
int winLoseReadyWaterMelon = 0;
int time; //tracks time since certain actions have been taken


void setup() {
  //sets framerate, loads images, sets size and background, etc
  //frameRate(60);
  size(800, 800);
  //load images
  slotMachineImg = loadImage("slot machine.png");
  tokenImg = loadImage("token.png");
  appleImg = loadImage("apple.png");
  orangeImg = loadImage("orange.png");
  waterMelonImg = loadImage("water melon.png");
  //loads sounds
  //if something is wrong (its slow, its broken, or its just reaaaally annoying) just comment these lines out
  startSound = new SoundFile(this, "startSound.mp3");
  winnerGagnant = new SoundFile(this, "winnerGagnant.mp3");
  //bigWinner = new SoundFile(this, "bigWinner.mp3"); //(file was too big)
  noPrize = new SoundFile(this, "noPrize.mp3");

  //rest of the stuff (allign, etc)
  textAlign(CENTER);
  //introScreen();
  //slotMachineBackground();
  //tokenAnimation();
}

void draw() {
  //println(frameRate);
  handleAnimation(); // draws the entire slot machine at the beginning of each draw to make sure there are not trailing images

  //different states depending on where the user wants to go
  if (userState == INTRO) { //intro screen
    introScreen();
  } else if (userState == WAITING) { //if user presses "E", go to the slot machine screen to await for the user's input to spin
    //slotMachineBackground();
    if (((tokens - multiplier) < 0) && (tokens != 0)) {
      multiplier --;
    }
    handleImage();
    if (displayFruitTop == 1) {
      //draws image (stores which fruits are used in the variables as well)
      fruitMove1 = 1;
      fruitMove2 = 2;
      fruitMove3 = 3;
      image(appleImg, 95 + ROW1, appleY + 100, 100, 100); 
      image(orangeImg, 95 + ROW2, orangeY, 100, 100); 
      image(waterMelonImg, 95 + ROW3, waterMelonY - 100, 100, 100); 
      //moves image on y axis
      appleY += 20;
      orangeY += 20;
      waterMelonY += 20;
      //centers image on the wheels
      if ((appleY >= 300-100)) {
        appleY = 300-100;
      }
      if ((orangeY >= 300)) {
        orangeY = 300;
      }
      if ((waterMelonY >= 300+100)) {
        waterMelonY = 300+100;
      }
      slotMachineBackground();
      if (appleY == 200 && orangeY == 300 && waterMelonY == 400) {
        fruitReady = 1;
      }
    } else if (displayFruitBottom == 1) {
      fruitPicker(ROW1, fruitMove1);
      fruitPicker(ROW2, fruitMove2);
      fruitPicker(ROW3, fruitMove3);
      appleY += 20;
      orangeY += 20;
      waterMelonY += 20;
      if (appleY > 450 && orangeY > 650 && waterMelonY > 700) {
        displayFruitBottom = 0; 
        appleY = -50;
        orangeY = 75;
        waterMelonY = 125;
        displayFruitTop = 1;
      }
      slotMachineBackground();
    }
  } else if (userState == SPINNING) { //once the user presses SPACE, initiate the spinning sequence
    //token is removed, animation is started
    appleY = -50;
    orangeY = 75;
    waterMelonY = 125;
    displayFruitTop = 0;
    userState = PAUSE; //makes sure that the user can't spam random commands (the pause stops them from hitting certain buttons)
    displayFruitBottom = 1;
    tokens -= multiplier;
    handleCall = 1;
    winLoseReadyApple = 0;
    winLoseReadyOrange = 0;
    winLoseReadyWaterMelon = 0;
    //print(tokens);
  } else if (userState == PAUSE) {
  } else if (userState == LOSE) { //if player loses, play lose screen
    background(136, 216, 192);
    fill(255, 255, 255);
    textSize(30);
    textAlign(CENTER);
    text("You ran out of tokens! Game over.", 400, 400);
  } else if (userState == QUIT) { //if player quits, display number of tokens
    background(0, 128, 128);
    fill(255, 255, 255);
    textSize(30);
    text("You ended the game with a total of " + tokens + " tokens.", 400, 400);
  }
  if (userState == WAITING || userState == SPINNING || userState == PAUSE) {
    fill(255, 255, 255);
    textSize(40);
    textAlign(CENTER);
    text("Tokens: " + tokens, 650, 735);
    text("Multiplier: x" + multiplier, 650, 775);
  }
  tokenAnimation();
}

void introScreen() { //draws the intro screen
  size(800, 800);
  background(92, 200, 215);
  fill(255, 255, 255);
  textSize(50);
  textAlign(CENTER);
  text("Welcome to the", 400, 75);
  text("slot machine program!", 400, 125);

  textSize(40);
  //draws apples
  image(appleImg, 95, 200, 100, 100);
  image(appleImg, 95+ROW2, 200, 100, 100);
  image(appleImg, 95+ROW3, 200, 100, 100);
  text("= 4 tokens", 600, 275);

  //draws oranges
  image(orangeImg, 95, 350, 100, 100);
  image(orangeImg, 95+ROW2, 350, 100, 100);
  image(orangeImg, 95+ROW3, 350, 100, 100);
  text("= 8 tokens", 600, 425);

  //draws water melons
  image(waterMelonImg, 95, 500, 100, 100);
  image(waterMelonImg, 95+ROW2, 500, 100, 100);
  image(waterMelonImg, 95+ROW3, 500, 100, 100);
  text("= 12 tokens", 600, 575);

  textSize(30);
  text("Controls:", 400, 650);
  textSize(20);
  text("Press 'e' to start, press 'SPACE' to spin the machine,", 400, 690);
  text("press 'z' to lower the multiplier, press 'x' to increase the multiplier,", 400, 720); 
  text("and press 'q' to quit the game at any time.", 400, 750);
  text("If you run out of tokens, it is game over.", 400, 780);
}

//Draws three fruit in the middle of the machine during certain animations and delays (just for appearence, stops it from being a white screen in the middle)
void fruitPickerStatic() {
  //positions
  appleY = 200;
  orangeY = 300;
  waterMelonY = 400;
  //draw fruit
  fruitPicker(ROW1, fruitMove1);
  fruitPicker(ROW2, fruitMove2);
  fruitPicker(ROW3, fruitMove3);
  //redraw machine so that fruit don't appear at the top
  slotMachineBackground();
}

void handleAnimation() { //does the handle animation
  //handleCall = 1;
  if (handleY <= 200 && handleCall == 1) { //handle animation going down
    handleImage();
    handleY += 20;
    fruitPickerStatic();
  } else if (handleY > -199) { //reverses direction of the handle to go back up
    handleCall = 2;
    handleImage();
    handleY -= 20;
    fruitPickerStatic();
  } else if (handleCall == 2) { //this calls the fruit spinning animation
    //reset screen method so that there aren't any trails
    handleImage();

    //make the fruit leave the screen
    if (displayFruitBottom == 1) {
      //draws the fruit in specific positions, just for them to move the first spin
      fruitPicker(ROW1, fruitMove1);
      fruitPicker(ROW2, fruitMove2);
      fruitPicker(ROW3, fruitMove3);
      //movement variables
      appleY += 20;
      orangeY += 20;
      waterMelonY += 20;
      if (appleY > 450 && orangeY > 650 && waterMelonY > 700) { //if the fruits are at the correct position, notify to move on.
        displayFruitBottom = 0; 
        appleY = -50;
        orangeY = 75;
        waterMelonY = 125;
        displayFruitTop = 1;
      }
    }
    slotMachineBackground();

    //make the actual random fruit start moving
    if (displayFruitBottom == 0) {
      fruitAnimation(fruitRandom1, fruitRandom2, fruitRandom3); //animation of fruit, moves them down and up when spinning
      slotMachineBackground(); //redraws the machine
      fruitCounter ++; //counts how many times the fruit is moved
      if (fruitCounter == 20/4) { //when the fruit reaches the bottom, reset back to the top and pick a new fruit
        fruitRandom1 = int(random(1, 4)); //random fruit is picked
        fruitRandom2 = int(random(1, 4));
        fruitRandom3 = int(random(1, 4));
        appleY = -50; //resets the fruits back to the top once they go to the bottom
        orangeY = 75;
        waterMelonY = 125;
        fruitCounter = 0;
        fruitCounter2 ++; //counts how many cycles the fruits have done
      }
      if (fruitCounter2 == 20) { //when the fruit has done 20 cycles, move onto the next animation of the fruits stopping
        //fruit(ROW1, APPLE);
        handleImage();
        handleCall = 3;
        fruitWinRandom1 = int(random(1, 13)); //makes it rarer to get the watermelon compared to the apple
        fruitWinRandom2 = int(random(1, 13));
        fruitWinRandom3 = int(random(1, 13));
        fruitWinLose(fruitWinRandom1, fruitWinRandom2, fruitWinRandom3); //places the random fruits into the method to do the animation
        //println("Done!");
      }
      //handleImage();
    }
  } else if (handleCall == 3) {
    fruitWinLose(fruitWinRandom1, fruitWinRandom2, fruitWinRandom3); //places the random fruits into the method to do the animation
  }
  //else if (handleY > -200){
  // userState = WAITING; 
  //}
  //fruit(ROW1, APPLE);
}

void handleImage() { //draws the handle (and redraws the slot machine background to make it ready for animation
  //drawing
  background(139, 190, 232);
  fill(255, 255, 255);
  rect(70, 225, 375, 250);
  fill(139, 190, 232);
  rect(50, 600, 400, 400);
  fill(177, 212, 220);
  rect(75, 230, 125, 35);
  rect(75, 490, 125, -35);
  rect(75, 230, 25, 50);
  rect(198, 230, 120, 30);
  rect(198, 490, 120, -30);
  rect(320, 230, 115, 35);
  rect(320, 490, 115, -35);
  //draw machine
  slotMachineBackground();
  //draw handle
  strokeWeight(10);
  stroke(0);
  fill(186, 190, 187);
  rect(525, 475, 30, handleY);
  rect(510, 450, 45, 25);
  fill(177, 11, 0, 255);
  circle(540, handleY+475, 50);
  noStroke();
}

void slotMachineBackground() { //a quick method to redraw the slot machine background (especially good for animations)
  noStroke();
  //fill(139, 190, 232);
  //rect(50, 600, 400, 400);
  //fill(177, 212, 220);
  //rect(75, 230, 125, 35);
  //rect(75, 490, 125, -35);
  //rect(75, 230, 25, 50);
  //rect(198, 230, 120, 30);
  //rect(198, 490, 120, -30);
  //rect(320, 230, 115, 35);
  //rect(320, 490, 115, -35);
  //a rectangle under the slot machine in case any object manages to get too far
  fill(139, 190, 232);
  rect(50, 600, 400, 400);
  image(slotMachineImg, -100, -20, 800, 800);
  //handleImage();
}


void fruitAnimation(int fruit1, int fruit2, int fruit3) { //the entire fruit animation
  if (handleCall == 2) { //handle call basically tells the program when to start
    for (int counter = 1; counter <= 4; counter++) { //moves the fruit down with a for loop

      //draws a background for the fruit
      fill(255, 255, 255);
      rect(70, 225, 375, 250);
      fill(139, 190, 232);
      rect(50, 600, 400, 400);
      fill(177, 212, 220);
      rect(75, 230, 125, 35);
      rect(75, 490, 125, -35);
      rect(75, 230, 25, 50);
      rect(198, 230, 120, 30);
      rect(198, 490, 120, -30);
      rect(320, 230, 115, 35);
      rect(320, 490, 115, -35);

      //the three fruit rows
      fruit(ROW1, fruit1);
      fruit(ROW2, fruit2);
      fruit(ROW3, fruit3);
    }
    //prints the background so that there isn't a trail of fruit
    slotMachineBackground();
  }
}

void fruitWinLose(int fruit1, int fruit2, int fruit3) { 
  //random numbers (fruit) are put into this method, doing an animation for each fruit and telling the user if they win

  //Converts the random numbers into the fruit (makes it rarer to get a watermelon than an apple)
  if (fruit1 >=1 && fruit1<= 5) {
    fruit1 = 1; //apple
    fruitMove1 = 1;
  } else if (fruit1 >= 6 && fruit1 <= 9) {
    fruit1 = 2; //orange
    fruitMove1 = 2;
  } else if (fruit1 >= 10 && fruit1 <= 12) {
    fruit1 = 3; //watermelon
    fruitMove1 = 3;
  } else {
    println("Error");
  }
  //same but for row 2
  if (fruit2>=1 && fruit2<= 5) {
    fruit2 = 1;
    fruitMove2 = 1;
  } else if (fruit2 >= 6 && fruit2 <= 9) {
    fruit2 = 2;
    fruitMove2 = 2;
  } else if (fruit2 >= 10 && fruit2 <= 12) {
    fruit2 = 3;
    fruitMove2 = 3;
  } else {
    println("Error");
  }
  //same but for row 3
  if (fruit3 >=1 && fruit3<= 5) {
    fruit3 = 1;
    fruitMove3 = 1;
  } else if (fruit3 >= 6 && fruit3 <= 9) {    
    fruit3 = 2;
    fruitMove3 = 2;
  } else if (fruit3 >= 10 && fruit3 <= 12) {
    fruit3 = 3;
    fruitMove3 = 3;
  } else {
    println("Error");
  }

  //checks if the fruit have reached the middle, stops them from moving, and lets the program know to move onto the next step
  if ((appleY > 300-100)) {
    appleY = 300-100;
    winLoseReadyApple = 1;
    //print("Apple Ready");
  }
  if ((orangeY >= 300)) {
    orangeY = 300;
    winLoseReadyOrange = 1;
    //print("Orange Ready");
  }
  if ((waterMelonY >= 300+100)) {
    waterMelonY = 300+100;
    winLoseReadyWaterMelon = 1;
    //print("Water Melon Ready");
  }

  //if (winLoseReady == 1) {
  //  time = millis(); 
  //  winLoseReady = -1;
  //}
  //if (time > time+100) {
  //  print("Done!!");
  //}

  handleImage(); //redraws the slot machine to prevent trails or glitching
  //slotMachineBackground();

  //draws fruit and slot machine again
  fruit(ROW1, fruit1);
  fruit(ROW2, fruit2);
  fruit(ROW3, fruit3);
  slotMachineBackground();
  //detects if player wins
  if ((fruit1 == fruit2) && (fruit1 == fruit3) && (fruit2 == fruit3)/* && (millis() >= time+10000)*/) {
    //if player wins
    if (winLoseReadyApple == 1 || winLoseReadyOrange == 1 || winLoseReadyWaterMelon == 1) { //ensures that the fruits are on the right y position (centered on the machine)
      delay(1000); //pauses so that you can view the fruit
      //println("win");
      if (fruit1 == 1) { //calculates all of the requirements (adds tokens, resets machine, etc). This is the apple so you get 4 tokens
        //delay(1000);
        tokenAdd = 4*multiplier; //tells how many tokens to add
        tokens += tokenAdd; //adds tokens
        //fruit1 = 0;
        //fruit2 = 0;
        //fruit3 = 0;
        //tells how many tokens to animate falling 
        //(in the small chance that a player gets two wins in quick succession of each other, 
        //it won't break, the animation just resets back to the new amount of tokens to be dispensed 
        //just so that the game doesn't infinitely start dispensing tokens), it really helps with the lag.
        winnerGagnant.play(); //sound
        tokenCounter = tokenAdd;
        totalTokenCounter = tokenAdd;
        //println(tokenCounter);
        checkLose();
      } else if (fruit1 == 2) { //if the fruit is orange, you get 8 tokens
        //delay(1000);
        tokenAdd = 8*multiplier; //same as apple section
        tokens += tokenAdd;
        //fruit1 = 0;
        //fruit2 = 0;
        //fruit3 = 0;
        winnerGagnant.play();
        tokenCounter = tokenAdd;
        totalTokenCounter = tokenAdd;
        //println(tokenCounter);
        checkLose();
      } else if (fruit1 == 3) { //if the fruit is water melon, you get 12 tokens
        //delay(1000);
        tokenAdd = 12*multiplier; //same as apple section
        tokens += tokenAdd;
        //fruit1 = 0;
        //fruit2 = 0;
        //fruit3 = 0;
        winnerGagnant.play();
        tokenCounter = tokenAdd;
        totalTokenCounter = tokenAdd;
        //println(tokenCounter);
        checkLose();
      }
    }
  } else /*if ((millis() >= time+10000))*/ { //if lose, do this
    if (((fruit1 != fruit2) && (fruit1 != fruit3) && (fruit2 != fruit3) && (winLoseReadyApple == 1 && winLoseReadyOrange == 1 && winLoseReadyWaterMelon == 1))) {
      //if fruits are all different
      //if player loses
      //println("lose");
      //fruit1 = 0;
      //fruit2 = 0;
      //fruit3 = 0;
      noPrize.play();
      delay(1000);
      checkLose();
    } else if ((((fruit1 == fruit2) && (fruit1 != fruit3) && (fruit2 != fruit3)) || ((fruit1 == fruit3) && (fruit2 != fruit3) && (fruit1 != fruit2)) || ((fruit2 == fruit3) && (fruit1 != fruit3) && (fruit1 != fruit2)))) {
      //if two fruits are the same
      if (((winLoseReadyApple == 1) && (winLoseReadyOrange ==1)) || ((winLoseReadyOrange == 1) && (winLoseReadyWaterMelon == 1)) || ((winLoseReadyApple == 1) && (winLoseReadyWaterMelon == 1))) {
        noPrize.play();
        delay(1000);
        checkLose();
      }
    }
  }
}

//checks if the player has run out of tokens, also resets all variables back so that they are ready to spin again.
void checkLose() {
  //reset broadcast variables
  userState = WAITING;
  handleCall = 0;
  fruitCounter = 0;
  fruitCounter2 = 0;
  if (tokens <= 0) {
    userState = LOSE;
  }
  //reset fruit positions
  appleY = 200;
  orangeY = 300;
  waterMelonY = 400;
  displayFruitTop = 0;
  displayFruitBottom = 1;
}

//This method allows for both fruit picking and movement. Stops me from having to move it everywhere, it's just all in one place.
void fruit(int fruitRow, int fruitState) { // controls all the fruits
  //controls the icon movement (fruits) for the slot machine. It prints them and moves them (using the framerate so that they aren't moved instantly, instead of putting them in a for loop).
  if (fruitState == APPLE) { //controls apple movement
    if (appleY <= 450) {
      //draw
      image(appleImg, 95 + fruitRow, appleY+100, 100, 100); 
      //move
      appleY += 20;
    } else {
      //reset back to top
      appleY = -50;
    }
  } else if (fruitState == ORANGE) { //controls orange movement, exact same way as apple but a bit different values for appearence
    if (orangeY <= 650) {
      image(orangeImg, 95 + fruitRow, orangeY, 100, 100); 
      orangeY += 20;
    } else {
      orangeY = 75;
    }
  } else if (fruitState == WATERMELON) { //controls melon movement, exact same way as apple but a bit different values for appearence
    if (waterMelonY <= 700) {
      image(waterMelonImg, 95 + fruitRow, waterMelonY-100, 100, 100); 
      waterMelonY += 20;
    } else {
      waterMelonY = 125;
    }
  }
}

//This method is a much simpler version of the one above, it just draws the fruit that you input into the method.
void fruitPicker(int fruitRow, int fruitState) { // controls all the fruits
  //controls the icon movement (fruits) for the slot machine
  if (fruitState == APPLE) { //controls apple movement
    image(appleImg, 95 + fruitRow, appleY+100, 100, 100);
  } else if (fruitState == ORANGE) { //controls orange movement
    image(orangeImg, 95 + fruitRow, orangeY, 100, 100);
  } else if (fruitState == WATERMELON) { //controls melon movement
    image(waterMelonImg, 95 + fruitRow, waterMelonY-100, 100, 100);
  }
}

void tokenAnimation() { //the animation that plays when player wins (displays tokens falling)
  //
  if (tokenCounter > (totalTokenCounter/2)) {
    //movement
    tokenY += 40;
    tokenXOne += tokenXSpeed;
    tokenXTwo -= tokenXSpeed;
    //draw image
    image(tokenImg, tokenXOne, tokenY, 100, 50);
    image(tokenImg, tokenXTwo, tokenY, 100, 50);
  }
  if (tokenY > height+50) { //if the fruit reaches the bottom, tell the program and move it back to the top.
    tokenXSpeed = int(random(-40, 40));
    tokenCounter--; //broadcast that there has been one less token
    tokenY = 0;
    tokenXOne = width/2-50+int(random(-100, 100));
    tokenXTwo = width/2-50+int(random(-100, 100));
  }
}

void keyPressed() {
  //quit the game
  if (((key == 'q') || (key == 'Q')) && (userState == WAITING)) {
    userState = QUIT;
  }
  //move from intro to waiting screen, press 'e'
  if ((key == 'E' || key == 'e') && (userState == INTRO)) {
    startSound.play();
    userState = WAITING; //move to the waiting slot machine screen
  } 
  //spin the machine
  else if (((key == ' ' && userState == WAITING) && userState != PAUSE) && fruitReady != 0) {
    if (tokens - multiplier >= 0) {
      userState = SPINNING; //move to the spinning animation state
      fruitReady = 0;
    } /*else {
     textSize(30);
     fill(255, 25, 50);
     text("Hey! Stop trying to break it!", 400, 400);
     text("No bugs here!", 400, 430);
     delay(500);
     }*/
  }

  //controls the multiplier ('z' to decrease, 'x' to increase)
  if ((((key == 'z') || (key == 'Z')) && (multiplier > 1)) && (userState == WAITING)) {
    multiplier--; //z
  }
  if ((((key == 'x' || (key == 'X')) && (multiplier < 5)) && (userState == WAITING)) && (tokens - multiplier > 0)) {
    multiplier++; //x
  }
}
