import 'package:flutter/material.dart';
import 'package:tic_tac_toe/move.dart';

class Play extends StatefulWidget {
  Play({Key key}) : super(key: key);

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  List<bool> disables = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<dynamic> values = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  int count = 0;
  String hPlayer = 'X';
  String cPlayer = 'O';

  emptyIndex(arr) {
    return arr.where((i) => i != this.hPlayer && i != this.cPlayer).toList();
  }

  isWin(values, player) {
    if ((values[0] == player && values[1] == player && values[2] == player) ||
        (values[3] == player && values[4] == player && values[5] == player) ||
        (values[6] == player && values[7] == player && values[8] == player) ||
        (values[0] == player && values[3] == player && values[6] == player) ||
        (values[1] == player && values[4] == player && values[7] == player) ||
        (values[2] == player && values[5] == player && values[8] == player) ||
        (values[0] == player && values[4] == player && values[8] == player) ||
        (values[2] == player && values[4] == player && values[6] == player)) {
      return true;
    }
    return false;
  }

  minimax(newBoard, player) {
    List<dynamic> availableSpots = emptyIndex(newBoard);

    if (isWin(newBoard, hPlayer)) {
      return new Move(score: -10);
    } else if (isWin(newBoard, cPlayer)) {
      return new Move(score: 10);
    } else if (availableSpots.length == 0) {
      return new Move(score: 0);
    }

    List<Move> moves = [];

    for (int i = 0; i < availableSpots.length; i++) {
      Move move = new Move();
      move.index = newBoard[availableSpots[i]];
      newBoard[availableSpots[i]] = player;

      if (player == cPlayer) {
        move.score = minimax(newBoard, hPlayer).score;
        // move.score = result;
      } else {
        move.score = minimax(newBoard, cPlayer).score;
        // move.score = result;
      }

      newBoard[availableSpots[i]] = move.index;

      moves.add(move);
      int bestMove;
      if (player == cPlayer) {
        dynamic bestScore = -10000;
        for (int i = 0; i < moves.length; i++) {
          if (moves[i].score > bestScore) {
            bestScore = moves[i].score;
            bestMove = i;
          }
        }
      } else {
        dynamic bestScore = 10000;
        for (int i = 0; i < moves.length; i++) {
          if (moves[i].score < bestScore) {
            bestScore = moves[i].score;
            bestMove = i;
          }
        }
      }
      return moves[bestMove];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 130.0),
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(values.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    Move i = minimax(this.values, cPlayer);
                    this.disables[index] = true;
                    this.values[index] = 'X';
                    this.values[i.index] = 'O';
                    this.disables[i.index] = true;
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: disables[index] ? Colors.blueGrey : Colors.grey,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(values[index] is String ? values[index] : '',
                        style: TextStyle(
                            fontSize: 40,
                            color: values[index] == 'X'
                                ? Colors.lime
                                : Colors.white)),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
