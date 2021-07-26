import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'tetrisManager.dart';
import 'package:tetris_flutter/tetrisManager.dart';

void main() {
  runApp(MyApp());
}

TetrisManager tetrisManager = TetrisManager(300, 500, 30);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TetrisPainter? _tetrisPainter;
  final _repaint = ValueNotifier<int>(0);

  @override
  void initState() {
    _tetrisPainter = TetrisPainter(repaint: _repaint);
    tetrisManager.tick();
    Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      _repaint.value++;
      if (tetrisManager.play) tetrisManager.tick();
      // print(_repaint.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 20),
        primary: Color(0xFF444444));

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tetris'),
        backgroundColor: Color(0xFF444444),
      ),
      body: ListView(children: <Widget>[
        Text(
          'TETRIS',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, height: 2),
        ),
        Container(
            width: tetrisManager.screenWidth.toDouble(),
            height: tetrisManager.screenHeight.toDouble(),
                              margin: EdgeInsets.only(left: 100.0),

            child: Column(children: [
              Center(
                  child: Row(
                    
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    CustomPaint(
                      painter: _tetrisPainter,
                    ),
                  ]))
            ])),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        tetrisManager.moveLeft();
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: Colors.green,
                              size: 40,
                            ), // icon
                          ],
                        ),
                      ))),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        tetrisManager.moveRight();
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: Colors.green,
                              size: 40,
                            ), // icon
                          ],
                        ),
                      ))),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        tetrisManager.rotateLeft();
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.rotate_left,
                              color: Colors.green,
                              size: 40,
                            ), // icon
                          ],
                        ),
                      ))),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        tetrisManager.rotateRight();
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.rotate_right,
                              color: Colors.green,
                              size: 40,
                            ), // icon
                          ],
                        ),
                      ))),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        tetrisManager.restart();
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.restart_alt,
                              color: Colors.green,
                              size: 40,
                            ), // icon
                          ],
                        ),
                      ))),
            ],
          ),
        )
      ]),
    );
  }
}

class TetrisPainter extends CustomPainter {
  TetrisPainter({Listenable? repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    var paintWhite = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.fill;

    var bSize = tetrisManager.boxSize.toDouble();
    for (int y = 0; y < tetrisManager.canvas.length; y++) {
      for (int x = 0; x < tetrisManager.canvas[y].length; x++) {
        if (tetrisManager.canvas[y][x] == 0) {
          canvas.drawRect(Offset(x * bSize, y * bSize) & Size(bSize, bSize),
              tetrisManager.paint);
          canvas.drawRect(
              Offset(x * bSize + 1, y * bSize + 1) & Size(bSize - 2, bSize - 2),
              paintWhite);
        } else {
          canvas.drawRect(
              Offset(x * bSize, y * bSize) & Size(bSize, bSize), paintWhite);
          canvas.drawRect(
              Offset(x * bSize + 1, y * bSize + 1) & Size(bSize - 2, bSize - 2),
              tetrisManager.paint);
        }
        // print(i.toString()+":"+j.toString());

      }
    }
    if (tetrisManager.currnetBlock != null) {
      var cBlock = tetrisManager.currnetBlock!;
      for (int i = 0; i < cBlock.shape[0].length; i++) {
        for (int j = 0; j < cBlock.shape.length; j++) {
          if (cBlock.shape[j][i] == 1) {
            canvas.drawRect(
                Offset((cBlock.canvasX + i) * bSize,
                        (cBlock.canvasY + j) * bSize) &
                    Size(bSize, bSize),
                paintWhite);
            canvas.drawRect(
                Offset((cBlock.canvasX + i) * bSize + 1,
                        (cBlock.canvasY + j) * bSize + 1) &
                    Size(bSize - 2, bSize - 2),
                cBlock.paint);
          }
          // print(i.toString()+":"+j.toString());

        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
