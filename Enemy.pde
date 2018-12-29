import java.util.Random;

class Enemy extends Entity {
  Random random = new Random();

  int health = 100;

  Enemy(float x, float y, int w, int h, ObjectHandler objectHandler, Sprites sprites) {
    super(x, y, w, h, ObjectID.ENEMY, objectHandler, sprites);
  }

  void update() {
    tryAdvance();

    int choose = random.nextInt(10);
    if (choose == 0) {
      xVel = (random.nextInt(8) - 4);
      yVel = (random.nextInt(8) - 4);
    }
  }

  void draw() {
    image(sprites.getEnemy(), x, y);
  }

  void hit() {
    health -= 50;
    if (health <= 0) {
      objectHandler.removeEnemy(this);
    }
  }

  void onCollision(Entity crate) {
  }
}
