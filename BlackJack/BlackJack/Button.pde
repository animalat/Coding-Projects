// Button class in it's own tab.
class Button // Çlickable buttons
{
  private int x, y; // x and y positions of the button
  private int width, height; // width and height of the button
  public color buttonColor; // the button's colour
  public String text; // the text in the button

  // Description: Sets the x, y, width, height, color, and text of the button.
  // Parameters: x (x position of button)), y (y position), width (width of button), height (height of button), color (colour that the button is), and text (text in the button)
  // Returns: Nothing.
  Button(int xArg, int yArg, int widthArg, int heightArg, color colorArg, String textArg)
  {
    // Sets all of the required variables.
    x = xArg;
    y = yArg;
    width = widthArg;
    height = heightArg;
    buttonColor = colorArg;
    text = textArg;
  }

  // Description: Draws the button, according to the specifications inputted into the constructor.
  // Parameters: Nothing.
  // Returns: Nothing.
  public void drawButton()
  {
    // Draws everything respectively
    //Sets colours, etc.
    fill(0, 0, 0);
    textSize(12);
    textAlign(LEFT);
    // Drawing the first button
    fill(buttonColor);
    rect(x, y, width, height);
    fill(0);
    text(text, x+10, y + height/2);
  }

  // Description: Checks if the button is clicked.
  // Parameters: xArg (the mouse's x position), yArg (the y value of the mouse being checked).
  // Returns: A true or false value based on whether the button is clicked or not respectively.
  public boolean isClicked(int xArg, int yArg)
  {
    if (xArg>=x && xArg <= (x + width) && yArg >= y && yArg <= (y + height)) // If mouse is hovering over the button:
    {
      return true; // Return true because the button was clicked.
    } else
    {
      return false; // Otherwise the button was not clicked.
    }
  }
}
