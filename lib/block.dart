import 'package:flutter/material.dart';

class Block {
  var shape, color;
  int canvasX = 0;
  int canvasY = 0;
  Paint paint = new Paint();

  Block(int canvasX, int canvasY, shape, color) {
    this.shape = shape;
    this.color = color;
    this.paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    this.canvasX = canvasX;
    this.canvasY = canvasY;
  }

  bool moveDown(canvas) {
    // print(canvasY);
    // print(canvas[0].length);
    for (int shapeX = 0; shapeX < 4; shapeX++) {
      for (int shapeY = 3; shapeY >= 0; shapeY--) {
        var cX = canvasX + shapeX;
        var cY = canvasY + shapeY + 1;

        if (cY >= canvas.length) {
          return false;
        }
        if (cY >= 0 && shape[shapeY][shapeX] != 0 && canvas[cY][cX] != 0) {
          return false;
        }
      }
    }
    this.canvasY++;
    return true;
  }

  bool moveLeft(canvas) {
    print("left");
    print(canvasX);
    if (canvasY < 0) return false;
    if (canvasX <= 0) return false;
    if ((canvas[canvasY][canvasX - 1] != shape[0][0] ||
            canvas[canvasY][canvasX - 1] == 0) &&
        (canvas[canvasY + 1][canvasX - 1] != shape[1][0] ||
            canvas[canvasY + 1][canvasX - 1] == 0) &&
        (canvas[canvasY + 2][canvasX - 1] != shape[2][0] ||
            canvas[canvasY + 2][canvasX - 1] == 0) &&
        (canvas[canvasY + 3][canvasX - 1] != shape[3][0] ||
            canvas[canvasY + 3][canvasX - 1] == 0)) {
      this.canvasX--;
      return true;
    }

    return false;
  }

  bool moveRight(canvas) {
    print("right");
    print(canvasX);
    if (canvasY < 0) return false;
    if (canvasX+4 >= canvas[0].length-1) return false;

    if ((canvas[canvasY][canvasX + 4] != shape[0][0] ||
            canvas[canvasY][canvasX+ 4] == 0) &&
        (canvas[canvasY + 1][canvasX+ 4] != shape[1][0] ||
            canvas[canvasY + 1][canvasX+ 4] == 0) &&
        (canvas[canvasY + 2][canvasX+ 4] != shape[2][0] ||
            canvas[canvasY + 2][canvasX+ 4] == 0) &&
        (canvas[canvasY + 3][canvasX + 4] != shape[3][0] ||
            canvas[canvasY + 3][canvasX + 4] == 0)) {
      this.canvasX++;
      return true;
    }

    return false;
  }


}
