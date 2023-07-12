//Name: Action
// Date Started: April 13, 2023
// Description: A Blackjack card game created in Processing (computer is dealer, you are player).
// A4

// Card Rules: All cards have their corresponding value
// but the face cards (King, Queen and Jack) are worth 10.
// An Ace is worth 11 unless that would give a player or the dealer greater than 21,
// in this case it has a value of 1.

// The respective game states.
final int SHOP = -3, RULES = -2, START = -1, HITTING = 0, BUST= 1, WIN= 2, LOSE= 3, DRAW = 4, WAITING = 5, STANDING = 6, GAMEOVER = 7, NATURAL = 8;

int state = START; // Sets the game state to start automatically (then changes based on what the user does to change the game).

int userTokens = 100; // How many tokens the user has left.
int currentBet = 0; // How many tokens the user is currently betting.

int winLose = -1; // Tells the program whether the player won or lost. -1 if neither yet, 0 if lost, 1 if won.

Deck deck; // The deck of cards is declared.

// Declares the player's hand and the dealer's hand.
Hand playerHand, dealerHand;

// Hit and stand buttons (to let the player hit/stand).
Button hitButton, standButton;

// The restart and start buttons (to allow the player to start and restart).
// Also declares the rulesButton which the user can press to display the game rules.
Button startButton, restartButton, rulesButton, playButton;

// Shop stuff:
Button shopButton; // A button to let the user go to the shop.
Button greenThemeButton, redThemeButton, blackThemeButton; // Buttons to let the user select a theme for their game (green, red, etc... green is default).

// The betting button
Button bet;

// Buttons to save the game file and load a game file.
Button saveGameButton, loadGameButton;

// A textbox for the user to input their bet.
Textbox betInput;

// Saves the colour of the background (so that it can be changed).
// theme[0] is the background colour, theme[1] is the stripes.
color[] theme;

String[] ownedThemes; // Stores all the themes that the player has purchased from the shop.
int numberOfThemesAvailable = 3; // A variable to know how many themes are available (to easily change the number later on).
String currentTheme = "Green Theme"; // Saves the current theme being used by the user so that it can be saved.

PrintWriter saveFile; // Lets the program save (write to a .txt file).

void setup() {
  // Sets size and background.
  size(800, 600);

  // Adds "Green Theme" to the player's total list of themes.
  ownedThemes = new String[numberOfThemesAvailable];
  ownedThemes[0] = "Green Theme";
  for (int counter = 1; counter < numberOfThemesAvailable; counter++) { // Goes through and sets all values of the string to "" so that it can be read.
    ownedThemes[counter] = "";
  }

  // Changes the colour to the initial theme (it is green initially).
  theme = new color[2];
  theme[0] = color(78, 106, 84);
  theme[1] = color(203, 209, 143);
  background(theme[0]); // Sets the background to this green colour.

  deck = new Deck(); // The deck of cards is created.

  //Adds 52 cards to the deck then shuffles them.
  deck.initializeDeck();
  deck.shuffle();

  playerHand = new Hand(); // Your hand is created.
  dealerHand = new Hand(); // The dealer's (computer's) hand is created.

  startButton = new Button(width/2-25, 500, 50, 30, color(227, 180, 72), "Start"); // Creates the start button for the user to start the game.

  hitButton = new Button(100, 500, 50, 30, color(227, 180, 72), "Hit"); // Creates the hit button for the user.
  standButton = new Button(200, 500, 50, 30, color(227, 180, 72), "Stand"); // Creates the stand button for the user.

  rulesButton = new Button(width/2-25, 550, 50, 30, color(227, 180, 72), "Rules"); // Creates the rules button to display rules to the user.
  playButton = new Button(width/2-25, 500, 50, 30, color(227, 180, 72), "Play!"); // Creates the play button to go back to the start screen.

  restartButton = new Button(width/2-25, 500, 50, 30, color(227, 180, 72), "Restart"); // Creates the restart button for the user.

  bet = new Button(600+20, 550, 65, 30, color(227, 180, 72), "Bet"); // Creates the bet button for the user.

  // Buttons to let the user save and load their game file.
  saveGameButton = new Button(100+25, 500, 50, 30, color(227, 180, 72), "Save");
  loadGameButton = new Button(100+25, 550, 50, 30, color(227, 180, 72), "Load");

  betInput = new Textbox(600, 500, 100, 25); // The textbox for the user to type their bet.

  shopButton = new Button(100+25, 100+30, 50, 30, color(227, 180, 72), "Shop"); // Creates the shop button.

  // Creates buttons for the player to buy/select their theme.
  greenThemeButton = new Button(100+25, 50, 50, 30, color(227, 180, 72), "Use");
  redThemeButton = new Button(300+25, 50, 50, 30, color(227, 180, 72), "Use");
  blackThemeButton = new Button(500+25, 50, 50, 30, color(227, 180, 72), "Use");

  // Deal 2 cards each to the dealer and player initially.
  for (int x = 0; x < 2; x++) {
    playerHand.addCard(deck.dealCard());
    dealerHand.addCard(deck.dealCard());
  }
}

void draw() {
  // Redraws the background each time to reset the frame.
  background(theme[0]);
  //Draws the grid pattern across the background (according to the theme selected).
  // The vertical lines.
  for (int counter = 0; counter <= width; counter += 100) {
    // Sets the stroke and then draws the line.
    strokeWeight(5);
    stroke(theme[1]);
    line(counter, 0, counter, height);
  }
  // The horizontal lines.
  for (int counter = 0; counter <= height; counter += 100) {
    // Sets the stroke and then draws the line.
    strokeWeight(5);
    stroke(theme[1]);
    line(0, counter, width, counter);
  }

  if (!(state == RULES || state == SHOP)) { // Displays information like the bet to the user.
    // Draws the tokens on the side of the screen that the user still has left.
    // Firstly makes a little box so that the text is visible.
    fill(theme[0]);
    rect(500, 400, 300, 100);
    // Set colour and size of the text to a nice gold colour and 18 font respectively.
    fill(227, 180, 72);
    textSize(18);
    textAlign(CENTER);
    text("Tokens: " + userTokens, 650, 450-12.5); // Display current tokens.
    text("Current Bet: " + currentBet, 650, 450+12.5); // Display amount currently being bet.
    // Reset the colour, etc, so that it doesn't interfere with anything else.
    fill(255, 255, 255);
    strokeWeight(0);
    // Draws the deck of cards for the table (cosmetic)
    deck.getCardBack().drawCard(width*3/4, 200);
  }

  if (state == RULES) {
    // Displays the rules to the user.

    // Sets the text information (size 20, white color, etc).
    textAlign(LEFT);
    textSize(20);
    fill(255, 255, 255);
    strokeWeight(0);

    // The rules:
    text("Welcome to Blackjack! The goal of this game is to make your cards have a value close to 21. \n" +
      "You can do this by pressing the \"Hit\" button to pick up a card, or pressing \"Stand\" if you \n" +
      "are confident that your cards have a high enough value. If you go over 21, you lose (bust). \n" +
      "However, if you do not pick up enough cards, the dealer may get a higher value than you, \n" +
      "meaning you also lose. \n" +
      "Some cards are worth different values. For example, all face cards are worth 10 points. \n" +
      "An ace has a special property where it's worth 11, except when it causes you to bust, \n" +
      "where it is worth 1. All other cards are worth their numerical value. \n" +
      "You also have tokens which you can bet (using the bottom right textbox on the start screen).\n" +
      "To bet, click on the textbox and type a number. Then click \"Bet\" if you are happy with \nthe amount. " +
      "If you have bet too much, press the \'-\' button on your keyboard. This will make \nthe textbox go to " +
      "subtraction mode, where it will subtract the bet value from your current bet \nand add it back to your " +
      "balance. To go back to addition mode, just press \'-\' again. \n\n", 25, 25);

    // Aligns the text back to the center.
    textAlign(CENTER, CENTER);

    // Lets the user go back to the starting screen.
    text("Ready to play?", width/2-30-(textWidth("Ready to play?"))/2, 510);
    playButton.drawButton(); // Draws the button to go back to the start screen so that the user can play.
  } else if (state == SHOP) { // The shop menu.
    // Lets the user use the green theme.
    // Displays the text that tells the user "green theme".
    textAlign(CENTER);
    textSize(20);
    strokeWeight(0);
    fill(0, 255, 0);
    text("Green Theme", 150, 25);

    // The user already owns the green theme from the beginning so tell them they own it.
    fill(255, 255, 255);
    text("Owned", 150, 125);

    greenThemeButton.drawButton(); // Draw the button for them to use the green theme.

    // Lets the user select the red theme.
    // Displays the text that tells the user "red theme".
    textAlign(CENTER);
    textSize(20);
    strokeWeight(0);
    fill(255, 0, 0);
    text("Red Theme", 350, 25);

    // Text to tell information about the cost of the theme.
    fill(255, 255, 255);
    if (!(ownedThemes[1].equals("Red Theme"))) { // If the player doesn't own the red theme, display the price of it.
      text("$144", 350, 125);
    } else { // If they already own it, tell them they own it.
      text("Owned", 350, 125);
    }

    redThemeButton.drawButton(); // Draws the button for them to use the red theme button.

    // Lets the user use the black theme.
    // Displays text to show the player that this is the black theme.
    textAlign(CENTER);
    textSize(20);
    strokeWeight(0);
    fill(220, 220, 220);
    text("Black Theme", 550, 25);

    // Text to tell information about the cost of the theme.
    fill(255, 255, 255);
    if (!(ownedThemes[2].equals("Black Theme"))) { // If the player doesn't own the black theme, display the price of it.
      text("$255", 550, 125);
    } else {
      text("Owned", 550, 125); // If they already own it, tell them they own it.
    }
    blackThemeButton.drawButton(); // Draws the button for them to use the black theme button.


    playButton.drawButton();
  } else if (state == START) {
    // Checks in mouseClicked method to see if any of the buttons are clicked.
    // Draws all of the buttons.
    startButton.drawButton(); // Draws the start button for the player to start the game.
    rulesButton.drawButton(); // Etc.
    bet.drawButton();
    betInput.drawTextbox();
    saveGameButton.drawButton();
    loadGameButton.drawButton();
    shopButton.drawButton();
  } else if (state == WAITING) { // The game screen, waiting for the user to make play move.
    drawHands(true);
    // Draws the hit and stand buttons for the player to click if they want.
    hitButton.drawButton();
    standButton.drawButton();

    if (getBlackJackValue(playerHand) == 21 && playerHand.getCardCount() == 2) {
      // If the player is lucky and gets 21 straight off the start (so an ace + a 10, or a face),
      // then automatically send them into the NATURAL mode (which is what this situation is called) to see if its a draw or a win.
      state = NATURAL;
    }
  } else if (state == HITTING) {
    // showing the hit and stand buttons
    // covering the second dealer card
    playerHand.addCard(deck.dealCard());
    drawHands(true); // Draws the hands while covering the dealer card.
    // Draws the hit and stand buttons for the player to click if they want.
    hitButton.drawButton();
    standButton.drawButton();

    //Checks the black jack value of the player's hand after each time they hit.
    if (getBlackJackValue(playerHand) <= 21) {
      state = WAITING; // If the player's hand has a value of <= 21, then let them continue playing.
    } else {
      state = BUST; // If the player's hand goes over a value of 21, they lose (bust).
    }
  } else if (state == STANDING) {
    //Player is standing (so the dealer picks up).
    drawHands(false); // Draws all hands.

    // Makes the dealer pick up cards until they're over a black jack value of 16.
    while (getBlackJackValue(dealerHand) <= 16) {
      dealerHand.addCard(deck.dealCard());
      //draws the hands each time.
      drawHands(false);
    }
    drawHands(false); //Draws all hands on screen.

    if (getBlackJackValue(dealerHand) > 21 || getBlackJackValue(dealerHand) < getBlackJackValue(playerHand)) {
      state = WIN; // If the dealer goes over 21 when they pick up, or, if the dealer stops picking up and they have a lower value than the player, the player wins.
    } else if ((getBlackJackValue(dealerHand) == getBlackJackValue(playerHand)) && (getBlackJackValue(dealerHand) <= 21) && (getBlackJackValue(playerHand) <= 21)) {
      state = DRAW; // If neither player nor dealer goes over 21, and they have the same value, then it's a draw and tokens are returned.
    } else { // If none of these happen, then the player loses.
      state = LOSE;
    } // Note that bust is handled earlier, in the (state == HITTING) part.
  } else if (state == BUST) {
    // Tell them they lost and show them restart button
    drawHands(false); // Draws the dealer and player's cards for the user to see.

    // Text to show the player that they busted.
    // Sets the stroke, fill, etc.
    textAlign(CENTER);
    textSize(50);
    stroke(227, 180, 72);
    fill(255, 255, 255);
    strokeWeight(50);
    text("Bust! You lose.", width/2, height-25); // The text
    strokeWeight(0);

    // The player loses his bet.
    currentBet = 0;

    restartButton.drawButton(); // Draws the restart button.
  } else if (state == WIN) {
    // Tell them they win.
    drawHands(false); // Draw hands.
    // Change the fill, etc
    textAlign(CENTER);
    textSize(50);
    fill(255, 255, 255);
    text("You win!", width/2, height-25); // The text.

    // The player wins his bet!
    userTokens += currentBet*2; // Give him double the tokens he bet.
    currentBet = 0; // Reset the amount of bet tokens.

    restartButton.drawButton(); // Show them restart button
  } else if (state == LOSE) {
    // Tell them they lost.
    drawHands(false); // Draw hands.
    // Set text side, fill, etc.
    textAlign(CENTER);
    textSize(50);
    fill(255, 255, 255);
    text("You lose.", width/2, height-25); // The text.

    currentBet = 0; // Player loses his bet.

    restartButton.drawButton(); // Show them restart button
  } else if (state == DRAW) {
    // Tell them the game was a draw, show them the restart button.
    drawHands(false); // Draw the hands
    // Sets the text size, fill, etc.
    textAlign(CENTER);
    textSize(50);
    fill(255, 255, 255);
    text("It's a draw!", width/2, height-25); // The text is drawn.

    // Give back the bet tokens because it's a draw.
    userTokens += currentBet;
    currentBet = 0;

    restartButton.drawButton(); // Draw the restart button for the player.
  } else if (state == NATURAL) { // If the player gets 21 right off the start.
    drawHands(false); // Draw the hands.
    if (getBlackJackValue(dealerHand) == getBlackJackValue(playerHand)) {
      // If the dealer also gets exactly 21, send them to a draw to return all tokens.
      state = DRAW;
    } else {
      // Otherwise, they win, but it's a natural so they get 1.5x their bet back.
      // Set the text fill, etc.
      textAlign(CENTER);
      textSize(50);
      fill(255, 255, 255);
      text("Natural! You get 1.5x your bet back.", width/2, height-25); // Display to user the text.

      // Player gets 1.5x their bet.
      currentBet = round(currentBet*1.5); // Rounds to avoid putting a float into an int.
      userTokens += currentBet;
      currentBet = 0;

      restartButton.drawButton(); // Draw the restart button for the player.
    }
  } else if (state == GAMEOVER) { // If the player loses completely (runs out of tokens).
    // Tell them they lost all of their tokens, don't display a restart button because they're out of money.
    drawHands(false); // Draw hands.
    textAlign(CENTER); // Set text size, etc.
    textSize(50);
    fill(255, 255, 255);
    text("Lose! You're out of tokens! \n Game over!", width/2, height-25-50-20); // Display the text.
  }

  if (userTokens <= 0 && (state == LOSE || state == BUST)) {
    // If the user runs out of tokens, make the game finish and don't let them replay.
    currentBet =  0; // Resets their bet to display 0.
    state = GAMEOVER; // Tells the program the game is over.
  }
}

//Description: Returns the blackJackValue of a hand that is passed in.
//Parameters:
//handToCheck: The hand the is passed in that will be checked for its BlackJack value.
//Returns: The BlackJack value of the hand that is passed in.
int getBlackJackValue(Hand handToCheck) {
  int blackJackValue = 0; // The BlackJack value of the hand that will be returned.
  int currentCard; // A variable for going through all the cards in the hand (and adding them to the total blackJackValue).
  int numberOfAces = 0; // For calculating how many aces there are in a deck.
  for (int counter = 0; counter < handToCheck.getCardCount(); counter++) {
    currentCard = handToCheck.getCard(counter).getValue(); // Assigns the card's number to the currentCard int.
    if (currentCard > 10) { // Makes the face cards (King, Queen, and Jack) have a value of 10.
      currentCard = 10;
    } else if (currentCard == 1) { // Stores the aces until last to calculate their value (since they are sometimes worth 1 or 11 given BlackJack rules).
      numberOfAces++;
      currentCard = 0;
    }
    blackJackValue += currentCard; // Add the current card value to the total Black Jack value.
  }

  for (int counter = 1; counter <= numberOfAces; counter++) { // Handles aces.
    if ((blackJackValue + 11 + (numberOfAces-counter)) <= 21) { // If the ace can be worth 11, add 11 to the blackJackValue (soft 11).
      blackJackValue += 11;
    } else { // If the ace added on is > 21, then add the rest as ones (ace is now hard 1).
      blackJackValue += numberOfAces+1-counter;
      break;
    }
  }

  return blackJackValue; // Return the value of the hand as an integer.
}


//Description: Draws both the player and dealer decks on the screen. (Not to be confused with the hand.drawHand() in the hand class).
//Parameters:
//coverDealer: Tells the method whether to cover the dealer card (so that the player can't see it).
//Returns: The BlackJack value of the hand that is passed in.
void drawHands(boolean coverDealer) {
  //Draws both the player's and dealer's hand across the screen.
  dealerHand.drawHand(100, 100);
  playerHand.drawHand(100, 300);
  if (coverDealer) { //Draws the back of the card over the dealer's 2nd card (to hide it) if the player is still playing and hasn't clicked the stand button.
    // Only does this when the coverDealer argument is set to true.
    deck.getCardBack().drawCard(100+25, 100);
  }
}

// Description: Saves the game data when prompted.
// Parameters:
// userBalance - the amount of tokens the user has.
// Returns: Nothing.
void saveGameData() {
  /* Info for game data:
   * "User Tokens:" will be the keyword for storing the user's token balance.
   * "User Themes:" will be the keyword for where all of the themes the user has bought are.
   * "Current Theme:" will be where the theme the player currently has selected is.
   */
  saveFile = createWriter("save.txt"); // Tells the program to work in the save.txt document.
  // Writes the user tokens to the save document.
  saveFile.println("User Tokens:" + "\n" + userTokens);

  // Saves the number of themes the user has so that it knows how long to read for when loading the save again.
  saveFile.println("User Themes:\n" + numberOfThemesAvailable);
  for (int counter = 0; counter < numberOfThemesAvailable; counter++) { // Goes through all owned themes.
    // Saves all owned themes to the text file.
    saveFile.println(ownedThemes[counter]);
  }
  saveFile.println("Current Theme:\n" + currentTheme); // Writes the current theme into the text document.
  // Stops the writer.
  saveFile.flush();
  saveFile.close();
}

// Description: Reads the save game data from save.txt and imports it into the game.
// Parameters: None.
// Returns: Nothing (changes some global variables).
void loadGameData() {
  String[] data = loadStrings("save.txt"); // Loads all of the save data from the .txt file into an array for the program to sort through.
  for (int counter = 0; counter < data.length; counter += 1) { // A for loop to go through the array.
    // Finds where the user tokens are stored and puts them into the program.
    if (data[counter].equals("User Tokens:")) {
      counter++; // Continue to go through the document.
      userTokens = int(data[counter]); // Puts the stored amount of tokens into the program.
    }
    if ((data[counter].equals("User Themes:"))) { // Finds where the themes are stored.
      counter++; // Continue throguh the document.
      int numberOfThemesStored = int(data[counter]); // The save file stores how many themes were put in. This is loaded into a variable.
      for (int counter2 = 0; counter2 < numberOfThemesStored; counter2++) { // Goes through and loads back all saved themes.
        counter++; // Continue through the document.
        ownedThemes[counter2] = data[counter]; // Stores the theme.
      }
    }
    if (data[counter].equals("Current Theme:")) { // Finds where the current theme the player was using is (so what theme they had selected).
      counter++; // Continue through the document.
      currentTheme = data[counter]; // Loads the theme the user was playing when last saved.
      setTheme(); // Sets the theme to what they were previously using.
    }
  }
}


void mouseClicked() {
  // Resets the textbox back to the dollar sign so that the user can type numbers.
  if (betInput.text.equals("Invalid Input")) {
    betInput.text = "$"; // Reset the string containing the characters in the textbox.
    betInput.textLength = 0; // Resets the length of the text in the textbox.
  }

  if (startButton.isClicked(mouseX, mouseY) && state == START) {
    // If the player hits the start button (and is on the start screen), put them into the waiting state.
    state = WAITING;
  }
  if (hitButton.isClicked(mouseX, mouseY) && state == WAITING) {
    // If the player presses the hitting button (and is in the game), send them into the hitting state.
    state = HITTING;
  }
  if (standButton.isClicked(mouseX, mouseY) && state == WAITING) {
    // If the player hits the stand button (and is in the game), send them into the standing state.
    state = STANDING;
  }

  if ((bet.isClicked(mouseX, mouseY) && state == START)) { // If the player presses bet, add (or subtract) the bet that they input into the textbox to their total bet.
    int newBet = 0; // Create a variable to store their new bet.
    if ((betInput.text.length()-1 > 10) || (betInput.text.length()-1 == 10 && betInput.text.charAt(1) > '2')) {
      betInput.text = "Invalid Input"; // If the bet does not fit in an int, don't let them bet it, instead, tell them it's an invalid bet.
      betInput.textLength = 0; // Reset the textbox's text length
    } else {
      newBet = int(betInput.text.substring(1, betInput.text.length()-1+1)); // Otherwise, set the user's new bet to what they inputted.
    }
    if (newBet != 0) { // If the user actually typed a bet:
      if ((newBet <= userTokens && betInput.isNegativeNumber == false) || (newBet <= currentBet && betInput.isNegativeNumber == true)) {
        // If the bet is within the value of the user's tokens (aka the user has enough tokens to withdraw/bet):
        if (betInput.isNegativeNumber == true) {
          newBet *= -1; // If the textbox is in subtraction mode, set their bet to a negative value.
        }
        userTokens -= newBet; // Subtract the new bet from the user's total tokens.
        currentBet += newBet; // Add the bet. (Note: this also works with negative values, it just does the opposite).
        newBet = 0; // Reset the "new bet" since we don't need it anymore.
        betInput.text = betInput.text.substring(0, 1); // Resets the textbox's text.
      } else {
        // If the user cannot put in/take out the bet, tell them it's invalod.
        betInput.text = "Invalid Input";
        betInput.textLength = 0;
      }
    }
    betInput.textLength = 0; // Reset the textbox's text length.
  }


  if (state == START) { // If the player presses their mouse anywhere, tell the textbox so that it can either be selected or unselected.
    betInput.pressed(mouseX, mouseY);
  }

  if (restartButton.isClicked(mouseX, mouseY) && (state == BUST || state == LOSE || state == WIN || state == DRAW || state == NATURAL)) {
    // If the player wants to restart the game (after finishing a game and clicking the restart button):
    //Adds 52 cards to the deck then shuffles them.
    deck.initializeDeck();
    deck.shuffle();

    // Clears both player and dealer hands to prepare for restarting the game.
    playerHand.clear();
    dealerHand.clear();

    // Deal 2 cards each to the dealer and player.
    for (int x = 0; x < 2; x++) {
      playerHand.addCard(deck.dealCard());
      dealerHand.addCard(deck.dealCard());
    }

    state = START; // Send the player to the start screen.
  }

  if (rulesButton.isClicked(mouseX, mouseY) && state == START) {
    // If the player clicks the rules button, show them the rules.
    state = RULES;
  }

  if (playButton.isClicked(mouseX, mouseY) && (state == RULES || state == SHOP)) {
    // If the player clicks the play button, make them go back to the start screen to play.
    state = START;
  }

  if (saveGameButton.isClicked(mouseX, mouseY) && state == START) {
    // Checks if the player clicks to save the game (save if they do).
    saveGameData();
  }

  if (loadGameButton.isClicked(mouseX, mouseY) && state == START) {
    // Checks to see if the player clicks to load the game (loads their game save if they do).
    loadGameData();
  }

  // Shop buttons:
  if (shopButton.isClicked(mouseX, mouseY) && state == START) {
    // Sends the player to the shop if they click the shop button.
    state = SHOP;
  }

  if (greenThemeButton.isClicked(mouseX, mouseY) && state == SHOP) {
    // If the player clicks the button to use the green theme:
    if (ownedThemes[0].equals("Green Theme")) { // Checks if the user owns the green theme.
      // Sets their theme to green.
      currentTheme = "Green Theme";
      setTheme();
    }
  }


  if (redThemeButton.isClicked(mouseX, mouseY) && state == SHOP) {
    // If the player clicks the button to use the red theme:
    if (!(ownedThemes[1].equals("Red Theme"))) { // If the user does not yet own the red theme:
      // Check if they have enough money for it:
      if (userTokens > 144) {
        userTokens -= 144; // If they do, subtract the money and add make them own the red theme.
        ownedThemes[1] = "Red Theme";
      }
    }
    if (ownedThemes[1].equals("Red Theme")) { // Checks if the user owns the red theme.
      // Sets the user's theme to red if they do.
      currentTheme = "Red Theme";
      setTheme();
    }
  }

  // If the player clicks the button to use the red theme:
  if (blackThemeButton.isClicked(mouseX, mouseY) && state == SHOP) {
    if (!(ownedThemes[2].equals("Black Theme"))) { // If the user does not yet own the black theme:
      // Check if they have enough money for it:
      if (userTokens > 255) {
        userTokens -= 255; // If they do, subtract the money and add make them own the red theme.
        ownedThemes[2] = "Black Theme";
      }
    }
    if (ownedThemes[2].equals("Black Theme")) { // Checks if the user owns the black theme.
      // Sets the user's theme to black if they own the theme.
      currentTheme = "Black Theme";
      setTheme();
    }
  }
}

// Description: A method to easily set the theme of the user.
// Parameters: Nothing.
// Returns: Nothing.
void setTheme() {
  // Sets the theme to whatever the user has currently selected (checks if their "currentTheme" is equal to each respective theme).
  if (currentTheme.equals("Green Theme")) {
    // Sets the theme to a nice green color.
    theme[0] = color(78, 106, 84);
    theme[1] = color(203, 209, 143);
  } else if (currentTheme.equals("Red Theme")) {
    // Sets the theme to red (with gold accents).
    theme[0] = color(151, 42, 39);
    theme[1] = color(255, 191, 23);
  } else if (currentTheme.equals("Black Theme")) {
    // Sets the theme to black (with white accents).
    theme[0] = color(105, 105, 105);
    theme[1] = color(220, 220, 220);
  }
}

void keyPressed() {
  // Resets the textbox back to the dollar sign so that the user can type numbers.
  if (betInput.text.equals("Invalid Input")) {
    betInput.text = "$"; // Resets the string holding the text in the textbox.
    betInput.textLength = 0; // Resets the length of the text.
  }
  betInput.isKeyPressed(key, (int)key); // Inserts the key typed into the textbox.
}
