final PVector MOVE_STOP = new PVector(0, 0);
final PVector MOVE_UP = new PVector(0, -1);
final PVector MOVE_RIGHT = new PVector(1, 0);
final PVector MOVE_DOWN = new PVector(0, 1);
final PVector MOVE_LEFT = new PVector(-1, 0);

final int NO_PLAYER = 0;
final int LEFT_PLAYER = -1;
final int RIGHT_PLAYER = 1;

class Player {
    private PVector m_direction;
    private PVector m_position;
    private int m_player_type;
    private color[] m_player_color_set;
    private int m_score;
    private int m_hit;
    private float m_shield_radius;
    private LinkedList<Bullet> m_bullets;
    private Tower[] m_towers;
    private int[] m_tower_position_y;

    Player(int player_type) {
        m_player_type = player_type;

        m_player_color_set = new color[2];
        m_player_color_set[0] = m_player_type == LEFT_PLAYER ? LEFT_PLAYER_COLOR : RIGHT_PLAYER_COLOR;
        m_player_color_set[1] = m_player_type == LEFT_PLAYER ? LEFT_PLAYER_COLOR_ALPHA : RIGHT_PLAYER_COLOR_ALPHA;

        m_score = 0;
        m_hit = 0;
        m_direction = MOVE_STOP;
        m_position = new PVector(width / 2 + m_player_type * 400, height / 2);
        m_bullets = new LinkedList<Bullet>();
        m_shield_radius = 70;

        m_towers = new Tower[6];
        for (int i = 0; i < m_towers.length; i++) {
            m_towers[i] = new Tower(new PVector(
                width / 2 + m_player_type * 545,
                80 * i + 60));
        }
        m_tower_position_y = new int[12];
        for (int i = 0; i < m_towers.length; i++) {
            m_tower_position_y[i * 2] = m_towers[i].getTop();
            m_tower_position_y[i * 2 + 1] = m_towers[i].getBottom();
        }
    }

    void setDirection(PVector direction) {
        m_direction = direction;
    }

    int getScore() {
        return m_score;
    }

    PVector getPosition() {
        return m_position.copy();
    }

    float getShieldRadius() {
        return m_shield_radius;
    }

    int[] getTowerPositionY() {
        return m_tower_position_y;
    }

    color getPlayerColor() {
        return m_player_color_set[0];
    }

    int getBulletCount() {
        return m_bullets.size();
    }

    void addHit() {
        m_hit++;
    }

    void addScore() {
        m_score++;
    }

    void move() {
        m_position.add(PVector.mult(m_direction, PLAYER_SPEED));
        if (m_player_type == LEFT_PLAYER) {
            m_position.x = constrain(
                m_position.x,
                width / 2 - 430,
                width / 2 - 137
            );
        } else {
            m_position.x = constrain(
                m_position.x,
                width / 2 + 137,
                width / 2 + 430
            );
        }
        m_position.y = constrain(m_position.y, 56, height - 57);
    }

    void shoot() {
        if (m_bullets.size() < MAX_BULLET) {
            m_bullets.add(new Bullet(m_player_type,
                m_player_color_set[0],
                m_position.copy()));
        }
    }

    void moveBullet() {
        for (Bullet bullet : m_bullets) {
            bullet.move();
        }
    }

    void checkBullet() {
        Iterator<Bullet> iterator = m_bullets.iterator();
        while(iterator.hasNext()) {
            Bullet bullet = iterator.next();
            if(bullet.out() || bullet.hit_tower() || bullet.hit_player()) {
                iterator.remove();
            }
        }
    }

    void checkTower() {
        for (Tower tower : m_towers) {
            if (tower.destroyed()) {
                game_state = GAME_OVER;
                timer.pause();
                winner = m_player_type * -1;
            }
        }
    }

    void hitTower(int index) {
        m_towers[index].removeHealth();
        if (m_towers[index].getHealth() < 10) {
            m_shield_radius = 90;
        }
    }

    void showBullet() {
        for (Bullet bullet : m_bullets) {
            bullet.show();
        }
    }

    void showTower() {
        for (Tower tower : m_towers) {
            tower.show();
        }
    }

    void show() {
        fill(m_player_color_set[1]);
        stroke(m_player_color_set[0]);
        strokeWeight(2);
        ellipse(m_position.x + m_player_type * 20,
            m_position.y,
            m_shield_radius,
            m_shield_radius);

        fill(m_player_color_set[0]);
        noStroke();
        beginShape();
        vertex(m_position.x, m_position.y);
        vertex(m_position.x + m_player_type * 30, m_position.y - 30);
        vertex(m_position.x + m_player_type * 22, m_position.y - 10);
        vertex(m_position.x + m_player_type * 30, m_position.y);
        vertex(m_position.x + m_player_type * 22, m_position.y + 10);
        vertex(m_position.x + m_player_type * 30, m_position.y + 30);
        endShape(CLOSE);
    }
}
