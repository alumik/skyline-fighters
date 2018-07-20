final color BACKGROUND_COLOR = color(32, 16, 48);
final color TEXT_ACCENT_COLOR = color(85, 255, 255);
final color LEFT_PLAYER_COLOR = color(255, 0, 0);
final color RIGHT_PLAYER_COLOR = color(0, 255, 0);
final color LEFT_PLAYER_COLOR_ALPHA = color(255, 0, 0, 50);
final color RIGHT_PLAYER_COLOR_ALPHA = color(0, 255, 0, 50);
final int TEXT_S1 = 80;
final int TEXT_S2 = 60;
final int TEXT_S3 = 25;

void drawCommonBackground() {
    background(BACKGROUND_COLOR);

    stroke(255);
    strokeWeight(3);
    noFill();
    rect(8, 8, width - 17, height - 17);

    fill(255);
    textSize(TEXT_S3);
	text("ESC 退出", width / 2, 480);
}

void drawScore() {
    fill(255);
    textSize(TEXT_S3);
    text("一号玩家 " + player_1.getScore() + " 分", width / 2, 100);
    text("二号玩家 " + player_2.getScore() + " 分", width / 2, 150);
}

void drawGamePauseScreen() {
    fill(TEXT_ACCENT_COLOR);
    textSize(TEXT_S1);
    text("游戏暂停", width / 2, 250);
}

void drawGameInitScreen() {
    fill(255);
    textSize(TEXT_S1);
    text("天际战机", width / 2, 80);

    fill(TEXT_ACCENT_COLOR);
    textSize(TEXT_S2);
    text("按任意键开始游戏", width / 2, 250);
}

void drawGameOverScreen() {
    drawScore();

    fill(TEXT_ACCENT_COLOR);
    textSize(TEXT_S2);
    textAlign(CENTER, CENTER);
    text((winner == LEFT_PLAYER ? "一号玩家" : "二号玩家") + "胜出\n按回车键重新开始",
         width / 2,
         height / 2);
    textAlign(CENTER, TOP);
}

void drawGameRunScreen() {
    drawScore();

    stroke(255);
    strokeWeight(1);
    line(width / 2 - 110, 10, width / 2 - 110, height - 11);
    line(width / 2 + 110, 10, width / 2 + 110, height - 11);

    fill(255);
    textSize(TEXT_S3);
    text("WASD/IJKL 移动", width / 2, 380);
    text("C/. 射击", width / 2, 430);
    text("ENTER 暂停", width / 2, 530);

    fill(player_1.getPlayerColor());
    textSize(TEXT_S3);
    text("弹药", 200, 20);

    noStroke();
    for (int i = 0; i < MAX_BULLET - player_1.getBulletCount(); i++) {
        rect(250 + 15 * i, 22, 5, 25);
    }

    fill(player_2.getPlayerColor());
    textSize(TEXT_S3);
    text("弹药", 840, 20);

    noStroke();
    for (int i = 0; i < MAX_BULLET - player_2.getBulletCount(); i++) {
        rect(890 + 15 * i, 22, 5, 25);
    }

    if (!game_paused) {
        runGame();
    } else {
        drawGamePauseScreen();
    }

    player_1.showTower();
    player_2.showTower();
    player_1.showBullet();
    player_2.showBullet();
    player_1.show();
    player_2.show();
}
