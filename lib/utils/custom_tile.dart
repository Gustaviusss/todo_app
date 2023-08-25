import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.tileText,
    required this.isCompleted,
    required this.onChecked,
  });

  final String tileText;
  final bool isCompleted;
  final void Function(bool?)? onChecked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: isCompleted == true
              ? const Color.fromARGB(255, 90, 78, 126)
              : Colors.orange,
        ),
        child: Row(children: [
          Checkbox(
              side: const BorderSide(color: Colors.white),
              checkColor: Colors.white,
              activeColor: const Color.fromARGB(255, 65, 131, 2),
              value: isCompleted,
              onChanged: onChecked),
          Flexible(
            child: Text(
              tileText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: isCompleted == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
