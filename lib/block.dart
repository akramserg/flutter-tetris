import 'dart:html';

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
    for (int shapeX = 0; shapeX < shape[0].length; shapeX++) {
      for (int shapeY = shape.length - 1; shapeY >= 0; shapeY--) {
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
    if (canvasY < 0) return false;
    if (canvasX <= 0) return false;

    if (shape[0][0] == 1 && canvas[canvasY][canvasX - 1] == 1) return false;
    if (shape.length > 1 &&
        [1][0] == 1 &&
        canvas[canvasY + 1][canvasX - 1] == 1) return false;
    if (shape.length > 2 &&
        shape[2][0] == 1 &&
        canvas[canvasY + 2][canvasX - 1] == 1) return false;
    if (shape.length > 3 &&
        shape[3][0] == 1 &&
        canvas[canvasY + 3][canvasX - 1] == 1) return false;
    this.canvasX--;
    return true;
  }

  bool moveRight(canvas) {
    print("right");
    var sw = shape[0].length;
    var sh = shape.length;
    if (canvasY < 0) return false;
    if (canvasX + sw >= canvas[0].length) return false;

    print(shape.length);
    print(shape[0].length);

    if (shape[0][sw - 1] == 1 && canvas[canvasY][canvasX + sw] == 1)
      return false;
    if (sh > 1 &&
        shape[1][sw - 1] == 1 &&
        canvas[canvasY + 1][canvasX + sw] == 1) return false;
    if (sh > 2 &&
        shape[2][sw - 1] == 1 &&
        canvas[canvasY + 2][canvasX + sw] == 1) return false;
    if (sh > 3 &&
        shape[3][sw - 1] == 1 &&
        canvas[canvasY + 3][canvasX + sw] == 1) return false;
    this.canvasX++;
    return true;
  }

  bool rotateLeft(canvas) {
    var tempShape = rotate2DarrayLeft(shape);
    print(tempShape);
    var centerLocationX = (this.canvasX + shape[0].length / 2).round();
    var centerLocationY = (this.canvasY + shape.length / 2).toInt();
    var tempCanvasX = (centerLocationX - tempShape.length / 2).toInt();
    var tempCanvasY = (centerLocationY - tempShape[0].length / 2).toInt();

    if (tempCanvasX + tempShape[0].length >= canvas[0].length) return false;
    if (tempCanvasY + tempShape.length >= canvas.length) return false;

    this.shape = tempShape;
    this.canvasX = tempCanvasX;
    this.canvasY = tempCanvasY;
    return true;
  }


 bool rotateRight(canvas) {
    var tempShape = rotate2DarrayRight(shape);
    print(tempShape);
    var centerLocationX = (this.canvasX + shape[0].length / 2).round();
    var centerLocationY = (this.canvasY + shape.length / 2).toInt();
    var tempCanvasX = (centerLocationX - tempShape.length / 2).toInt();
    var tempCanvasY = (centerLocationY - tempShape[0].length / 2).toInt();

    if (tempCanvasX + tempShape[0].length >= canvas[0].length) return false;
    if (tempCanvasY + tempShape.length >= canvas.length) return false;

    this.shape = tempShape;
    this.canvasX = tempCanvasX;
    this.canvasY = tempCanvasY;
    return true;
  }


  List<List<int>> rotate2DarrayLeft(List<List<int>> array) {
    List<List<int>> newArray = List.generate(
        array[0].length, (index) => List.generate(array.length, (index) => 0));
    int i = 0;

    for (int x = array[0].length - 1; x >= 0; x--) {
      int j = 0;
      var s = "";
      for (int y = 0; y < array.length; y++) {
        s += array[y][x].toString();
        newArray[i][j] = array[y][x];
        j++;
      }
      print(s);
      i++;
    }
    return newArray;
  }


  List<List<int>> rotate2DarrayRight(List<List<int>> array) {
    List<List<int>> newArray = List.generate(
        array[0].length, (index) => List.generate(array.length, (index) => 0));
    int i = 0;

    for (int x = 0; x < array[0].length; x++) {
      int j = 0;
      var s = "";
      for (int y = array.length-1; y >= 0; y--) {
        s += array[y][x].toString();
        newArray[i][j] = array[y][x];
        j++;
      }
      print(s);
      i++;
    }
    return newArray;
  }


}
