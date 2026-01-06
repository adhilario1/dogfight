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
}
class Enemy extends GameObj {
  
  Enemy(int x, int y, int w, int h, int s) { 
    super(x,y,w,h,s); 
  }
  
  void display() {
    fill(255, 0, 0); // red enemy planes
    rect(x, y, w, h);
  }
}

class Bullet {
  int x, y, r, speed;
  
  Bullet(int x, int y, int r, int speed) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.speed = speed;
  }
  
  void move() {
    y += speed;
  }
  
  void display() {
    fill(255);
    rect(x, y, 5, 10);
  }
  
  boolean collide(GameObj obj){
    return true;
  }
  
  boolean collidesWithEnemy(int x, int y) {
    if (this.x >= x-25 && this.x <= x+25 && this.y >= y-25 && this.y <= y+25) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean collidesWithPlayer(int x, int y) {
    if (this.x >= x-25 && this.x <= x+25 && this.y >= y-25 && this.y <= y+25) {
      return true;
    } else {
      return false;
    }
  }
}
