class Player extends Entity {
  final InputHandler inputHandler;

  float speed = 2.5;

  int ammo = 100;

  int health = 100;

  Player(float x, float y, int w, int h, ObjectHandler objectHandler, InputHandler inputHandler, Sprites sprites) {
    super(x, y, w, h, ObjectID.PLAYER, objectHandler, sprites);
    this.inputHandler = inputHandler;
  }

  void update() {    
    tryAdvance();

    if (inputHandler.up) yVel = -speed;
    else if (!inputHandler.down) yVel = 0;

    if (inputHandler.down) yVel = speed;
    else if (!inputHandler.up) yVel = 0;

    if (inputHandler.right) xVel = speed;
    else if (!inputHandler.left) xVel = 0;

    if (inputHandler.left) xVel = -speed;
    else if (!inputHandler.right) xVel = 0;
  }

  void draw() {
    image(sprites.getPlayer(), x, y);
  }

  void onCollision(Entity crate) {
    if (crate.objectId == ObjectID.CRATE) {
      ammo += ((Crate) crate).ammo;
      objectHandler.removeEntity(crate);
    }
    if (crate.objectId == ObjectID.POTION) {
      health += ((Potion) crate).health;
      objectHandler.removeEntity(crate);
    }
  }

  void hit() {
    health -= 1;
  }

  void fire(float mouseX, float mouseY) {
    if (ammo > 0) {
      float bulletXPosition = x + w / 2;
      float bulletYPosition = y + h / 2;
      float targetXPosition = mouseX;
      float targetYPosition = mouseY;
      objectHandler.addBullet(bulletXPosition, bulletYPosition, 8, 8, targetXPosition, targetYPosition);
      ammo--;
    }
  }
}
