import 'package:flutter/material.dart';
import 'dart:math';
import 'block.dart';

Random random = new Random();

class TetrisManager {
  int boxSize = 0;
  int screenWidth = 0;
  int screenHeight = 0;
  bool play = true;
  List<Block> blocks = [];
  Block? currnetBlock;
  var canvas = [];
  int canvasXCap = 0; //number of boxes a row can have
  int canvasYCap = 0; //number of boxes a column can have
  var paint = Paint()
    ..color = Color(0xff638965)
    ..style = PaintingStyle.fill;
  static final shapeList = [
    [
      [1, 1, 1, 1]
    ], //LONG

    [
      [1, 0],
      [1, 0],
      [1, 1],
    ], //L
    [
      [0, 1],
      [0, 1],
      [1, 1],
    ], //L reveser
    [
      [1, 1, 0],
      [0, 1, 1],
    ], //Z
    [
      [0, 1, 1],
      [1, 1, 0],
    ], //Z reversed
    [
      [1, 1],
      [1, 1],
    ], //BOX
    [
      [0, 1, 0],
      [1, 1, 1],
    ], //T
  ];

  static final colorList = [
    Colors.red[200], //Long
    Colors.green[200], //L
    Colors.blue[200], //L
    Colors.brown[200] ,//Z
    Colors.yellow[900], //Z
    Colors.orange, //B
    Colors.blue, //t
  ];

  int x = 0;
  int y = 0;

  TetrisManager(int screenWidth, int screenHeight, int boxSize) {
    // var i = random.nextInt(shapeList.length);
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    this.boxSize = boxSize;
    this.canvasXCap = (screenWidth ~/ boxSize).toInt();
    this.canvasYCap = (screenHeight ~/ boxSize).toInt();
    print(canvasXCap);
    print(canvasYCap);
    this.canvas = List.generate(
        canvasYCap, (i) => List.generate(canvasXCap, (j) => 0, growable: false),
        growable: false); // [column][rows]  -   [y][x]
  }

  restart() {
    this.canvas = List.generate(
        canvasYCap, (i) => List.generate(canvasXCap, (j) => 0, growable: false),
        growable: false); // [column][rows]  -   [y][x]

    this.currnetBlock = null;
  }

  tick() {
    if (this.currnetBlock == null) {
      this.currnetBlock = createRandomBlock();
      return;
    } else {
      if (this.currnetBlock?.moveDown(canvas) == false) {
        mergeAndDeleteCurrentBlock();
        check();
      }
    }
  }

  moveLeft() {
    if (this.currnetBlock != null) this.currnetBlock!.moveLeft(this.canvas);
  }

  moveRight() {
    if (this.currnetBlock != null) this.currnetBlock!.moveRight(this.canvas);
  }

  rotateLeft() {
    if (this.currnetBlock != null) this.currnetBlock!.rotateLeft(this.canvas);
  }

  rotateRight() {
    if (this.currnetBlock != null) this.currnetBlock!.rotateRight(this.canvas);
  }

  createRandomBlock() {
    var i = random.nextInt(shapeList.length);

    Block b =
        new Block((canvasXCap ~/ 2).toInt(), 0, shapeList[i], colorList[i]);
    return b;
  }

  addRandomBlock() {
    var i = random.nextInt(shapeList.length);
    Block b =
        new Block((canvasXCap ~/ 2).toInt(), 0, shapeList[i], colorList[i]);
    this.blocks.add(b);
  }

  check() {
    for (int x = 0; x < canvas[0].length; x++) {
      if (canvas[0][x] == 1) {
        this.play = false;
        print("=lost");
      }
    }

    checkCompletedRow();
  }

  checkCompletedRow() {
    var completedRows = [];
    for (int y = canvas.length - 4; y < canvas.length; y++) {
      var completeRow = true;
      for (int x = 0; x < canvas[0].length; x++) {
        if (canvas[y][x] == 0) completeRow = false;
      }
      if (completeRow) completedRows.add(y);
    }

    for (int y = canvas.length - 5; y < canvas.length; y++) {
      if (completedRows.contains(y)) {
        removeRow(y);
      }
    }
  }

  removeRow(row) {
    for (int y = row; y >= 1; y--) {
      for (int x = 0; x < canvas[0].length; x++) {
        canvas[y][x] = canvas[y - 1][x];
      }
    }

    for (int x = 0; x < canvas[0].length; x++) {
      canvas[0][x] = 0;
    }
  }

  mergeAndDeleteCurrentBlock() {
    if (this.currnetBlock == null) return;
    var b = this.currnetBlock!;
    for (int y = 0; y < b.shape.length; y++) {
      for (int x = 0; x < b.shape[y].length; x++) {
        if (b.canvasY + y >= 0)
          this.canvas[b.canvasY + y][b.canvasX + x] = b.shape[y][x] == 1
              ? b.shape[y][x]
              : this.canvas[b.canvasY + y][b.canvasX + x];
      }
    }
    this.currnetBlock = null;
  }
}
