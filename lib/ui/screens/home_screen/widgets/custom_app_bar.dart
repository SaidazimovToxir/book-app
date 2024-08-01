import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      title: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Book ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "Junction",
              style: TextStyle(
                color: Color(0xffD1618A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/icons/noti.png",
            width: 25,
            height: 25,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}