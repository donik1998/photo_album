import 'package:flutter/material.dart';

class MyAlbumsPageBody extends StatelessWidget {
   MyAlbumsPageBody({Key? key}) : super(key: key);
  final  List<int> numbers = [1,2,3,4,5,6,7,8,9,10];
  final List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.grey,
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.grey,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои альбомы'),
        actions: [
          Image(image: AssetImage('assets/images/Logo_small.png'),),
        ],
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,

      ),
        padding: EdgeInsets.all(10),
        itemCount: numbers.length,
        itemBuilder: (BuildContext context, int index) {
        return Container(
          color: colors.elementAt(index),
          child: Center(
            child: Text(
              numbers.elementAt(index).toString(),
            ),
          ),
        );
      },

      ),
    );
  }
}
