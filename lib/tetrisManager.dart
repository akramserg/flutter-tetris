import 'package:flutter/material.dart';
import 'dart:math';
import 'block.dart';

Random random = new Random();

class TetrisManager {
  int boxSize = 0;
  int screenWidth = 0;
  int screenHeight = 0;
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
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [1, 1, 1, 1]
    ], //LONG

    [
      [0, 0, 0, 0],
      [1, 0, 0, 0],
      [1, 0, 0, 0],
      [1, 1, 0, 0],
    ], //L
  ];

  static final colorList = [
    Colors.red[200], //Long
    Colors.green[200] //L
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

  tick() {
    if (this.currnetBlock == null) {
      this.currnetBlock = createRandomBlock();
      return;
    } else {
      if (this.currnetBlock?.moveDown(canvas) == false){
        mergeAndDeleteCurrentBlock();
        checkLoss();
      }
    }
  }

moveLeft(){
  if(this.currnetBlock!=null)
  this.currnetBlock!.moveLeft(this.canvas);
}

moveRight(){
     if(this.currnetBlock!=null)
    this.currnetBlock!.moveRight(this.canvas);

}
  createRandomBlock() {
    var i = random.nextInt(shapeList.length);
    var startY = 0;
    if (i == 0){
      //long
      startY = -3;
    }
    if (i==1){
      //L
      startY = -1;
    }
    Block b =
        new Block((canvasXCap ~/ 2).toInt(), startY, shapeList[i], colorList[i]);
    return b;
  }

  addRandomBlock() {
    var i = random.nextInt(shapeList.length);
    Block b =
        new Block((canvasXCap ~/ 2).toInt(), 0, shapeList[i], colorList[i]);
    this.blocks.add(b);
  }

  checkLoss(){
    for (int x = 0; x<canvas[0].length; x++){
      if (canvas[0][x] == 1)print("=lost");
    }
  }

  mergeAndDeleteCurrentBlock() {
    var b = this.currnetBlock!;
    for (int y = 0; y < b.shape.length; y++) {
      for (int x = 0; x < b.shape[y].length; x++) {
        if (b.canvasY+y>=0)
        this.canvas[b.canvasY+y][b.canvasX + x] = b.shape[y][x];
      }
    }
    this.currnetBlock = null;
  }
}
