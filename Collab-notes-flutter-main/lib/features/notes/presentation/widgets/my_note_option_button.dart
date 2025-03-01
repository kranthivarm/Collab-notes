import 'package:flutter/widgets.dart';

class MyNoteOptionButton extends StatelessWidget {

  final String text;
  final Color color;
  final void Function()? onTap;

  const MyNoteOptionButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.sizeOf(context).width-30)/2,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}