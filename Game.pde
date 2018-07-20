final int GAME_INIT = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

void resetGame() {
    player_1 = new Player(LEFT_PLAYER);
    player_2 = new Player(RIGHT_PLAYER);

    winner = NO_PLAYER;
    game_state = GAME_RUN;
    game_paused = false;
    timer.reset();
}

void runGame() {
    player_1.move();
    player_2.move();
    player_1.moveBullet();
    player_2.moveBullet();
    player_1.checkBullet();
    player_2.checkBullet();
    player_1.checkTower();
    player_2.checkTower();
}
