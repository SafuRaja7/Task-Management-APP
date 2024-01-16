import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management/app_routes.dart';
import 'package:task_management/bloc/auth/cubit.dart';
import 'package:task_management/bloc/notifications/cubit.dart';
import 'package:task_management/bloc/tasks/task_cubit.dart';
import 'package:task_management/models/notifications.dart';
import 'package:task_management/screeens/home/widgets/add_task.dart';
import 'package:task_management/screeens/home/widgets/edit_task.dart';
import 'package:task_management/screeens/home/widgets/task_card.dart';
import 'package:task_management/utils/notification_handler.dart';

import '../../configs/space.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
    final authCubit = AuthCubit.cubit(context, false);
    final taskCubit = TaskCubit.cubit(context, false);
    authCubit.fetch();
    taskCubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.cubit(context, true);
    final taskCubit = TaskCubit.cubit(context, true);
    final notificationCubit =
        BlocProvider.of<NotificationsCubit>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Management"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await authCubit.logout();
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.login, (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Space.y2!,
              BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                if (state is AuthFetchLoading ||
                    taskCubit.state.fetch is TaskFetchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AuthFetchFailed ||
                    taskCubit.state.fetch is TaskFetchFailed) {
                  return Center(
                    child: Text(state.message!),
                  );
                } else {
                  // if (taskCubit.state.fetch!.data!.isEmpty) {
                  //   return Center(
                  //     child: Lottie.asset(
                  //       'assets/not_found.json',
                  //       width: MediaQuery.of(context).size.width * .7,
                  //       height: MediaQuery.of(context).size.height * .4,
                  //       fit: BoxFit.cover,
                  //       repeat: true,
                  //       animate: true,
                  //     ),
                  //   );
                  // } else {
                  return Column(
                    children: [
                      if (state.data!.type == 'Admin') ...[
                        Align(
                          alignment: Alignment.topCenter,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const AddTask();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              height: MediaQuery.of(context).size.height * .05,
                              width: MediaQuery.of(context).size.height * .15,
                              child: const Center(
                                child: Text('Add Task'),
                              ),
                            ),
                          ),
                        ),
                        Space.y1!,
                      ],
                      if (taskCubit.state.fetch!.data!.isEmpty)
                        Center(
                          child: Lottie.asset(
                            'assets/not_found.json',
                            width: MediaQuery.of(context).size.width * .7,
                            height: MediaQuery.of(context).size.height * .4,
                            fit: BoxFit.cover,
                            repeat: true,
                            animate: true,
                          ),
                        ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: taskCubit.state.fetch!.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final e = taskCubit.state.fetch!.data![index];
                          return Column(
                            children: [
                              Slidable(
                                startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    state.data!.type != 'User'
                                        ? SlidableAction(
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                            onPressed: (context) async {
                                              await taskCubit.delete(taskCubit
                                                  .state
                                                  .fetch!
                                                  .data![index]!
                                                  .id);
                                              final body = NotificationBody(
                                                body:
                                                    'Admin has deleted a task',
                                                title: 'Task Deleted',
                                                createdAt: DateTime.now(),
                                              );

                                              notificationCubit
                                                  .sendPushNotification(
                                                'eD3XPqtoSKmMAVzb27ZU6W:APA91bFTRwSfJ0_aeTDZoF0OcQSsz693uTYCkmDdBBIqMp6OiX2zaUJ5Tr66D_cYzP0tnefuHxwlsx6Db3qjiJtlQE7dOCVWd6BT-m8omAo9bGgx090LLZD7TbCZRYb9njVMnTlTUUC8',
                                                body,
                                              );
                                              taskCubit.fetch();
                                            },
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    state.data!.type != 'User'
                                        ? SlidableAction(
                                            backgroundColor: Colors.orange,
                                            icon: Icons.edit,
                                            label: 'Edit',
                                            onPressed: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return EditTask(
                                                      index: index,
                                                      task: taskCubit
                                                          .state.fetch!.data!,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                                child: TaskCard(
                                  title: e!.title,
                                  description: e.description,
                                  createdAt: e.createdat,
                                  status: e.status,
                                ),
                              ),
                              Space.y1!,
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
      // floatingActionButton: authCubit.state.data!.type == 'Admin'
      //     ? FloatingActionButton(
      //         onPressed: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return const AddTask();
      //     },
      //   ),
      // );
      //         },
      //         child: const Center(
      //           child: Icon(Icons.add),
      //         ),
      //       )
      //     : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
