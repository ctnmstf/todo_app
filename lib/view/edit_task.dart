import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/bloc/editTask/edit_bloc.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/widget/custom_snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTask extends StatelessWidget {
  const EditTask(
      {Key? key,
      required this.titleDef,
      required this.descriptionDef,
      required this.id})
      : super(key: key);

  final String titleDef;
  final String descriptionDef;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editTitle),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            EditBloc(toDoRepo: RepositoryProvider.of<ToDoRepo>(context)),
        child: BlocListener<EditBloc, EditState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              CustomSnackBar.buildSnackBar(
                  context, AppLocalizations.of(context)!.fail, Colors.red);
            }
            if (state.status.isSubmissionSuccess) {
              CustomSnackBar.buildSnackBar(
                  context, AppLocalizations.of(context)!.success, Colors.green);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TitleInput(titleDef),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _DescriptionInput(descriptionDef),
                      const SizedBox(
                        height: 15.0,
                      ),
                      _UpdateButton(id),
                      _DoneButton(id),
                      _DeleteButton(id),
                    ],
                  ))
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
  const _TitleInput(this.titleDef);

  final String titleDef;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBloc, EditState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          key: const Key('reportTypeFormField'),
          initialValue: titleDef,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.title,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            errorText: state.title.invalid
                ? AppLocalizations.of(context)!.required
                : null,
          ),
          onChanged: (String? title) {
            context.read<EditBloc>().add(TitleUpdate(title!));
          },
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput(this.descriptionDef);

  final String descriptionDef;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBloc, EditState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          key: const Key('reportTypeFormField'),
          maxLines: 8,
          initialValue: descriptionDef,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.desc,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            alignLabelWithHint: true,
            errorText: state.title.invalid
                ? AppLocalizations.of(context)!.required
                : null,
          ),
          onChanged: (String? desc) {
            context.read<EditBloc>().add(DescriptionUpdate(desc!));
          },
        );
      },
    );
  }
}

class _UpdateButton extends StatelessWidget {
  const _UpdateButton(this.id);

  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBloc, EditState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                key: const Key('reportTypeSubmitButton'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  context.read<EditBloc>().add(Update(id));
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.update,
                  style: const TextStyle(color: Colors.white),
                ),
              );
      },
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton(this.id);

  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBloc, EditState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                key: const Key('reportTypeSubmitButton'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  context.read<EditBloc>().add(Done(id));
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.done,
                  style: const TextStyle(color: Colors.white),
                ),
              );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton(this.id);

  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBloc, EditState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                key: const Key('reportTypeSubmitButton'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  context.read<EditBloc>().add(Delete(id));
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.delete,
                  style: const TextStyle(color: Colors.white),
                ),
              );
      },
    );
  }
}
