import 'package:flutter/material.dart';
import 'package:tic_tac_toe/box.dart';

class Play extends StatefulWidget {
  Play({Key key}) : super(key: key);

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  List<Box> arr = [
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
    Box(isDisable: false, value: ''),
  ];
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
            children: List.generate(arr.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    arr[index].isDisable = true;
                    index % 2 == 0
                        ? arr[index].value = 'X'
                        : arr[index].value = 'O';
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color:
                        arr[index].isDisable ? Colors.redAccent : Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(arr[index].value),
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
