//Name: nakshayan
//Starting date: April 7, 2022
//Description: A screensaver that makes cool designs.

int x = 0; //the x position for the shapes
int xSpeed = 3; //the speed at which the shapes move along the x axis

int y = 0; //the y position for the shapes
int ySpeed = 3; //the speed at which the shapes move along the y axis

void setup()
{
  size(800, 800); //set screen size to 800x800
  background(0);
  fill(150, 75, 150);
}

void draw()
{
  //background(0);
  
  //makes the ball bounce left and right (across the x axis)
  x+=xSpeed;
  if (x+x/4 > width)
  {
    // See if the ball is at the right edge then send the ball left
    xSpeed = -1*int(random(1, 11)); //random speed and colour
    fill(random(0, 256), random(0, 256), random(0, 256));
  } else if (x-x/4 < 0)
  {
    // See if the ball is at the left edge then send the ball right
    xSpeed = int(random(1, 11)); //random speed and colour
    fill(random(0, 256), random(0, 256), random(0, 256));
  }

  //makes the ball bounce up and down (along the y axis)
  y+=ySpeed;
  if (y+ y/4 > height) // if the ball goes too far down, make the ball start going up
  {
    //opposite random speed
    ySpeed = -1*int(random(1, 11));
    fill(random(0, 256), random(0, 256), random(0, 256));
  } else if (y- y/4 < 0) //if the ball goes too far up, make it start moving back down
  {
    //random speed and colour
    ySpeed = int(random(1, 11));
    fill(random(0, 256), random(0, 256), random(0, 256));
  }
  stroke(random(1, 256), random(1, 256), random(1, 256)); //set stroke to random colour
  line(x, y, width-x, height-y); //draw line with random stroke colour connecting the center points of both circles
  stroke(0); //set stroke back to black for circles
  ellipse(width-x, height-y, x/2, y/2); //circle starting from bottom right
  ellipse(x, y, x/2, y/2); //circle starting from top left
}
