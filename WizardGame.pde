int gameScreen = 0;

ObjectHandler objectHandler;

InputHandler inputHandler;

Camera camera;

static final int TILE_SIZE = 32;

void setup() {
  size(640, 480, P2D);
  sketchPath("./");
  camera = new Camera(0, 0, TILE_SIZE, width, height);
  inputHandler = new InputHandler();
  objectHandler = new ObjectHandler(inputHandler);
  PImage mapImg = loadImage("level1map.png");
  mapImg.loadPixels();
  loadMap(mapImg.pixels, mapImg.width, mapImg.height, TILE_SIZE, TILE_SIZE, objectHandler);
}

void draw() {
  if (gameScreen == 0) {
    initScreen();
  }
  if (gameScreen == 1) {
    gameScreen();
  }
  if (gameScreen == 2) {
    gameOverScreen();
  }
}

void initScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", height / 2, width / 2);
}

void gameScreen() {
  background(255);
  objectHandler.update();
  camera.update(objectHandler.player);
  translate(-camera.x, -camera.y);
  objectHandler.draw();
  translate(camera.x, camera.y);
}

void gameOverScreen() {
  background(255);
}

public void mousePressed(MouseEvent event) {
  if (gameScreen == 0) {
    startGame();
  } else {
    int mouseX = (int) (event.getX() + camera.x);
    int mouseY = (int) (event.getY() + camera.y);
    Entity player = objectHandler.player;
    int bulletXPos = (player.x + player.w) / TILE_SIZE;
    int bulletYPos = (player.y + player.h) / TILE_SIZE;
    objectHandler.addBullet(bulletXPos, bulletYPos, TILE_SIZE, TILE_SIZE, mouseX, mouseY);
  }
}

void startGame() {
  gameScreen = 1;
}

void keyPressed() {
  inputHandler.keyPressed(keyCode, key);
}

void keyReleased() {
  inputHandler.keyReleased(keyCode, key);
}
