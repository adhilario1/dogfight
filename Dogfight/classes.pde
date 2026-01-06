/*****************
  OBJECT CLASSES
*****************/
class GameObj {
  int x, y, w, h, speed;
  
  GameObj(int x, int y, int w, int h, int speed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
  }
  
  void move() {
    y += speed;
  }
  
  boolean collides(GameObj obj) {
    if (x + w >= obj.x && x <= obj.x + obj.w && y + h >= obj.y && y <= obj.y + obj.h) {
      return true;
    } else {
      return false;
    }
  }
}

class Player extends GameObj {
  PImage[] sprites;
  Player(int x, int y, int w, int h, int s, PImage[] sprites) { 
    super(x,y,w,h,s); 
    this.sprites = sprites;
  }
  
  void display(int frame) {
    //imageMode(CORNER);
    image(sprites[frame], x, y, w, h);
  }
}
class Enemy extends GameObj {
  PImage[] sprites;
  Enemy(int x, int y, int w, int h, int s, PImage[] sprites) { 
    super(x,y,w,h,s); 
    this.sprites = sprites;
  }
  
  void display(int clock) {
    if (clock % 10 < 5) { //since the clock ticks every millisecond, 
                          //this qill slow down the 2 frame animation
                   
      image(sprites[0], x, y, w, h);
    } else {
      //imageMode(CORNER);
      image(sprites[1], x, y, w, h);
    }
  }
}

class Ammo extends GameObj {
  int refill;
  PImage img;
  
  Ammo(int x,int y,int w,int h,int s,int r, PImage img) {
    super(x,y,w,h,s);
    this.refill = r;
    this.img = img;
  }
  
  void display() {
    image(img, x, y);
  }
}

class Health extends GameObj {
  int refill;
  PImage img;
  
  Health(int x,int y,int w,int h,int s,int r, PImage img) {
    super(x,y,w,h,s);
    this.refill = r;
    this.img = img;
  }
  
  void display() {
    image(img, x, y);
  }
}

class Bullet {
  int x, y, w, h, speed;
  PImage img;
  Bullet(int x, int y, int w, int h, int speed, PImage img) {
    this.x = x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.speed=speed;
    this.img = img;
  }
  
  void move() {
    y += speed;
  }
  
  void display() {
    //imageMode(CENTER);
    image(img, x, y, w, h);
  }
  
  boolean collide(GameObj obj){
    if (x + w >= obj.x && x <= obj.x + obj.w && y + h >= obj.y && y <= obj.y + obj.h) {
      return true;
    } else {
      return false;
    }
  }
}
