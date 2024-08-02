import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_managment/features/groups/presentation/bloc/groups_bloc.dart';
import 'package:people_managment/features/people/presentation/bloc/people_bloc.dart';

import '../widgets/people_widgets.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  List<bool> isPanelExpanded = [];
  final List<String> cellNames = [
    'birthDate',
    'city',
    'county',
    'name',
    'postCode',
    'street',
    'surname',
    'voivodeship'
  ];
  bool isAddPersonExpanded = false;
  List<int> chosen = [];
  List<TextEditingController> textControllers =
      List.generate(8, (index) => TextEditingController());

  @override
  void initState() {
    context.read<GroupsBloc>().add(const GetGroupsEvent());
    context.read<PeopleBloc>().add(const GetPeopleEvent());
    super.initState();
  }

  void expandOrHidePersonInfo(int id, List<dynamic> personGroups) {
    for (int i = 0; i < isPanelExpanded.length; i++) {
      if (id != i) {
        isPanelExpanded[i] = false;
      }
    }
    isAddPersonExpanded = false;
    setState(() {
      chosen = [];
      for (int i = 0; i < personGroups.length; i++) {
        chosen.add(personGroups[i]);
      }
      isPanelExpanded[id] = !isPanelExpanded[id];
    });
  }

  void checkBoxValueChanged(int id, bool isAdding) {
    if (isAdding) {
      setState(() {
        chosen.add(id);
      });
    } else {
      setState(() {
        chosen.removeWhere((item) => item == id);
      });
    }
  }

  void expandOrHideAddPerson() {
    for (int i = 0; i < isPanelExpanded.length; i++) {
      isPanelExpanded[i] = false;
    }
    for (int i = 0; i < textControllers.length; i++) {
      textControllers[i].text = '';
    }
    setState(() {
      chosen = [];
      isAddPersonExpanded = !isAddPersonExpanded;
    });
  }

  void resetPanel() {
    isAddPersonExpanded = !isAddPersonExpanded;
    isPanelExpanded = [];
    for (int i = 0; i < textControllers.length; i++) {
      textControllers[i].text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleBloc, PeopleState>(builder: (context, state) {
      if (state is PeopleLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is PeopleError) {
        return Center(
          child: Text(state.message),
        );
      }
      if (isPanelExpanded.isEmpty) {
        isPanelExpanded = List.generate(state.data.length, (index) => false);
      }
      return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: ListView.separated(
          itemCount: state.data.length + 1,
          itemBuilder: (context, index) {
            if (index == state.data.length) {
              return containerAddPerson(
                  context,
                  isAddPersonExpanded,
                  expandOrHideAddPerson,
                  textControllers,
                  cellNames,
                  resetPanel,
                  checkBoxValueChanged,
                  chosen);
            } else {
              return containerViewPerson(
                  context,
                  textControllers,
                  isPanelExpanded[index],
                  expandOrHidePersonInfo,
                  index,
                  cellNames,
                  checkBoxValueChanged,
                  chosen);
            }
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 16,
          ),
        ),
      );
    });
  }
}
