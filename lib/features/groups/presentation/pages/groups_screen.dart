import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../people/presentation/bloc/people_bloc.dart';
import '../bloc/groups_bloc.dart';
import '../widgets/groups_widgets.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  List<bool> isPanelExpanded = [];
  final String cellName = 'name';
  bool isAddGroupExpanded = false;
  TextEditingController textController = TextEditingController();
  List<int> chosen = [];

  @override
  void initState() {
    context.read<GroupsBloc>().add(const GetGroupsEvent());
    context.read<PeopleBloc>().add(const GetPeopleEvent());
    super.initState();
  }

  void expandOrHideGroupInfo(int id, List<dynamic> groupsPeople) {
    for (int i = 0; i < isPanelExpanded.length; i++) {
      if (id != i) {
        isPanelExpanded[i] = false;
      }
    }
    textController.text = '';
    isAddGroupExpanded = false;
    setState(() {
      chosen = [];
      for (int i = 0; i < groupsPeople.length; i++) {
        chosen.add(groupsPeople[i]);
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

  void expandOrHideAddGroup() {
    for (int i = 0; i < isPanelExpanded.length; i++) {
      isPanelExpanded[i] = false;
    }
    textController.text = '';
    setState(() {
      chosen = [];
      isAddGroupExpanded = !isAddGroupExpanded;
    });
  }

  void resetPanel() {
    isAddGroupExpanded = !isAddGroupExpanded;
    isPanelExpanded = [];
    textController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
      if (state is GroupsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is GroupsError) {
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
              return containerAddGroup(
                  context,
                  isAddGroupExpanded,
                  expandOrHideAddGroup,
                  textController,
                  cellName,
                  resetPanel,
                  checkBoxValueChanged,
                  chosen);
            } else {
              return containerViewGroup(
                  context,
                  textController,
                  isPanelExpanded[index],
                  expandOrHideGroupInfo,
                  index,
                  cellName,
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
