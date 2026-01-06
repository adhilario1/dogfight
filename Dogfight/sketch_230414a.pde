//game states
boolean g_start;
boolean play;
boolean g_end;


//load level
PImage levelImg;
int level_progress;

PImage skyLoop, bulletImg, healthImg, ammoImg;
PImage[] ps = new PImage[5]; //player sprite arrays
PImage[] es = new PImage[2];
int img_y1;//for looping background
int img_y2;


void setup() {
  size(800, 800);
  
  levelImg = loadImage("data/level_1.png");
  level_progress = levelImg.height-1;
  skyLoop = loadImage("data/sky_loop.png");
  img_y1=-skyLoop.height+height;
  img_y2=img_y1-skyLoop.height;
  
  //player
  ps[0] = loadImage("data/player_sprite_1.png");
  ps[1] = loadImage("data/player_sprite_2.png");
  ps[2] = loadImage("data/player_sprite_3.png");
  ps[3] = loadImage("data/player_sprite_4.png");
  ps[4] = loadImage("data/player_sprite_5.png");
  
  //enemy
  es[0] = loadImage("data/enemy_sprite_1.png");
  es[1] = loadImage("data/enemy_sprite_2.png");
  
  //bullets
  bulletImg = loadImage("data/bullets.png");
  healthImg = loadImage("data/health.png");
  ammoImg=loadImage("data/ammo.png");
  
  println("running...");
}

// Set up the game variables
boolean gameOver = false;
//helps ease movement
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;

Player player = new Player(400, 500, 70, 70, 5, ps);
/*
player default values:

playerX = 400;
playerY = 500;
playerW = 50;
playerH = 50;
playerSpeed = 5;
*/
int ps_frame = 2; //player sprite frame 
int strafeSpeed = 7;
int playerAmmo = 20;
int playerLives = 3;
int enemyCount = 10;
int score = 0;
int clock = 0;

//background
int loopSpeed=5;


void draw() {
  
  background(40, 94, 161); // sky blue background
  loopBackground();
  // Move the player
  if (up) {
    player.y -= player.speed;
    if (player.y < 100) player.y = 100;
  } 
  if (down) {
    player.y += player.speed;
    if (player.y > height - player.h) player.y = height - player.h;
  }
  if (left) {
    player.x -= strafeSpeed;
    if (player.x < 0) player.x = 0;
    
  }
  if (right) {
    player.x += strafeSpeed;
    if (player.x > width - player.w) player.x = width - player.w;
  } else if (key == ' ') {
    if (playerAmmo > 0 && bulletFired == false) {
      bulletFired = true;
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
  
  gameLoop(clock);
  
  clock++;
  delay(1);
}

void gameLoop(int clock){
  checkGameover();
  
  drawPlayer();
  drawBullet();
  drawEnemy(clock);
  drawAmmo();
  drawHealth();
  
  generateObjects(clock);
  //advanceObjects(clock);
  
  //health collisions
  for (Health health : healthPax) {
    if (player.collides(health)) {
      playerLives+= health.refill;
      healthPax.remove(health);
      break;
    }
  }
  
  // Check for collisions between player's bullets and enemy planes
  for (int i = 0; i < playerBullets.size(); i++) {
    Bullet bullet = playerBullets.get(i);
    for (Enemy enemy : enemies) {
      if (bullet.collide(enemy)) {
        enemies.remove(enemy);
        score += 10;
        playerBullets.remove(i);
        break;
      }
    }
  }
  
  //check collision between planes
  for (Enemy enemy : enemies) {
    if(player.x > enemy.x - 50 && player.x < enemy.x +50 && clock%25==0) {
      println(clock);
      fireEnemyBullet(enemy.x+25, enemy.y);
    }
    if (player.collides(enemy)) {
      playerLives--;
      enemies.remove(enemy);
      break;
    }
    if (enemy.y > height) {
      enemies.remove(enemy);
      break;
    }
  }
  
  //check collosion between planes and enemy bullets
  for (Bullet bullet : enemyBullets) {
    if (bullet.collide(player)) {
      enemyBullets.remove(bullet);
      playerLives--;
      break;
    }
  }
  
  //check collison between player and ammo packs
  for (Ammo ammo : ammoPax) {
    if (player.collides(ammo)) {
      playerAmmo+= ammo.refill;
      ammoPax.remove(ammo);
      break;
    }
  }
  
  
}
