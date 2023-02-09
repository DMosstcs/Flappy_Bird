public class Pipes {
  private int y;
  private int gapwidth = 400;
  private int x = width;
  public boolean last =true;
  private PImage Sprite = loadImage("Flappy Pipe.png");
  public Pipes(int x, int y) {

    this.x =x;
    this.y =y;
    this.last = true;
  }
  public void draw() {

    x -= 5;
    image(Sprite, x, y+gapwidth/2, 200, 750);
    pushMatrix();
    translate (x, y-gapwidth/2);
    scale(1.0, -1.0);


    image(Sprite, 0, 0, 200, 750);
    popMatrix();
  }
  public boolean checkcollision(int birdx, int birdy, int w, int h) {
    int r = w/2;
    int centerx = birdx + w/2;
    int centery = birdy +h/2;
    int pipe1y = this.y-(750 + gapwidth/2);
    if (birdy <= pipe1y+750 && birdy + h >= pipe1y && abs(centerx-(this.x+100))<= r) {

      return true;
    }
    int pipe2y = this.y+gapwidth/2;
    if (birdy <= pipe2y+750 && birdy + h >= pipe2y && abs(centerx-(this.x+100))<= r) {

      return true;
    }
    return false;
  }
}
