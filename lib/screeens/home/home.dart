import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_management/app_routes.dart';
import 'package:task_management/bloc/auth/cubit.dart';
import 'package:task_management/bloc/tasks/task_cubit.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Management"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await authCubit.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.login, (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
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
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Space.yf(7),
                        taskCubit.state.fetch!.data!.isEmpty
                            ? const Center(
                                child: Text('Nothing to show'),
                              )
                            : ListView.builder(
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
                                                      await taskCubit.delete(
                                                          taskCubit
                                                              .state
                                                              .fetch!
                                                              .data![index]!
                                                              .id);

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
                                                    backgroundColor:
                                                        Colors.orange,
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
                                                                  .state
                                                                  .fetch!
                                                                  .data!,
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
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const AddTask();
                            },
                          ),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                );
              }
            },
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
