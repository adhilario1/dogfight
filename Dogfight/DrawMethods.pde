/***************
  DRAW METHODS
****************/
void loopBackground() {
  image(skyLoop, 0, img_y1);
  image(skyLoop, 0, img_y2);
  img_y1+=loopSpeed;
  img_y2+=loopSpeed;
  if(img_y1 >= height) img_y1=-(2*skyLoop.height)+height;
  if(img_y2 >= height) img_y2=-(2*skyLoop.height)+height;
}

void drawPlayer() {
  // Draw the player's plane
  if(left) ps_frame--;
  if (right) ps_frame++;
 
  if (ps_frame < 0) ps_frame = 0;
  if (ps_frame > 4) ps_frame = 4;
  player.display(ps_frame);
}
  
void drawEnemy(int clock) {
  // Draw the enemy planes
  for(Enemy enemy : enemies){
    enemy.display(clock);
    enemy.y+=enemy.speed;
  }
}
  

void drawAmmo () {
  for (Ammo ammo : ammoPax){
    ammo.display();
    ammo.y+=ammo.speed;
  }
}

void drawBullet() {
  for (Bullet bullet : playerBullets) {
    bullet.display();
    bullet.y -= player.speed*1.5;
  }
  
  for (Bullet bullet : enemyBullets) {
    bullet.display();
    bullet.y += player.speed*2.2;
  }
}
  
void drawHealth(){
  for (Health health : healthPax){
    health.display();
    health.y+=health.speed;
  }
}
