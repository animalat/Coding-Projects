// Thanks to github.com/mitkonikov for tutorial on textboxes in Processing.
public class Textbox {
  // Stores the x&y positions of the textbox, along with its width and height.
  public int xPos = 0, yPos = 0, height = 35, width = 200;

  // Stores colours for textbox
  public color background = color(227, 180, 72), backgroundSelected = color(237, 199, 111), border = color(30, 30, 30), foreground = color(0, 0, 0);

  // Stores the border information for the textbox.
  public boolean borderEnable = false;
  public int borderWeight = 1;

  // Stores text information (especially useful is the string, so that we can add the value to the bet
  public String text = "$";
  public int textLength = 0;
  final public int textSize = 15;
  color textColour = color(0, 255, 0);

  // Checks if there is a negative value entered.
  public boolean isNegativeNumber = false;

  public boolean selected = false; // Checks to see if the textbox is selected.

  // Description: Constructor method, initializes textbox with its x position, y position, width, and height
  // Parameters:
  // x, y: the x and y positions of the textbox
  // width, height: the width and height of the textbox.
  // Returns: Nothing.
  Textbox(int x, int y, int w, int h) {
    xPos = x;
    yPos = y;
    width = w;
    height = h;
  }

  // Description: Draws the textbox when called.
  // Parameters: Nothing.
  // Returns: Nothing.
  void drawTextbox() {
    // Draws the background of the box (for selecting and stuff).
    if (isNegativeNumber == false) {
      textColour = color(0, 255, 0); // This is for the addition mode.
    } else {
      textColour = color(255, 0, 0); // This is for the subtraction mode.
    }
    if (selected) { // Fills the box based on if its selected or not (darker for not selected).
      fill(backgroundSelected);
    } else {
      fill(background);
    }

    if (borderEnable) { // Box border
      strokeWeight(borderWeight);
      stroke(border);
    } else {
      noStroke();
    }

    // Draws the box
    rect(xPos, yPos, width, height);

    // Draws the text
    fill(textColour);
    textSize(textSize);
    text(text, xPos + (textWidth("a") / 2), yPos + textSize);
    fill(foreground);
  }

  // Description: Handles the text being added/sorted to the textbox. Only allows wanted text characters.
  // Parameters:
  // keyTyped - The actual character the user types.
  // keyType - The int value of the char the user types.
  // Returns: A true value if the user hits enter, otherwise, it handles calling other functions to add text to the textbox and returns false.
  boolean isKeyPressed(char keyTyped, int keyType) {
    if (selected) { // If the textbox is selected (clicked) by the user.
      if (keyType == (int)BACKSPACE) { // For the user deleting characters.
        backspace();
      } else if (keyType == (int)ENTER) { // For the user pressing enter.
        return true; // Returns true if the user hits enter.
      } else if (keyType == '-' || keyType == '_') {
        isNegativeNumber = !isNegativeNumber; // Changes the mode of the textbox (changes from addition to subtraction & vice versa).
      } else {
        // Check if the key typed is a number.
        // Only adds text to field if it's a number (because you shouldn't be able to add text).
        if (keyTyped >= '0' && keyTyped <= '9') {
          addText(keyTyped);
        }
      }
    }

    return false; // Returns false because the user didn't hit enter.
  }


  // Description: Adds text to the textbox.
  // Parameters:
  // textAdd - the char being added to the textbox.
  // Returns: Nothing.
  private void addText(char textAdd) {
    // If the text won't be outside the textbox, add the text.
    if (textWidth(text + textAdd) < width) {
      text += textAdd;
      textLength++;
    }
  }

  // Description: Handles removing character when the user presses backspace.
  // Parameters: Nothing.
  // Returns: Nothing.
  private void backspace() {
    if (textLength - 1 >= 1) { // If a character can be removed, remove it.
      text = text.substring(0, textLength - 1);
      textLength--; // Subtracts 1 from textLength because the length of the text is 1 less.
    }
  }

  // Description: Tests whether an (x,y) point is over (meaning, on top of) the textbox. This is to be used with mouseX and mouseY (in the mouseClicked method in the main file).
  // Parameters:
  // x - the x position of the inputted point.
  // y - the y position of the inputted point.
  // Returns: A true value if the point is over the textbox, a false value if it is not.
  private boolean overBox(int x, int y) {
    if (x >= xPos && x <= xPos + width) {
      if (y >= yPos && y <= yPos + height) {
        // If both the x value and y are within the area of the textbox, return true.
        return true;
      }
    }
    // If not then return false.
    return false;
  }

  // Description: Tells the program if a point is over the textbox. Similar to overBox, however, it tells the program to do things like change colour (through changed the "selected" boolean) unlike overBox.
  // Parameters:
  // x - the x position of the inputted point.
  // y - the y position of the inputted point.
  // Returns: A true or false value saying if the mouse
  boolean pressed(int x, int y) {
    if (overBox(x, y)) { // If the point is over the box, change selected to true to tell the program.
      selected = true;
    } else { // If the point is not over the textbox, change selected to false to tell the program.
      selected = false;
    }
    // Return true if the point is over the textbox, or return false if not.
    return selected;
  }
}
