import 'package:flutter/material.dart';

class Profilewidget extends StatelessWidget {
  const Profilewidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textcolor,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;

  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromARGB(255, 8, 0, 0).withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Color.fromARGB(255, 8, 0, 0),
          //color: Colors.blue,
        ),
      ),
      title: InkWell(
        onTap: onPress,
        child: Text(title,
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 22, 22, 22),
            )),
      ),
    );
  }
}
