//load level
PImage levelImg;
int level_progress;
// Set up the game window
void setup() {
  size(800, 800);
  levelImg = loadImage("data/level_1.png");
  level_progress = levelImg.height-1;
  println("running...");
}

// Set up the game variables


boolean gameOver = false;
//helps ease movement
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;

int playerX = 400;
int playerY = 500;
int playerW = 50;
int playerH = 50;
int playerSpeed = 5;
int strafeSpeed = 7;
int playerAmmo = 20;
int playerLives = 3;
int enemyCount = 10;
int score = 0;
int clock = 0;


/***************
  DRAW METHODS
****************/
void drawPlayer() {
  // Draw the player's plane
  fill(255, 255, 0); // yellow plane
  rect(playerX, playerY, playerW, playerH);
}
  
void drawEnemy() {
  // Draw the enemy planes
  for(Enemy enemy : enemies){
    enemy.display();
  }
}
  
void drawGndEnemy (int x, int y) {
}
  
void drawBullet() {
  for (Bullet bullet : playerBullets) {
    circle(bullet.x, bullet.y, 20);
    bullet.y -= playerSpeed*1.5;
  }
    
}
  
void drawBomb(){}

/******************
    MECHANICS
******************/

boolean bulletFired = false;

void keyPressed(){
  if (keyCode == UP || key == 'w') {
      up = true;
    } else if (keyCode == DOWN || key == 's') {
      down = true;
    } else if (keyCode == LEFT || key == 'a') {
      left = true;
    } else if (keyCode == RIGHT || key == 'd') {
      right = true;
    } else if (key == ' ') {
      if (playerAmmo > 0 && bulletFired == false) {
        fireBullet();
        //playerAmmo--;
      }
   }
}
void keyReleased(){
  if (key == ' ') {
    bulletFired = false;
  }
  
  if (keyCode == UP || key == 'w') {
    up = false;
  }
  if (keyCode == DOWN || key == 's') {
    down = false;
  } 
  if (keyCode == LEFT || key == 'a') {
    left = false;
  } 
  if (keyCode == RIGHT || key == 'd') {
    right = false;
  }
}

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
void generateObjects(int clock) {
  if (clock % 100 == 0){
    
    for(int w=1; w<levelImg.width-1; w++) {
      color obj_ref = levelImg.pixels[level_progress*levelImg.width+w];
      
      float r=red(obj_ref);
      float g=green(obj_ref);
      float b=blue(obj_ref);
      
      println(r);
      /*
      blue - ammo
      green - life
      red - enemy
      */
      if(r==255.0) {
        enemies.add(new Enemy(w*50, 0,50, 50, 50));
      }
      if (g==255.0) {
      }
      if (b==255.0) {
      }
      
    }
    println("--------------");
    level_progress--;
  }
}

void advanceObjects(int clock) {
  if (clock%10==0) {
    
    for (Enemy enemy : enemies) {
      enemy.y+=enemy.speed;
      enemy.display();
      if (enemy.y > height) enemies.remove(enemy);
    }
  }
}

void draw() {
  
  background(100, 200, 255); // sky blue background
  
  // Move the player
  if (up) {
    playerY -= playerSpeed;
    if (playerY < 100) playerY = 100;
  } 
  if (down) {
    
    playerY += playerSpeed;
    if (playerY > height - playerH) playerY = height - playerH;
  }
  if (left) {
    playerX -= strafeSpeed;
    if (playerX < 0) playerX = 0;
  }
  if (right) {
    playerX += strafeSpeed;
    if (playerX > width - playerW) playerX = width - playerW;
  } else if (key == ' ') {
    if (playerAmmo > 0 && bulletFired == false) {
      fireBullet();
      playerAmmo--;
    }
  }
  
  // Draw the player's ammo and lives
  textSize(16);
  fill(255);
  text("Ammo: " + playerAmmo, 10, 20);
  text("Lives: " + playerLives, 10, 40);
  text("Score: " + score, 10, 60);
  
  //draw assets
  drawPlayer();
  drawBullet();
  drawEnemy();
  
  gameLoop(clock);
  
  clock++;
  delay(1);
}

void gameLoop(int clock){
  checkGameover();
  
  if(level_progress > -1) generateObjects(clock);
  advanceObjects(clock);
  
  
  // Check for collisions between player's bullets and enemy planes
  for (int i = 0; i < playerBullets.size(); i++) {
    Bullet bullet = playerBullets.get(i);
    for (int j = 0; j < enemyCount; j++) {
      if (bullet.collidesWithEnemy(j*50+25, 75)) {
        enemyCount--;
        score += 10;
        playerBullets.remove(i);
        break;
      }
    }
  }
  
  // Move the enemy planes
  for (int i = 0; i < enemyCount; i++) {
    if (random(0, 100) < 5) {
      fireEnemyBullet(i*50+25, 75);
    }
    //moveEnemy(i);
  }
  
  // Check for collisions between enemy bullets and player's plane
  for (int i = 0; i < enemyBullets.size(); i++) {
    Bullet bullet = enemyBullets.get(i);
    if (bullet.collidesWithPlayer(playerX, playerY)) {
      playerLives--;
      enemyBullets.remove(i);
      break;
    }
  }
  
}

void checkGameover() {
  // Check for game over
  if (enemyCount == 0) {
    textSize(64);
    fill(255, 255, 0); // yellow text
    text("You win!", width/2-150, height/2-50);
    noLoop();
  } else if (playerLives == 0) {
    textSize(64);
    fill(255, 0, 0); // red text
    text("Game over", width/2-150, height/2-50);
    noLoop();
  }
}
// Fire a bullet from the player's plane
ArrayList<Bullet> playerBullets = new ArrayList<Bullet>();
void fireBullet() {
  bulletFired = true;
  playerBullets.add(new Bullet(playerX+25, playerY-10, 5, -10));
}

// Fire a bullet from an enemy plane
ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();
void fireEnemyBullet(int x, int y) {
  enemyBullets.add(new Bullet(x, y,5, 5));
}

/*
// Move an enemy plane
void moveEnemy(int i) {
  if (i % 2 == 0) {
    if (random(0, 100) < 5) {
      fireEnemyBullet(i*50+25, 75);
    }
    rect(i*50, 50, 50, 50);
  } else {
    rect(i*50, 100, 50, 50);
  }
}
*/
// A bullet class
