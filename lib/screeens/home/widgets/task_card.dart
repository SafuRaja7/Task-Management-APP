// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/configs/app_typography.dart';
import 'package:task_management/configs/space.dart';

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
      height: height * .15,
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
              height: height * .17,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[300],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            width: width * .78,
            height: height * .15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: width * .25,
                    height: height * .035,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(status),
                    ),
                  ),
                ),
                Text(
                  'Title: $title',
                  maxLines: 1,
                ),
                Space.y!,
                Text(
                  'Desc : $description',
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
