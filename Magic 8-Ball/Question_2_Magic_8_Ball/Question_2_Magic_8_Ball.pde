//Name: Action
//Date: April 7, 2022
//Description: Question 2, draws a usable magic 8-ball
final int INTRO = 0; //constant for intro
final int BACK = 1; //constant for the back of the 8-ball
final int ADVICE = 2; //constant for the front of the 8-ball with the messages

int state = INTRO; //the state that the user can change to see different screens
int adviceNum = 0; //controls which advice message the 8-ball shows

void setup()
{ //set size stuff
  size (800, 600);
}


void draw()
{
  //background stuff
  background(20, 210, 220);

  if (state == INTRO)

  {
    //draws the intro screen with varying text sizes and colours
    fill(255, 255, 255);
    ellipse(400, 300, 300, 300); //circle
    textSize(22); //sets up text
    textAlign(CENTER);
    //messages on intro screen
    text("Welcome to the Magic 8-Ball Program!", 400, 120);
    textSize(12);
    fill(100, 100, 100);
    text("Ask a question", 400, 275);
    text("Then press \"B\" to see go to the back of the 8-Ball", 400, 300);
    text("After, press \"SPACE\" to see your advice", 400, 325);
    fill(255, 255, 255);
    textSize(22);
    text("Press \"B\" to begin!", 400, 500);
  } else if (state == BACK) //Back of 8-ball state
  {
    //draws the back of the magic 8-ball
    //shape stuff
    fill(0);
    ellipse(400, 300, 500, 500);
    fill(255, 255, 255);
    ellipse(400, 300, 300, 300);
    //text ready stuff
    fill(0);
    textAlign(CENTER);
    textSize(200);
    text("8", 400, 375);
    //types the text at the bottom of the screen
    textSize(22);
    fill(255, 255, 255);
    text("Press \"SPACE\" to see your advice", 400, 580);
  } else if (state == ADVICE)
  {
    //draws the front of the 8-ball with the advice
    fill(0);
    //some designs (triangles, etc, just appearence),
    ellipse(400, 300, 500, 500);
    fill(0, 0, 255);
    triangle(400, 75, 600, 425, 200, 425);
    //text
    textAlign(CENTER);
    textSize(30);
    fill(255, 255, 255);
    //outcomes
    if (adviceNum == 1) //all of the outcomes are here, chosen by a random number
    {
      text("Yes", 400, 300); //positive outcome
    } else if (adviceNum == 2)
    {
      text("It is certain", 400, 300); //positive outcome
    } else if (adviceNum == 3)
    {
      text("No", 400, 300); //negative outcome
    } else if (adviceNum == 4)
    {
      text("Impossible", 400, 300); //negative outcome
    } else if (adviceNum == 5)
    {
      text("Possibly...", 400, 300); //neutral outcome
    } else if (adviceNum == 6)
    {
      text("Definitely", 400, 300); //positive outcome
    } else if (adviceNum == 7)
    { 
      text("Certainly...", 400, 300); //positive outcome
    } else if (adviceNum == 8)
    {
      text("Without a", 400, 275); //positive outcome
      text("doubt...", 400, 300);
    } else if (adviceNum == 9)
    {
      text("With 100%", 400, 275); //positive outcome
      text("certainty", 400, 300);
    } else if (adviceNum == 10)
    {
      text("No way.", 400, 300); //negative outcome
    } else if (adviceNum == 11)
    {
      text("Cannot happen", 400, 300); //negative outcome
    } else if (adviceNum == 12)
    {
      text("Nope.", 400, 300); //negative outcome
    } else if (adviceNum == 13)
    {
      text("Could happen", 400, 300); //neutral outcome
    } else if (adviceNum == 14) {
      text("Maybe...", 400, 300); //neutral outcome
    }
    textSize(22);
    text("Press \"B\" to go back", 400, 580); //text at the bottom
  }
}


void keyPressed()
{
  //checks what key is pressed, only allows you to go from INTRO or ADVICE to BACK and from BACK to ADVICE
  if ((key == 'B' || key == 'b') && (state == ADVICE || state == INTRO))
  { //go to back of 8-ball
    state = BACK;
  } else if (key == ' ' && state == BACK) //go to advice
  {
    state = ADVICE;
    // Set adviceNum to a random number between 1 and 14. (random outcome)
    adviceNum = int(random(1, 15));
  }
}
