import java.util.LinkedList;
import java.util.Iterator;

final float PLAYER_SPEED = 3.5;
final float BULLET_SPEED = 4;
final int MAX_BULLET = 10;
final int MAX_TOWER_HEALTH = 20;

int winner;
int game_state;
boolean game_paused;

Player player_1, player_2;
Timer timer;

void setup() {
    size(1200, 600);
    textFont(createFont("simkai.ttf", 25));
    textAlign(CENTER, TOP);

    game_state = GAME_INIT;
    initTowerColor();
    timer = new Timer();
}

void draw() {
    drawCommonBackground();

    switch(game_state) {
        case GAME_INIT:
            drawGameInitScreen();
            break;
        case GAME_OVER:
            drawGameOverScreen();
            break;
        case GAME_RUN:
            drawGameRunScreen();
            break;
    }
}

void keyPressed() {
    if (key == ESC) {
        System.exit(0);
    }

    switch(game_state) {
        case GAME_INIT:
            resetGame();
            timer.start();
            break;
        case GAME_OVER:
            if (key == ENTER) {
                resetGame();
                timer.start();
            }
            break;
        case GAME_RUN:
            if (game_paused) {
                if (key == ENTER) {
                    game_paused = false;
                    timer.start();
                }
            } else {
                switch(key) {
                    case ENTER:
                        game_paused = true;
                        timer.pause();
                        break;
                    case 'w':
                        player_1.setDirection(MOVE_UP);
                        break;
                    case 'd':
                        player_1.setDirection(MOVE_RIGHT);
                        break;
                    case 's':
                        player_1.setDirection(MOVE_DOWN);
                        break;
                    case 'a':
                        player_1.setDirection(MOVE_LEFT);
                        break;
                    case 'c':
                        player_1.shoot();
                        break;
                    case 'i':
                        player_2.setDirection(MOVE_UP);
                        break;
                    case 'l':
                        player_2.setDirection(MOVE_RIGHT);
                        break;
                    case 'k':
                        player_2.setDirection(MOVE_DOWN);
                        break;
                    case 'j':
                        player_2.setDirection(MOVE_LEFT);
                        break;
                    case '.':
                        player_2.shoot();
                        break;
                }
            }
            break;
    }
}
