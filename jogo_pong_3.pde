import processing.sound.*;

SoundFile bounceSound, pointSound;

int gameState = 0;
int menuSelection = 0;
int settingsSelection = 0;
int player1Sprite = 0;
int player2Sprite = 0;
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

void setup() {
  size(800, 400);
  frameRate(60);
  smooth();

  playerSprites[0] = loadImage("BarraTeste.png");
  playerSprites[1] = loadImage("BarraTeste2.png");
  playerSprites[2] = loadImage("BarraTeste3.png");

  ballSprites[0] = loadImage("BolaTeste.png");
  ballSprites[1] = loadImage("BolaTeste2.png");
  ballSprites[2] = loadImage("BolaTeste3.png");

  backgroundSprites[0] = loadImage("windowsxp.jpg");
  backgroundSprites[1] = loadImage("clima.jpg");
  backgroundSprites[2] = loadImage("tempestade.jpg");

  player1 = playerSprites[player1Sprite];
  player2 = playerSprites[player2Sprite];
  ball = ballSprites[ballSprite];
  background = backgroundSprites[backgroundSprite];

  bounceSound = new SoundFile(this, "bounce.wav");
  pointSound = new SoundFile(this, "ponto.wav");
  
  ball.resize(30,30);
}

void draw() {
  background(0);

  if (gameState == 0) {
    drawMenu();
  } else 
  if (gameState == 1) {
    drawGame();
  } else
  if (gameState == 3) {
    drawSettings();
  }
}

void drawMenu() {
  background(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG MENU", width/2, 50);

  textSize(25);
  fill(255);
  text("Jogar (ENTER)", width/2, height-120);
  text("Configurações (M)", width/2, height-80);
  text("Sair do Jogo (ESC)", width/2, height-40);
}

void drawSettings() {
  background(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(255);
  text("PONG SETTINGS", width/2, 50);

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
    ballSpeedY *= -1;
    bounceSound.play();
  }

  // Ball collision with paddles
  if (ballX - ballRadius < player1.width && ballY > player1Y && ballY < player1Y + player1.height) {
    if (ballSpeedX < 0) {
      ballSpeedX *= -1;
      bounceSound.play();
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
    resetBall();
    pointSound.play();
  }

  if (ballX + ballRadius > width) {
    player1Score++;
    resetBall();
    pointSound.play();
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
    if(keyCode == ENTER){
      gameState = 1;
      player1Y = height/2 - player1.height/2;
      player2Y = height/2 - player2.height/2;
    } else
    if (keyCode == 77) {
      gameState = 3;
      drawSettings();
    }
    
    //if (keyCode == UP) {
    //  menuSelection--;
    //  if (menuSelection < 0) {
    //    menuSelection = 2;
    //  }
    //} else if (keyCode == DOWN) {
    //  menuSelection++;
    //  if (menuSelection > 2) {
    //    menuSelection = 0;
    //  }
    //} else if (keyCode == ENTER) {
    //  gameState = 1;
    //  background = backgroundSprites[menuSelection];
    //  //resetBall();
    //  player1Y = height/2 - player1.height/2;
    //  player2Y = height/2 - player2.height/2;
    //} else if (keyCode == 32) {
    //  gameState = 3;
    //  settingsSelection = 0;
    //} else if (keyCode == ESC) {
    //  exit();
    //}
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
  if (gameState == 3) {
    
    if (keyCode == UP) {
      settingsSelection--;
      if (settingsSelection < 0) {
        settingsSelection = 3;
      }
    } else if (keyCode == DOWN) {
      settingsSelection++;
      if (settingsSelection > 3) {
        settingsSelection = 0;
      }
    } else if (keyCode == LEFT) {
      if (settingsSelection == 0) {
        player1Sprite--;
        if (player1Sprite < 0) {
          player1Sprite = 2;
        }
        player1 = playerSprites[player1Sprite];
      } else if (settingsSelection == 1) {
        player2Sprite--;
        if (player2Sprite < 0) {
          player2Sprite = 2;
        }
        player2 = playerSprites[player2Sprite];
      } else if (settingsSelection == 2) {
        ballSprite--;
        if (ballSprite < 0) {
          ballSprite = 2;
        }
        ball = ballSprites[ballSprite];
      } else if (settingsSelection == 3) {
        backgroundSprite--;
        if (backgroundSprite < 0) {
          backgroundSprite = 2;
        }
      }
    } else if (keyCode == RIGHT) {
      if (settingsSelection == 0) {
        player1Sprite++;
        if (player1Sprite > 2) {
          player1Sprite = 0;
        }
        player1 = playerSprites[player1Sprite];
      } else if (settingsSelection == 1) {
        player2Sprite++;
        if (player2Sprite > 2) {
          player2Sprite = 0;
        }
        player2 = playerSprites[player2Sprite];
      } else if (settingsSelection == 2) {
        ballSprite++;
        if (ballSprite > 2) {
          ballSprite = 0;
        }
        ball = ballSprites[ballSprite];
      } else if (settingsSelection == 3) {
        backgroundSprite++;
        if (backgroundSprite > 2) {
          backgroundSprite = 0;
        }
        background = backgroundSprites[backgroundSprite];
      }
    } else if (keyCode == 53) {
      player1 = playerSprites[player1Sprite];
      player2 = playerSprites[player2Sprite];
      ball = ballSprites[ballSprite];
      background = backgroundSprites[backgroundSprite];
      gameState = 0;
    } else 
    if (keyCode == 32) {
      gameState = 0;
      drawMenu();
    }
  } else 
  if (gameState == 2) {
    
    if (keyCode == ENTER) {
      player1Score = 0;
      player2Score = 0;
      resetBall();
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
