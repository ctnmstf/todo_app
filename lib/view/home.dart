import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/controller/home/home_bloc.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/view/add_task.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTask()));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(toDoRepo: RepositoryProvider.of<ToDoRepo>(context))..add(FetchToDo()),
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (prev, current) => prev.toDo != current.toDo,
          builder: (context, state) {
            switch (state.status) {
              case HomeStatus.failure:
                return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.folder_open,
                          size: 100.0,
                        ),
                        Text(
                            'This place is empty. You can fill it with the Add button.')
                      ],
                    ));
              case HomeStatus.success:
                if (state.toDo.isNotEmpty) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.toDo.length,
                        itemBuilder: (context, item) {
                          return Card(
                            child: ListTile(
                              title: Text(state.toDo[item].title),
                              subtitle: Text(state.toDo[item].description),
                              leading: state.toDo[item].status == 0
                                  ? const Icon(Icons.circle_outlined)
                                  : const Icon(Icons.check_circle_outline),
                              trailing: const Icon(
                                  Icons.keyboard_double_arrow_left_rounded),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.folder_open,
                            size: 100.0,
                          ),
                          Text(
                              'This place is empty. You can fill it with the Add button.')
                        ],
                      ));
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
