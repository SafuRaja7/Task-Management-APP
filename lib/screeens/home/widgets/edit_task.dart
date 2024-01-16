// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:task_management/bloc/auth/cubit.dart';
import 'package:task_management/bloc/notifications/cubit.dart';

import 'package:task_management/configs/app.dart';
import 'package:task_management/models/notifications.dart';

import '../../../bloc/tasks/task_cubit.dart';
import '../../../configs/space.dart';
import '../../../models/task_model.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_field.dart';

class EditTask extends StatefulWidget {
  final int index;
  final List<TaskModel?> task;
  const EditTask({
    super.key,
    required this.index,
    required this.task,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormBuilderState>();
  String status = '';
  List<String> tokens = [];
  @override
  void initState() {
    super.initState();
    final authCubit = AuthCubit.cubit(context);
    tokens = List.from(tokens)
      ..add(
        authCubit.state.data!.deviceToken,
      );
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final taskCubit = BlocProvider.of<TaskCubit>(context, listen: true);
    final notificationCubit =
        BlocProvider.of<NotificationsCubit>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state.fetch is TaskFetchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.fetch is TaskFetchFailed) {
                return Center(
                  child: Text(state.fetch!.message!),
                );
              } else {
                return FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: Space.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Space.y!,
                        CustomTextField(
                          name: 'title',
                          hint: 'Enter Title here...',
                          initialValue: state.fetch!.data![widget.index]!.title,
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
                        CustomTextField(
                          name: 'description',
                          hint: 'Enter Description here...',
                          initialValue:
                              state.fetch!.data![widget.index]!.description,
                          textInputType: TextInputType.text,
                        ),
                        Space.y1!,
                        const Text(
                          'Change Status',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Space.y1!,
                        FormBuilderRadioGroup(
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          initialValue:
                              state.fetch!.data![widget.index]!.status,
                          name: 'type',
                          onChanged: (value) {
                            status = value!;
                          },
                          options: ['Open', 'Closed', 'InProgress']
                              .map(
                                (e) => FormBuilderFieldOption(
                                  value: e,
                                ),
                              )
                              .toList(growable: false),
                        ),
                        Space.y2!,
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.saveAndValidate()) {
                                final form = _formKey.currentState!;
                                final data = form.value;
                                widget.task[widget.index]!.title =
                                    data['title'];
                                widget.task[widget.index]!.description =
                                    data['description'];
                                widget.task[widget.index]!.status = status;

                                await taskCubit.updateTicket(
                                  widget.task[widget.index]!,
                                  widget.index,
                                );
                                final body = NotificationBody(
                                  body: 'Admin has updated a task',
                                  title: 'Task Updated',
                                  createdAt: DateTime.now(),
                                );

                                notificationCubit.sendPushNotification(
                                    'eD3XPqtoSKmMAVzb27ZU6W:APA91bFTRwSfJ0_aeTDZoF0OcQSsz693uTYCkmDdBBIqMp6OiX2zaUJ5Tr66D_cYzP0tnefuHxwlsx6Db3qjiJtlQE7dOCVWd6BT-m8omAo9bGgx090LLZD7TbCZRYb9njVMnTlTUUC8',
                                    body);
                                Future.delayed(
                                  const Duration(milliseconds: 700),
                                  () {
                                    Navigator.pop(context);
                                    taskCubit.fetch();
                                    CustomSnackBars.success(
                                      context,
                                      'Task has been updated successfully',
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text(
                              'Edit Task',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
