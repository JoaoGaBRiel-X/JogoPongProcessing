import processing.sound.*;

SoundFile bounceSound, pointSound;

int gameState = 0;
int menuSelection = 0;
int menuSelection2 = 0;
int settingsSelection = 0;
int player1Sprite = 0;
int player2Sprite = 1;
int ballSprite = 0;
int backgroundSprite = 0;

PImage[] playerSprites = new PImage[3];
PImage[] ballSprites = new PImage[3];
PImage[] backgroundSprites = new PImage[3];

PImage player1;
PImage player2;
PImage ball;
PImage background;

int player1Score = 0;
int player2Score = 0;

float player1Y;
float player2Y;
float player1Speed = 5;
float player2Speed = 5;

float ballX;
float ballY;
float ballSpeedX = 3;
float ballSpeedY = 3;
float ballRadius = 10;

boolean player1Up = false;
boolean player1Down = false;
boolean player2Up = false;
boolean player2Down = false;

int rotacao = 0;
int cont = 0;

void setup() {
  size(800, 450);
  frameRate(60);
  smooth();

  playerSprites[0] = loadImage("BarraTeste.png");
  playerSprites[1] = loadImage("BarraTeste2.png");
  playerSprites[2] = loadImage("BarraTeste3.png");

  ballSprites[0] = loadImage("BolaTeste.png");
  ballSprites[1] = loadImage("BolaTeste2.png");
  ballSprites[2] = loadImage("BolaTeste3.png");

  backgroundSprites[0] = loadImage("windowsxp.jpg");
  backgroundSprites[1] = loadImage("Tornado.jpg");

  player1 = playerSprites[player1Sprite];
  player2 = playerSprites[player2Sprite];
  ball = ballSprites[ballSprite];
  background = backgroundSprites[backgroundSprite];

  bounceSound = new SoundFile(this, "bounce.wav");
  pointSound = new SoundFile(this, "ponto.wav");
  
  ball.resize(30,30);
  background.resize(800,450);
}

void draw() {
  //background(0);

  if (gameState == 0) {
    drawMenu();
  } else 
  if (gameState == 1) {
    drawGame();
  } else
  if (gameState == 2) {
    drawFinish();
  }else
  if (gameState == 3) {
    drawSettings1();
  } else 
  if (gameState == 4) {
    drawSettings2();
  } else 
  if (gameState == 5) {
    drawCreditos();
  } else 
  if (gameState == 6) {
    drawSettings3();
  }
}

void drawMenu() {
  background(0);
  textSize(90);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG", width/2, 50);

  textSize(30);
  fill(255);
  text("Jogar (J)", width/2, height-270);
  for (int i = 0; i < 3; i++) {
    if (i == menuSelection) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
    if(i == 0){
      text("Fácil", width/2 - 100, height/2);
    }
    if(i == 1){
      text("Médio", width/2, height/2);
    }
    if(i == 2){
      text("Difícil", width/2 + 100, height/2);
    }
    
  }  
  textSize(20);
  fill(255);
  text("Personalização: ", width/2, height-120);
  text("Cenário (C) - Bola (B) - Paddle (P)", width/2, height-80);
  text("Créditos (T)", width-700, height-40);
}

void drawCreditos() {
  background(0);
  textSize(90);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG - CRÉDITOS", width/2, 50);

  textSize(25);
  text("Integrantes do Projeto: ", width/2, height-250);
  text("Enrico Giovani Fernandes Bariola - RA: 001202002911", width/2, height-210);
  text("João Gabriel Moraes Carvalho - RA: 001202009395", width/2, height-170);
  text("Kevin Balzan Lusiani - RA: 001202002897", width/2, height-130);
  text("Voltar (ESPAÇO)", width/2, height-40);
}

void drawFinish() {
  background(0);
  textSize(90);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG - VENCEDOR", width/2, 50);

  textSize(25);
  text("Vencedor: ", width/2, height/2);
  textSize(35);
  if(player1Score > player2Score){
    text("Player 1", width/2, height/2+30);
  } else {
    text("Player 2", width/2, height/2+30);
  }
  text("Voltar para o MENU(ESPAÇO)", width/2, height-40);
}

void drawSettings1() { // Cenario
  background.resize(800,450);
  background(background);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG - CENÁRIO", width/2, 50);
  
  textSize(25);
  for (int i = 0; i < 2; i++) {
    if (i == menuSelection) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
    text("Background " + ((i == 0)?" - Windows XP" : " - Tempestade"), width/2, 150 + 60 * i);
  }

  textSize(25);
  fill(255);
  text("Voltar (ESPAÇO)", width/2, height-40);
  
  if(menuSelection == 0){
    background = backgroundSprites[0];
  } else {
    background = backgroundSprites[1];
  }
}

void drawSettings2() { // Bola
  ball.resize(30,30);
  background(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG - BOLA", width/2, 50);
  
  textSize(25);
  for (int i = 0; i < 3; i++) {
    if (i == menuSelection) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
    if(i == 0){
      text("Bola Futebol", width/4, 150 + 60 * i);
    }
    if(i == 1){
      text("Bola Basquete", width/4, 150 + 60 * i);
    }
    if(i == 2){
      text("Bola Praia", width/4, 150 + 60 * i);
    }
    
  }

  textSize(25);
  fill(255);
  text("Voltar (ESPAÇO)", width/2, height-40);
  
  translate(width/4*3, height/2);
  rotate(radians(rotacao));
  image(ballSprites[menuSelection], -50, -50, 100, 100);
  if (rotacao >= 360) rotacao = 0;
  rotacao += 5;
}
void drawSettings3() {
  background(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG PADDLE", width/2, 50);
  
  textSize(25);
  text("Paddle Player 1", width/4, 120);
  text("Paddle Player 2", width/4*3, 120);
  for (int i = 0; i < 3; i++) {
    if (i == menuSelection) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
    if(i == 0){
      text("Azul", width/4, 160 + 40 * i);
    }
    if(i == 1){
      text("Vermelho", width/4, 160 + 40 * i);
    }
    if(i == 2){
      text("Preto", width/4, 160 + 40 * i);
    }
    
  }
  for (int i = 0; i < 3; i++) {
    if (i == menuSelection2) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
    if(i == 0){
      text("Azul", width/4*3, 160 + 40 * i);
    }
    if(i == 1){
      text("Vermelho", width/4*3, 160 + 40 * i);
    }
    if(i == 2){
      text("Preto", width/4*3, 160 + 40 * i);
    }
    
  }

  textSize(25);
  fill(255);
  text("Voltar (ESPAÇO)", width/2, height-40);
}



void drawGame() {
  background(background);

  textSize(30);
  fill(255);
  text(player1Score, width/4, 50);
  text(player2Score, 3*width/4, 50);

  // Player 1 movement
  if (player1Up) {
    player1Y -= player1Speed;
  }
  if (player1Down) {
    player1Y += player1Speed;
  }
  player1Y = constrain(player1Y, 0, height - player1.height);

  // Player 2 movement
  if (player2Up) {
    player2Y -= player2Speed;
  }
  if (player2Down) {
    player2Y += player2Speed;
  }
  player2Y = constrain(player2Y, 0, height - player2.height);

  // Ball movement
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // Ball collision with walls
  if (ballY - ballRadius < 0 || ballY + ballRadius > height) {
    bounceSound.play();
    ballSpeedY *= -1;
    
  }

  // Ball collision with paddles
  if (ballX - ballRadius < player1.width && ballY > player1Y && ballY < player1Y + player1.height) {
    if (ballSpeedX < 0) {
      bounceSound.play();
      ballSpeedX *= -1;
      
    }
  }

  if (ballX + ballRadius > width - player2.width && ballY > player2Y && ballY < player2Y + player2.height) {
    if (ballSpeedX > 0) {
      ballSpeedX *= -1;
      bounceSound.play();
    }
  }

  // Ball scoring
  if (ballX - ballRadius < 0) {
    player2Score++;
    pointSound.play();
    resetBall();
  }

  if (ballX + ballRadius > width) {
    player1Score++;
    pointSound.play();
    resetBall();
  }

  // Draw paddles and ball
  image(player1, 0, player1Y);
  image(player2, width - player2.width, player2Y);
  image(ball, ballX - ball.width / 2, ballY - ball.height / 2, ball.width, ball.height );

  // Check for game over
  if (player1Score >= 5 || player2Score >= 5) {
    gameState = 2;
  }
}

void resetBall() {
  ballX = width/2;
  ballY = height/2;
  ballSpeedX = abs(ballSpeedX) * (random(0, 1) > 0.5 ? 1 : -1);
  ballSpeedY = abs(ballSpeedY) * (random(0, 1) > 0.5 ? 1 : -1);
}


void keyPressed() {
  if (gameState == 0) {
    if (keyCode == LEFT) {
      menuSelection--;
      if (menuSelection < 0) {
        menuSelection = 2;
      }
    } else if (keyCode == RIGHT) {
      menuSelection++;
      if (menuSelection > 2) {
        menuSelection = 0;
      }
    } else if(keyCode == 'J' || keyCode == 'j'){
      if(menuSelection == 0){
        ballSpeedX = 3;
        ballSpeedY = 3;
        player1Speed = 5;
        player2Speed = 5;
      } else if (menuSelection == 1){
        ballSpeedX = 6;
        ballSpeedY = 6;
        player1Speed = 8;
        player2Speed = 8;
      } else if (menuSelection == 2){
        ballSpeedX = 9;
        ballSpeedY = 9;
        player1Speed = 11;
        player2Speed = 11;
      }
      gameState = 1;
      resetBall();
      player1Y = height/2 - player1.height/2;
      player2Y = height/2 - player2.height/2;
    } else
    if (keyCode == 'C' || keyCode == 'c') {
      menuSelection = 0;
      gameState = 3;
    } else
    if (keyCode == 'B' || keyCode == 'b') {
      menuSelection = 0;
      gameState = 4;
    } else
    if (keyCode == 'T' || keyCode == 't') { 
      menuSelection = 0;
      gameState = 5;
    } else
    if (keyCode == 'P' || keyCode == 'p') { 
      menuSelection = player1Sprite;
      menuSelection2 = player2Sprite;
      gameState = 6;
    }
    
  }
  if (gameState == 1) {
    if (keyCode == 'W' || keyCode == 'w') {
      player1Up = true;
    } else if (keyCode == 'S' || keyCode == 's') {
      player1Down = true;
    } else if (keyCode == 'I' || keyCode == 'i') {
      player2Up = true;
    } else if (keyCode == 'K' || keyCode == 'k') {
      player2Down = true;
    }
  }
   if (gameState == 2) {
    
    if (keyCode == 32) {
      player1Score = 0;
      player2Score = 0;
      gameState = 0;
    }
  }
   if (gameState == 3) {    
    if (keyCode == UP) {
      menuSelection--;
      if (menuSelection < 0) {
        menuSelection = 1;
      }
    } else if (keyCode == DOWN) {
      menuSelection++;
      if (menuSelection > 1) {
        menuSelection = 0;
      }
    } else if (keyCode == ENTER) {
      gameState = 0;
      background = backgroundSprites[menuSelection];
      background.resize(800,450);
    } else if (keyCode == 32) { //Espaço
      gameState = 0;
    }
  }
  if (gameState == 4) {    
    if (keyCode == UP) {
      menuSelection--;
      if (menuSelection < 0) {
        menuSelection = 2;
      }
    } else if (keyCode == DOWN) {
      menuSelection++;
      if (menuSelection > 2) {
        menuSelection = 0;
      }
    } else if (keyCode == ENTER) {
      gameState = 0;
      ball = ballSprites[menuSelection];
      ball.resize(30,30);
    } else if (keyCode == 32) { //Espaço
      gameState = 0;
    }
  }
  if (gameState == 5) {    
    if (keyCode == 32) { //Espaço
      gameState = 0;
    }
  }
  if (gameState == 6) {    
    if (keyCode == 'W' || keyCode == 'w') {
      menuSelection--;
      if (menuSelection < 0) {
        menuSelection = 2;
      }
    } else if (keyCode == 'S' || keyCode == 's') {
      menuSelection++;
      if (menuSelection > 2) {
        menuSelection = 0;
      }
    } else if (keyCode == 'I' || keyCode == 'i') {
      menuSelection2--;
      if (menuSelection2 < 0) {
        menuSelection2 = 2;
      }
    } else if (keyCode == 'K' || keyCode == 'k') {
      menuSelection2++;
      if (menuSelection2 > 2) {
        menuSelection2 = 0;
      }
    } else if (keyCode == ENTER) {
      gameState = 0;
      player1Sprite = menuSelection;
      player2Sprite = menuSelection2;
      player1 = playerSprites[player1Sprite];
      player2 = playerSprites[player2Sprite];
            
      player1.resize(12,109);
      player2.resize(12,109);
    } else if (keyCode == 32) { //Espaço
      gameState = 0;
    }
  }
}

void keyReleased() {
  if (gameState == 1) {
    if (keyCode == 'W' || keyCode == 'w') {
      player1Up = false;
    } else if (keyCode == 'S' || keyCode == 's') {
      player1Down = false;
    } else if (keyCode == 'I' || keyCode == 'i') {
      player2Up = false;
    } else if (keyCode == 'K' || keyCode == 'k') {
      player2Down = false;
    }
  }
}
