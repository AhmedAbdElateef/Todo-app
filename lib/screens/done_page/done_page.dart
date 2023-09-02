import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/widget/coustom_card.dart';

class DoneTaskes extends StatelessWidget {
  const DoneTaskes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;

        if (tasks.isNotEmpty) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => CoustomCard(tasks[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 1),
              itemCount: tasks.length);
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.pink.shade200,
                  size: 200,
                ),
                Text(
                  "No Tasks yat , Please Add Your Task",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade200),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
