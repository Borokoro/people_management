import 'package:flutter/material.dart';

appBarSkeleton(BuildContext context, int chosenScreen) {
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: true,
    title: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        chosenScreen ==0 ? 'People' : 'Groups',
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}