// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/configs/app_typography.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime createdAt;
  final String status;
  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

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
            right: 40,
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
            width: width * .78,
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
                Text(
                  title,
                  maxLines: 1,
                ),
                Text(
                  description,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            child: Text(
              DateFormat('dd/MM/yy').format(createdAt),
              style: AppText.l2,
            ),
          ),
        ],
      ),
    );
  }
}
