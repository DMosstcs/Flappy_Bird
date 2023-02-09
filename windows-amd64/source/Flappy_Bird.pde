import java.util.*;
import java.io.*;
PImage FlappyBird;
boolean paused = true;
int xBird = 0;
int yBird = 500;
int vBird  = 0;
int score = 0;
Table HighScores;
boolean hsScreen = false;
ArrayList<Pipes> pipes;
int PipeDistance = 450;
int MAXSCORES= 5;
String textString = "";
boolean textInput = false;

void setup() {
  FlappyBird = loadImage("Flappy bird.png");
  size(1000, 1000);
  pipes = new ArrayList<Pipes>();
  pipes.add(new Pipes(width, int (random(200, 800))));
  HighScores = loadTable("FlappyHighScore.csv", "header");
}

void draw() {
  background(#9DC7FF);
  textAlign(CENTER, CENTER);
  textSize(100);
  text(score, 500, 100);
  image(FlappyBird, xBird, yBird, 150, 120);
  if (paused == false) {
    if (yBird-vBird <= height)
      yBird -= vBird;
    if (vBird > -12)
      vBird -= 1;
    ListIterator<Pipes> itr = pipes.listIterator();
    while (itr.hasNext()) {
      Pipes pipe = itr.next();
      pipe.draw();
      if (pipe.x <= width-PipeDistance && pipe.last == true) {
        itr.add(new Pipes (int (width), int (random(200, 800))));
        pipe.last = false;
      }
      if (pipe.x <= 0) {
        itr.remove();
        score ++;
        print(score);
      } else if (pipe.checkcollision(xBird, yBird, 150, 120)) {
        paused = true;
        yBird = 500;
        break;
      }
    }

    if (paused == true) {
      pipes.clear();
      pipes.add(new Pipes(width, int (random(200, 800))));
      textInput = true;
    }
  }
  if (hsScreen == true) {
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);
    for (int i= HighScores.getRowCount()-1; i >= max(HighScores.getRowCount() - MAXSCORES,0); i--) {
      TableRow row = HighScores.getRow(HighScores.getRowCount() -1 -i);
      text(row.getInt("score") + "   "+ row.getString("name"), width/2, 300 +i*100);
    }
  }
  if (textInput ==true) {
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);
    text("Enter Initials", 500, 300);
    text(textString, 500, 500);
    textInput = true;
  }
}
void mouseClicked() {
  if(textInput == false && hsScreen == false){
  paused = false;

  vBird = 20;
  }
}
void keyPressed() {
  if (textInput == true) {
    if (key !=CODED) {
      String aloud ="abcdefghijklmnopqrstuvwxyz";
      String keyString = "" + key;
      if (aloud.contains(keyString.toLowerCase()))
        textString += keyString;
      else if (key == BACKSPACE && textString.length() > 0)

        textString = textString.substring(0, textString.length()-1);

      else if ( (key == ENTER || key == RETURN) &&  textString.length() > 0) {
        textInput =false;
        TableRow row = HighScores.addRow();
        row.setString("name", textString);
        row.setInt("score", score);
        HighScores.sort("score");
        saveTable(HighScores, "data/FlappyHighScore.csv");
        textString = "";
        hsScreen =true;
      }
    }
  } else if (  hsScreen == true) {
    hsScreen =false;
    score =0;
    paused = false;
  }
}
