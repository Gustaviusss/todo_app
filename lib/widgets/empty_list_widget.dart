import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget(
      {super.key, required this.emptyListText, required this.emptyListIcon});

  final String emptyListText;
  final IconData emptyListIcon;

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
                emptyListIcon,
                color: Colors.grey[800],
                size: 50,
              ),
              Text(
                emptyListText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: Colors.grey[800]),
              )
            ]),
      ),
    );
  }
}
