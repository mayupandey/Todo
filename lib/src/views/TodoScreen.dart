import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/constant/constants.dart';
import 'package:todoapp/src/provider/FirebaseProvider.dart';
import 'package:todoapp/src/provider/TodoProvider.dart';
import 'package:todoapp/src/views/LoadingScreen.dart';

import '../widget/commonwidget.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userAuth = ref.watch(firebaseAuthProvider);
    final dt = ref.watch(itemsProvider);
    final todo = ref.watch(todoProvider.notifier);

    return dt.when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          leading: const Loading(),
          backgroundColor: white,
          title: ListTile(
            title: Text(
              appBarText,
              style: greyText,
            ),
            subtitle: Text(
              userAuth.currentUser!.email!,
              style: headingBlackText,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: grey,
              onPressed: () {
                userAuth.signOut();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.black,
            onPressed: () {
              final key = GlobalKey<FormState>();
              final todoTitle = TextEditingController();
              final des = TextEditingController();
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  context: context,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: Form(
                            key: key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  modalSheetTitle,
                                  style: headingBlackText,
                                ),
                                spaceHeight(10.0),
                                bottomContainers(TextFormField(
                                  controller: todoTitle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Todo Title";
                                    }
                                    return null;
                                  },
                                  decoration: bottomSheet("Add New Todo"),
                                )),
                                spaceHeight(20.0),
                                bottomContainers(TextFormField(
                                  maxLines: 4,
                                  controller: des,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Todo Description value";
                                    }
                                    return null;
                                  },
                                  decoration: bottomSheet("Add Description"),
                                )),
                                spaceHeight(20.0),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        key.currentState!.reset();
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: Colors.blue)),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: headingBLueText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if (key.currentState!.validate()) {
                                          todo
                                              .addTodo(
                                                  todoTitle.text.toString(),
                                                  des.text.toString())
                                              .whenComplete(() =>
                                                  Navigator.of(context).pop());
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Add",
                                            style: headingWhiteText,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
            },
            child: Center(
              child: Text(
                "Add Data",
                style: headingWhiteText,
              ),
            )),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Swipe to dismiss",
                    style: headingWhiteText,
                  ),
                ),
              ),
              key: Key(data[index].title),
              onDismissed: (direction) {
                todo.deleteTodo(data[index].refrence!.id);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${data[index].title} deleted')));
              },
              child: Card(
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: data[index].isCompleted,
                        onChanged: (value) {
                          todo.updateTodoStatus(
                              data[index].refrence!.id, value!);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_document),
                        onPressed: () {
                          final key = GlobalKey<FormState>();
                          final todoTitle = TextEditingController();
                          final des = TextEditingController();
                          todoTitle.text = data[index].title;
                          des.text = data[index].description;
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              context: context,
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.85,
                                      child: Form(
                                        key: key,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              modalSheetTitle,
                                              style: headingBlackText,
                                            ),
                                            spaceHeight(10.0),
                                            bottomContainers(Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: todoTitle,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Enter Todo Title";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    bottomSheet("Add New Todo"),
                                              ),
                                            )),
                                            spaceHeight(20.0),
                                            bottomContainers(Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                maxLines: 4,
                                                controller: des,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Enter Todo Description value";
                                                  }
                                                  return null;
                                                },
                                                decoration: bottomSheet(
                                                    "Add Description"),
                                              ),
                                            )),
                                            spaceHeight(20.0),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    key.currentState!.reset();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            20,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color:
                                                                Colors.blue)),
                                                    child: Center(
                                                      child: Text(
                                                        "Cancel",
                                                        style: headingBLueText,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    if (key.currentState!
                                                        .validate()) {
                                                      todo
                                                          .addTodo(
                                                              todoTitle.text
                                                                  .toString(),
                                                              des.text
                                                                  .toString())
                                                          .whenComplete(() {
                                                        key.currentState!
                                                            .reset();
                                                        Navigator.of(context)
                                                            .pop();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Added Successfully')));
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Add",
                                                        style: headingWhiteText,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                      ),
                      title: Text(data[index].title),
                      subtitle: Text(
                        data[index].description,
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Swipe to dismiss",
                        style: greyText,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }, error: (error, stackTrace) {
      return Center(child: Text('Error ${error.toString()}'));
    }, loading: () {
      return const Loading();
    });
  }
}
