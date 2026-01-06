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
    ps_frame = 2;
    left = false;
  } 
  if (keyCode == RIGHT || key == 'd') {
    ps_frame = 2;
    right = false;
  }
}

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Ammo> ammoPax = new ArrayList<Ammo>();
ArrayList<Health> healthPax = new ArrayList<Health>();
void generateObjects(int clock) {
  if (clock % 100 == 0 && level_progress > -1){
    
    for(int w=1; w<levelImg.width-1; w++) {
      color obj_ref = levelImg.pixels[level_progress*levelImg.width+w];
      
      float r=red(obj_ref);
      float g=green(obj_ref);
      float b=blue(obj_ref);
      /*
      blue - ammo
      green - life
      red - enemy
      */
      if(r==255.0) {
        enemies.add(new Enemy(w*50, 0,50, 50, 5, es));
      }
      if (g==255.0) {
        healthPax.add(new Health(w*50, 0, 50, 50, 3, 1, healthImg));
      }
      if (b==255.0) {
        ammoPax.add(new Ammo(w*50, 0, 50, 50, 3, 10, ammoImg));
      }
      
    }

    level_progress--;
  }
}

/*
void advanceObjects(int clock) {
  if (clock%1==0) {
    for (Enemy enemy : enemies) {
      
    }
    for (Ammo ammo : ammoPax) {
      
    }
  }
}
*/

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
  playerBullets.add(new Bullet(player.x+28, player.y-10, 15, 10, -10, bulletImg));
}

// Fire a bullet from an enemy plane
ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();
void fireEnemyBullet(int x, int y) {
  bulletFired = true;
  enemyBullets.add(new Bullet(x, y,15, 10, 5, bulletImg));
}
