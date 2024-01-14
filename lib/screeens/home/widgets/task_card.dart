// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String deadline;
  final String createdAt;
  final String status;
  const TaskCard({
    Key? key,
    required this.title,
    required this.deadline,
    required this.createdAt,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .95,
      height: height * .13,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
              ),
              width: width * .7,
              height: height * .15,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            width: width * .7,
            height: height * .13,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.more_vert),
                ),
                Container(
                  width: width * .25,
                  height: height * .035,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text(status)),
                ),
                Text(title),
                Text(deadline),
              ],
            ),
          ),
          Positioned(
            left: 4,
            child: Text(
              createdAt,
            ),
          ),
        ],
      ),
    );
  }
}
