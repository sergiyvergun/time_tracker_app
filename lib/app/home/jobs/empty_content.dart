import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    this.title = 'Empty state',
    this.message = 'Add new item',
  }) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 30, color: Colors.black54),
        ),
        Container(height: 50),
        Text(
          message,
          style: TextStyle(fontSize: 30, color: Colors.black45),
        )
      ],
    );
  }
}
