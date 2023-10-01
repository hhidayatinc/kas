import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  final String title;
  final String img;
  final void Function() nextPage;

  const GridViewWidget({
    Key? key,
    required this.title,
    required this.img,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(10, 16),
              blurRadius: 15,
              spreadRadius: -20,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                height: 50,
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}