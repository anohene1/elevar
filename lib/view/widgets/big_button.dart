import 'package:flutter/material.dart';


class BigButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const BigButton({Key? key, required this.label, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: double.infinity,
        height: 70,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Color(0xff246CFD), borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(color: Color(0xffA06AFA), shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 20)),),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: Text(label, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}