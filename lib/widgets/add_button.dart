import 'package:flutter/material.dart';
import 'package:todo_app/utils/constant.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Utils.blue, borderRadius: BorderRadius.circular(12)),
        height: 50,
        width: 55,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Center(
            child: Icon(
              Icons.add,
              color: Utils.white,
              size: 45,
            ),
          ),
        ),
      ),
    );
  }
}
