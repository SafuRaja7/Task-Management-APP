import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:task_management/bloc/notifications/cubit.dart';
import 'package:task_management/bloc/tasks/task_cubit.dart';
import 'package:task_management/models/notifications.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/screeens/widgets/custom_snackbar.dart';
import 'package:task_management/utils/app_utils.dart';

import '../../../configs/app.dart';
import '../../../configs/space.dart';
import '../../widgets/custom_text_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final taskCubit = BlocProvider.of<TaskCubit>(context, listen: true);
    final notificationCubit =
        BlocProvider.of<NotificationsCubit>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: Space.all(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.yf(10),
                  const Text(
                    'Title',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Space.y!,
                  const CustomTextField(
                    name: 'title',
                    hint: 'Enter Title here...',
                    textInputType: TextInputType.text,
                  ),
                  Space.y!,
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Space.y1!,
                  const CustomTextField(
                    name: 'description',
                    hint: 'Enter Description here...',
                    textInputType: TextInputType.text,
                  ),
                  Space.y2!,
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final form = _formKey.currentState!;
                          final data = form.value;

                          final task = TaskModel(
                            id: AppUtils.generateUniqueId(),
                            title: data['title'],
                            description: data['description'],
                            createdat: DateTime.now(),
                            status: 'Open',
                          );
                          await taskCubit.add(task);
                          final body = NotificationBody(
                            body: 'Admin has added a task',
                            title: 'New Task Added',
                            createdAt: DateTime.now(),
                          );

                          notificationCubit.sendPushNotification(
                            'eD3XPqtoSKmMAVzb27ZU6W:APA91bFTRwSfJ0_aeTDZoF0OcQSsz693uTYCkmDdBBIqMp6OiX2zaUJ5Tr66D_cYzP0tnefuHxwlsx6Db3qjiJtlQE7dOCVWd6BT-m8omAo9bGgx090LLZD7TbCZRYb9njVMnTlTUUC8',
                            body,
                          );

                          Future.delayed(
                            const Duration(milliseconds: 700),
                            () {
                              Navigator.pop(context);
                              taskCubit.fetch();
                              CustomSnackBars.success(
                                context,
                                'Task has been added successfully',
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Add Task',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
