class Bullet {
    private int m_player_type;
    private color m_player_color;
    private float radius = 10;
    private PVector m_position;

    Bullet(int player_type, color player_color, PVector position) {
        m_player_type = player_type;
        m_player_color = player_color;
        m_position = position;
    }

    void move() {
        m_position.add(new PVector(BULLET_SPEED * -m_player_type, 0));
    }

    boolean hit_tower() {
        if (m_player_type == LEFT_PLAYER) {
            if (m_position.x > width / 2 + 495) {
                for (int i = 0; i < 6; i++) {
                    if (m_position.y > player_2.getTowerPositionY()[i * 2]
                        && m_position.y < player_2.getTowerPositionY()[i * 2 + 1]) {
                        player_2.hitTower(i);
                        player_1.addScore();
                        return true;
                    }
                }
            }
            return false;
        }
        if (m_position.x < width / 2 - 495) {
            for (int i = 0; i < 6; i++) {
                if (m_position.y > player_1.getTowerPositionY()[i * 2]
                    && m_position.y < player_1.getTowerPositionY()[i * 2 + 1]) {
                    player_1.hitTower(i);
                    player_2.addScore();
                    return true;
                }
            }
        }
        return false;
    }

    boolean hit_player() {
        if (m_player_type == LEFT_PLAYER) {
            if (PVector.dist(player_2.getPosition().add(new PVector(20, 0)), m_position) < player_2.getShieldRadius() / 2) {
                player_2.addHit();
                return true;
            }
            return false;
        }
        if (PVector.dist(player_1.getPosition().add(new PVector(-20, 0)), m_position) < player_1.getShieldRadius() / 2) {
            player_1.addHit();
            return true;
        }
        return false;
    }

    boolean out() {
        return (m_position.x > width || m_position.x < 0);
    }

    void show() {
        fill(m_player_color);
        noStroke();
        ellipse(m_position.x, m_position.y, radius, radius);
    }
}
