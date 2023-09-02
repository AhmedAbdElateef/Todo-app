import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';

// ignore: must_be_immutable
class CoustomCard extends StatelessWidget {
  CoustomCard(this.model, {super.key});
  Map? model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        // height: 140,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Card(
              elevation: 4,
              color: const Color.fromARGB(218, 223, 89, 129),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      child: Text(
                        '${model!['time']}',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                '${model!['title']}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${model!['date']}',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      splashColor: Colors.black,
                      onPressed: () {
                        AppCubit.get(context)
                            .updateDatabase(status: 'done', id: model!['id']);
                      },
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.grey.shade300,
                      )),
                  IconButton(
                      splashColor: Colors.black,
                      onPressed: () {
                        AppCubit.get(context).updateDatabase(
                            status: 'Archive', id: model!['id']);
                      },
                      icon: Icon(
                        Icons.archive,
                        color: Colors.grey.shade300,
                      )),
                  IconButton(
                      splashColor: Colors.black,
                      onPressed: () {
                        AppCubit.get(context)
                            .deleteFromDatabase(id: model!['id']);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey.shade300,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
