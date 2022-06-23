import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/controller/addTask/add_task_bloc.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/widget/custom_snackbar.dart';

class AddTask extends StatelessWidget{
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => AddTaskBloc(toDoRepo: RepositoryProvider.of<ToDoRepo>(context)),
        child: BlocListener<AddTaskBloc, AddTaskState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              CustomSnackBar.buildSnackBar(context,
                  'Fail!', Colors.red);
            }
            if (state.status.isSubmissionSuccess) {
              CustomSnackBar.buildSnackBar(
                  context, 'Success', Colors.green);
            }
          },
          child: SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TitleInput(),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _DescriptionInput(),
                          const SizedBox(
                            height: 15.0,
                          ),
                          _SubmitButton(),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          key: const Key('reportTypeFormField'),
          decoration: InputDecoration(
            labelText: 'Title',
            prefixIcon: const Icon(Icons.title),
            errorText: state.title.invalid ? 'Required' : null,
          ),
          onChanged: (String? title) {
            context.read<AddTaskBloc>().add(TitleChanged(title!));
          },
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(
      buildWhen: (previous, current) => previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          key: const Key('reportTypeFormField'),
          decoration: InputDecoration(
            labelText: 'Description',
            prefixIcon: const Icon(Icons.description),
            errorText: state.title.invalid ? 'Required' : null,
          ),
          onChanged: (String? desc) {
            context.read<AddTaskBloc>().add(DescriptionChanged(desc!));
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
          key: const Key('reportTypeSubmitButton'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),),
          onPressed: state.status.isValidated
              ? () {
            context
                .read<AddTaskBloc>()
                .add(const FormSubmitted());
          }
              : null,
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}