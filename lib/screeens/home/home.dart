import 'package:flutter/material.dart';
import 'package:task_management/screeens/home/widgets/task_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _openFormDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Task Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text;
                String description = descriptionController.text;

                titleController.clear();
                descriptionController.clear();

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Text('Task List'),
              // ),
              // Text('September 10'),
              // Text('6 tasks created today'),
              // TaskCard(
              //   createdAt: '12:02 PM',
              //   title: 'App Design',
              //   deadline: '12-03-2012',
              //   status: 'Pending',
              // ),
              // TaskCard(
              //   createdAt: '12:02 PM',
              //   title: 'App Design',
              //   deadline: '12-03-2012',
              //   status: 'Pending',
              // ),
              // TaskCard(
              //   createdAt: '12:02 PM',
              //   title: 'App Design',
              //   deadline: '12-03-2012',
              //   status: 'Pending',
              // ),
              // TaskCard(
              //   createdAt: '12:02 PM',
              //   title: 'App Design',
              //   deadline: '12-03-2012',
              //   status: 'Pending',
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openFormDialog,
        child: const Center(
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
