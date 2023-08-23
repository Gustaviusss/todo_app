import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.grey[800],
                size: 50,
              ),
              Text(
                'Sem tarefas por enquanto, que tal criar uma?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: Colors.grey[800]),
              )
            ]),
      ),
    );
  }
}
