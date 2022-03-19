//Name: Actio
//Date; February 23, 2022
//Description: Draws a landscape with a castle (from BOTW).
//Inspired by https://www.youtube.com/watch?v=2cmQfzG4VJs and https://wallpaperaccess.com/zelda-dual-screen - thanks!


void setup()
{
  size(450, 747);
  background(255, 255, 255);

  //Gradient
  float redStart = 118;
  float greenStart = 161;
  float blueStart = 239;

  // Speed 1 transitions fast, 2 transitions slow.
  float speedOfTransition = 3;

  // Y start offset to start 
  int yOffset = 50;

  for (int y=0; y<=747; y=y+1)
  {
    redStart = redStart + 0.120481928;
    greenStart = greenStart + 0.222222222;
    blueStart = blueStart + 0.0214190094;
    stroke(redStart, greenStart, blueStart);
    line(0, y, 450, y);
  }
  //grid
  /*size(450, 747);
   background(255, 255, 255);
   // up-down grid lines
   stroke(128, 128, 128);
   for (int x =100; x<450; x=x+100)
   {
   line(x, 0, x, 747);
   fill(0, 0, 0);
   text(str(x), x-30, 10);
   }
   // side-side grid lines
   stroke(128, 128, 128);
   for (int y=100; y<=747; y=y+100)
   {
   line(0, y, 450, y);
   fill(0, 0, 0);
   text(str(y), 5, y);
   }
   // ADD YOUR CODE HERE*/
  noStroke();

  //far background hills
  fill(122, 234, 249);
  beginShape();
  curveVertex(60, 410);
  curveVertex(60, 410);
  curveVertex(100, 390);
  curveVertex(140, 385);
  curveVertex(175, 400);
  curveVertex(230, 405);
  curveVertex(300, 385);
  curveVertex(400, 385);
  curveVertex(500, 400);
  curveVertex(600, 800);
  curveVertex(0, 800);
  curveVertex(0, 800);
  endShape();

  //background hills
  fill(103, 218, 233);
  beginShape();
  curveVertex(0, 410);
  curveVertex(0, 410);
  curveVertex(60, 405);
  curveVertex(100, 430);
  curveVertex(200, 450);
  curveVertex(300, 430);
  curveVertex(400, 440);
  curveVertex(600, 800);
  curveVertex(0, 800);
  curveVertex(0, 800);
  endShape();

  //castle (IMPORTANT MARKER)
  fill(101, 204, 217);
  beginShape();
  vertex(32, 490);
  vertex(50, 470);
  vertex(60, 467);
  vertex(59, 455);
  vertex(70, 465);
  vertex(85, 430);
  //vertex(80, 410);
  //vertex(90, 435);
  vertex(85, 397); //marker
  vertex(80, 390);
  vertex(80, 387);
  vertex(85, 385);
  vertex(95, 360);
  // vertex(105, 385);
  vertex(105, 385);
  vertex(110, 387);
  vertex(110, 390);
  vertex(105, 397);
  vertex(105, 408);
  vertex(107, 410);
  vertex(109.5, 420);
  vertex(120, 435);
  vertex(135, 410);
  vertex(130, 400);
  vertex(138, 395);
  vertex(135, 360);
  vertex(140, 368);
  vertex(148, 365);
  vertex(150, 352);
  vertex(155, 380);
  vertex(160, 340);
  vertex(165, 365);
  vertex(175, 360);
  vertex(168, 350);
  vertex(172, 340);
  vertex(176, 348);
  vertex(185, 335);
  vertex(187, 340);
  vertex(188, 315);
  vertex(184, 310);
  vertex(188, 309);
  vertex(198, 290);
  vertex(208, 308);
  vertex(212, 309);
  vertex(208, 312);
  vertex(208, 320);
  vertex(218, 310); //marker
  vertex(218, 290);
  vertex(215, 290);
  vertex(215, 280);
  vertex(218, 280);
  vertex(218, 265);
  vertex(215, 267.5);
  vertex(218, 270);
  vertex(230, 205);
  vertex(242, 265);
  vertex(245, 267.5);
  vertex(242, 270);
  vertex(242, 280);
  vertex(245, 280);
  vertex(245, 290);
  vertex(242, 290);
  vertex(242, 310);
  vertex(250, 318);
  vertex(250, 310); //marker
  vertex(247, 307.5);
  vertex(250, 305);
  vertex(258, 275);
  vertex(266, 305);
  vertex(269, 307.5);
  vertex(266, 310);
  vertex(266, 315);
  vertex(269, 317.5);
  vertex(266, 323);
  vertex(266, 330);
  vertex(270, 335);
  vertex(275, 315);
  vertex(280, 320);
  vertex(287, 312);
  vertex(284, 330);
  vertex(285, 340);
  vertex(305, 320);
  vertex(292, 345);
  vertex(295, 347);
  vertex(295+14.14, 340);
  vertex(300, 351);
  vertex(302, 357);
  vertex(302, 380); //marker
  vertex(308+4.89, 387);
  vertex(317, 380);
  vertex(314, 377.5);
  vertex(317, 375);
  vertex(322, 360);
  vertex(327, 375);
  vertex(330, 377.5);
  vertex(327, 380);
  vertex(325+5.94, 380+7.94);
  vertex(340, 388);
  vertex(330, 403);
  vertex(334+10.4, 397);
  vertex(332+10.4, 375.5);
  vertex(338+10.4, 380);
  vertex(341+10.4, 374);
  vertex(346+10.4, 400);
  vertex(9999, 3950);
  endShape();

  //air
  fill(165, 250, 249);
  beginShape();
  vertex(302, 405);
  vertex(302, 395);
  vertex(312, 405);
  endShape();

  //colosseum
  fill(92, 191, 204);
  beginShape();
  vertex(200, 600);
  vertex(200, 420);
  vertex(195, 415);
  vertex(195, 405);
  vertex(340, 402);
  vertex(340, 600);
  endShape();
  beginShape();
  curveVertex(340, 420);
  curveVertex(340, 420);
  curveVertex(400, 422);
  curveVertex(400, 800);
  curveVertex(300, 800);
  curveVertex(300, 800);
  endShape();
  beginShape();
  vertex(345, 410);
  vertex(345, 420);
  vertex(355, 420);
  vertex(355, 390);
  vertex(365, 390);
  vertex(365, 380);
  vertex(375, 380);
  vertex(375, 410);
  endShape(CLOSE);

  //windows
  stroke(101, 204, 217);
  fill(101, 204, 217);
  arc(230, 460, 30, 70, PI, TWO_PI); //arc(x, y, x, y, PI, TWO_PI);
  arc(272, 460, 35, 81.6, PI, TWO_PI);
  arc(315, 460, 30, 70, PI, TWO_PI);
  noFill();
  strokeWeight(0.1);
  stroke(131, 234, 237);
  arc(230, 460, 30, 70, PI, TWO_PI);
  arc(272, 460, 35, 81.6, PI, TWO_PI);
  arc(315, 460, 30, 70, PI, TWO_PI);
  noStroke();

  //lower wall
  fill(91, 187, 199);
  beginShape();
  vertex(130, 520);
  vertex(130, 470);
  vertex(150, 470);
  vertex(150, 450);
  vertex(430, 450);
  vertex(430, 700);
  endShape(CLOSE);
  beginShape();
  curveVertex(130, 470);
  curveVertex(130, 470);
  curveVertex(150, 450);
  curveVertex(200, 480);
  curveVertex(200, 800);
  curveVertex(200, 800);
  endShape(CLOSE);

  //ground layer 5
  fill(87, 176, 187);
  beginShape();
  curveVertex(0, 485);
  curveVertex(0, 485);
  curveVertex(220, 510);
  curveVertex(360, 530);
  curveVertex(450, 540);
  curveVertex(450, 540);
  curveVertex(480, 800);
  curveVertex(480, 800);
  curveVertex(0, 800);
  curveVertex(0, 800);
  endShape();

  //bridge part 1
  beginShape();
  vertex(220, 500+10);
  vertex(220, 490+10);
  vertex(260, 490+10);
  vertex(260, 480+10);
  vertex(270, 480+10);
  vertex(270, 470+10);
  vertex(280, 470+10);
  vertex(283, 490);
  vertex(300, 490);
  vertex(303, 530);
  endShape(CLOSE);

  // ground layer 4
  fill(0, 160, 186);
  beginShape();
  curveVertex(0, 560);
  curveVertex(0, 560);
  curveVertex(275, 590);
  curveVertex(450, 540);
  curveVertex(480, 800);
  curveVertex(480, 800);
  curveVertex(0, 800);
  curveVertex(0, 800);
  endShape();

  //stone left
  fill(0, 160, 186);
  beginShape();
  vertex(40, 320); //marker
  vertex(60, 340);
  vertex(0, 680);
  vertex(0, 390);
  vertex(15, 325);
  endShape(CLOSE);
  noFill();
  stroke(161, 264, 267);
  strokeWeight(1.5);
  line(40, 320, 60, 340);
  line(0, 390, 15, 325);
  line(15, 325, 40, 320);
  line(60, 340, 50.5, 402);
  noStroke();

  //stone right
  fill(0, 160, 186);
  beginShape();
  vertex(400, 320);
  vertex(380, 340);
  vertex(450, 680);
  vertex(450, 390);
  vertex(435, 325);
  endShape();
  noFill();
  strokeWeight(1.5);
  stroke(161, 264, 267);
  line(435, 325, 444.7, 364.2);
  line(400, 320, 380, 340);
  line(400, 320, 435, 325);
  line(380, 340, 388, 385);
  noStroke();

  //ground layer 3
  fill(8, 142, 167);
  beginShape();
  curveVertex(0, 605);
  curveVertex(0, 605);
  curveVertex(300, 600);
  curveVertex(450, 610);
  curveVertex(500, 610);
  curveVertex(500, 800);
  curveVertex(0, 800);
  curveVertex(0, 800);
  endShape();

  //water
  fill(73, 173, 176);
  beginShape();
  vertex(100, 700);
  vertex(280, 640);
  vertex(360, 645);
  curveVertex(450, 640);
  curveVertex(450, 640);
  curveVertex(480, 700);
  curveVertex(480, 700);
  curveVertex(0, 700);
  endShape(CLOSE);

  //reflection
  fill(45, 168, 180);
  beginShape();
  curveVertex(280, 640);
  curveVertex(280, 640);
  curveVertex(320, 650);
  curveVertex(360, 645);
  curveVertex(360, 645);
  endShape();

  //ground layer 2
  fill(18, 129, 149);
  beginShape();
  curveVertex(0, 670);
  curveVertex(0, 670);
  curveVertex(75, 675);
  curveVertex(250, 665);
  curveVertex(340, 670);
  curveVertex(450, 675);
  curveVertex(500, 800);
  curveVertex(0, 800);
  curveVertex(0, 800);
  endShape();

  //ground layer 1
  fill(21, 88, 105);
  rect(0, 710, 450, 50);
  beginShape();
  curveVertex(0, 700);
  curveVertex(0, 700);
  curveVertex(100, 705); //marker
  //  curveVertex(175, 705); //marker
  curveVertex(340, 670); //marker
  curveVertex(450, 660); //marker
  curveVertex(475, 660); //marker
  curveVertex(500, 800);
  curveVertex(500, 800);
  curveVertex(0, 800);
  curveVertex(0, 800);
  endShape();

  //tree
  fill(21, 88, 105);
  beginShape();
  curveVertex(0, 170);
  curveVertex(0, 170);
  curveVertex(30, 165);
  curveVertex(50, 180);
  curveVertex(60, 170);
  curveVertex(55, 160);
  curveVertex(70, 170);
  curveVertex(78, 150);
  curveVertex(65, 140);
  curveVertex(50, 125);
  curveVertex(40, 115);
  curveVertex(75, 100);
  curveVertex(85, 92);
  curveVertex(100, 105);
  curveVertex(105, 95);
  curveVertex(112, 97);
  curveVertex(120, 110);
  curveVertex(135, 113);
  curveVertex(150, 111);
  curveVertex(155, 130);
  curveVertex(175, 125);
  curveVertex(170, 115);
  curveVertex(175, 110);
  curveVertex(175, 105);
  curveVertex(168, 104);
  curveVertex(150, 95);
  curveVertex(150, 95);
  curveVertex(160, 85);
  curveVertex(165, 90);
  curveVertex(158, 75);
  curveVertex(178, 65);
  curveVertex(170, 60);
  curveVertex(180, 51);
  curveVertex(165, 52);
  curveVertex(168, 47);
  curveVertex(170, 36);
  curveVertex(177, 32);
  curveVertex(182, 45);
  curveVertex(188, 32);
  curveVertex(184, 15);
  // curveVertex(180, 7);
  curveVertex(188, 0);
  // curveVertex(170, 0);
  curveVertex(0, 0);
  curveVertex(0, 0);
  endShape();

  //grass
  /*noFill();
   stroke(21, 88, 105);
   strokeWeight(2);
   arc(20, 705, 30, 20, (3*PI)/2, TWO_PI);
   arc(50, 705, 30, 20, PI, 3*PI/2-0.25); //marker
   arc(70, 707, 30, 20, (3*PI)/2+0.5, TWO_PI);
   arc(100, 707, 30, 20, PI, 3*PI/2); //marker
   arc(160, 701, 30, 20, (3*PI)/2+0.25, TWO_PI);
   arc(190, 701, 30, 20, PI, 3*PI/2-0.25); //marker
   arc(115, 702, 30, 20, (3*PI)/2+0.25, TWO_PI);
   arc(145, 702, 30, 20, PI, 3*PI/2-0.25); //marker
   noFill();
   strokeWeight(5);
   beginShape();
   curveVertex(20, 700);
   curveVertex(20, 700);
   curveVertex(15, 688);
   curveVertex(5, 680);
   curveVertex(5, 680);
   endShape();
   beginShape();
   beginShape();
   curveVertex(20, 700);
   curveVertex(20, 700);
   curveVertex(25, 684);
   curveVertex(35, 685);
   curveVertex(35, 685);
   endShape();
   arc(200, 690, 30, 20, (3*PI)/2+0.25, TWO_PI);*/

  /*//plant
   noFill();
   stroke(21, 88, 105);
   strokeWeight(2);
   beginShape();
   curveVertex(25, 710);
   curveVertex(25, 710);
   curveVertex(17, 675);
   curveVertex(35, 650);
   curveVertex(30, 620);
   curveVertex(30, 620);
   endShape();
   fill(21, 88, 105);
   beginShape(); //leaf
   curveVertex(30, 620);
   curveVertex(30, 620);
   curveVertex(20, 595);
   curveVertex(21, 610);
   curveVertex(25, 625);
   endShape(); */

  //castle lights (IMPORTANT MARKER)
  //stroke(164, 225, 233);
  fill(131, 214, 224);
  ellipse(230, 330, 42, 42);
  fill(165, 225, 233);
  ellipse(230, 330, 28, 28);
  fill(164, 225, 233);
  ellipse(230, 330, 20, 20);
  fill(227, 246, 248);
  ellipse(230, 330, 14, 14);
}
