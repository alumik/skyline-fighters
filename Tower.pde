color[] tower_color = new color[21];

void initTowerColor() {
    for (int i = 0; i < MAX_TOWER_HEALTH + 1; i++) {
        tower_color[i] = color(255,
            i * 255 / MAX_TOWER_HEALTH,
            i * 255 / MAX_TOWER_HEALTH);
    }
}

class Tower {
    private int m_health;
    private PVector m_position;

    Tower(PVector position) {
        m_position = position;
        m_health = MAX_TOWER_HEALTH;
    }

    int getTop() {
        return (int)m_position.y;
    }

    int getBottom() {
        return (int)m_position.y + 50;
    }

    void removeHealth() {
        m_health--;
    }

    boolean destroyed() {
        return m_health < 1;
    }

    void show() {
        noStroke();
        fill(tower_color[m_health]);
        arc(m_position.x, m_position.y, 90, 100, 0.5 * PI - 0.6, 0.5 * PI + 0.6);
        fill(0, 0, 0, 100);
        ellipse(m_position.x, m_position.y + 65, 50, 10);
    }
}
