import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/widget/coustom_form.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.pink,
              title: Text(cubit.titles[cubit.selected]),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              enableFeedback: true,
              heroTag: "edit",
              tooltip: 'edit',
              backgroundColor: Colors.pink,
              onPressed: () {
                if (cubit.show) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                    // insertToDatabase(
                    //         title: titleController.text,
                    //         time: timeController.text,
                    //         date: dateController.text)
                    //     .then((value) {
                    //   getDataFromDatabase(database!).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   show = false;
                    //     //   icona = Icons.edit;
                    //     //   tasks = value;
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                            color: const Color.fromARGB(255, 241, 148, 176),
                            padding: const EdgeInsets.all(20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CoustomFormField(
                                    controller: titleController,
                                    tybe: TextInputType.text,
                                    label: "Task Title",
                                    prefix: const Icon(Icons.title),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CoustomFormField(
                                    controller: timeController,
                                    tybe: TextInputType.datetime,
                                    enabled: true,
                                    onTap: () {
                                      showTimePicker(
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                // change the border color
                                                primary: Colors.red,
                                                // change the text color
                                                onSurface: Colors.purple,
                                              ),
                                              // button colors
                                              buttonTheme:
                                                  const ButtonThemeData(
                                                colorScheme: ColorScheme.light(
                                                  primary: Colors.green,
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        if (value != null) {
                                          timeController.text =
                                              value.format(context).toString();
                                        }
                                      });
                                    },
                                    label: "Task Time",
                                    prefix:
                                        const Icon(Icons.watch_later_outlined),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CoustomFormField(
                                    controller: dateController,
                                    tybe: TextInputType.datetime,
                                    enabled: true,
                                    onTap: () {
                                      showDatePicker(
                                              builder: (context, child) {
                                                return Theme(
                                                  data:
                                                      ThemeData.dark().copyWith(
                                                    colorScheme:
                                                        const ColorScheme.dark(
                                                      // change the border color
                                                      primary: Colors.red,
                                                      // change the text color
                                                      onSurface: Colors.purple,
                                                    ),
                                                    // button colors
                                                    buttonTheme:
                                                        const ButtonThemeData(
                                                      colorScheme:
                                                          ColorScheme.dark(
                                                        primary: Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse("2028-12-31"))
                                          .then((value) {
                                        if (value != null) {
                                          dateController.text =
                                              DateFormat.yMMMMd()
                                                  .format(value)
                                                  .toString();
                                        }
                                      });
                                    },
                                    label: "Task Date",
                                    prefix: const Icon(Icons.calendar_today),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.ChangeBottomSheet(isShow: false, isIcona: Icons.edit);
                  });
                  cubit.ChangeBottomSheet(isShow: true, isIcona: Icons.add);
                }
              },
              child:
                  cubit.show ? const Icon(Icons.add) : const Icon(Icons.edit),
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (val) {
                  cubit.changeIndex(val);
                },
                currentIndex: cubit.selected,
                backgroundColor: Colors.pink,
                selectedItemColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "New Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle), label: "DoneTasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: "Archive Tasks"),
                ]),
            body: cubit.screens[cubit.selected],
          );
        },
      ),
    );
  }
}
