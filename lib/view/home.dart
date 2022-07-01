import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/home/home_bloc.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/view/add_task.dart';
import 'package:todo_app/view/edit_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTask()));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) =>
            HomeBloc(toDoRepo: RepositoryProvider.of<ToDoRepo>(context))
              ..add(FetchToDo()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state.status) {
              case HomeStatus.failure:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_open,
                      size: 100.0,
                    ),
                    Text(AppLocalizations.of(context)!.empty)
                  ],
                );
              case HomeStatus.success:
                if (state.toDo.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.toDo.length,
                          itemBuilder: (context, item) {
                            return ListTile(
                              title: Text(state.toDo[item].title),
                              leading: state.toDo[item].status == 0
                                  ? const Icon(Icons.circle_outlined)
                                  : const Icon(Icons.check_circle_outline),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditTask(
                                                titleDef:
                                                    state.toDo[item].title,
                                                descriptionDef: state
                                                    .toDo[item].description,
                                                id: state.toDo[item].id!)));
                                  },
                                  icon: const Icon(Icons.edit)),
                            );
                          }),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.folder_open,
                        size: 100.0,
                      ),
                      Text(AppLocalizations.of(context)!.empty)
                    ],
                  );
                }
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
