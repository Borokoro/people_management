import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../people/presentation/bloc/people_bloc.dart';
import '../../data/models/groups_model.dart';
import '../bloc/groups_bloc.dart';

containerAddGroup(
    BuildContext context,
    bool isExpanded,
    Function callBackAddGroup,
    TextEditingController controller,
    String cellName,
    Function callBackResetPanel,
    Function callBackChangeCheckBoxValue,
    List<int> chosen) {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Colors.indigoAccent, Colors.cyanAccent],
            ),
            border: Border.symmetric(
                horizontal: BorderSide(width: 2, color: Colors.black)),
          ),
          child: Column(
            children: [
              rowForContainerAddGroup(
                  isExpanded, callBackAddGroup, context, controller),
              isExpanded
                  ? addGroupList(cellName, controller, context,
                      callBackResetPanel, callBackChangeCheckBoxValue, chosen)
                  : const SizedBox(),
            ],
          )),
    ),
  );
}

rowForContainerAddGroup(bool isExpanded, Function callBackAddGroup,
    BuildContext context, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Add Group',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        showAddGroupDataPanel(callBackAddGroup, isExpanded),
      ],
    ),
  );
}

showAddGroupDataPanel(Function callBackAddGroup, bool isExpanded) {
  return IconButton(
    onPressed: isExpanded
        ? () {
            callBackAddGroup();
          }
        : () {
            callBackAddGroup();
          },
    icon: Icon(
      isExpanded
          ? const IconData(0xe799, fontFamily: 'MaterialIcons')
          : const IconData(0xe798, fontFamily: 'MaterialIcons'),
      color: Colors.black,
      size: 40,
    ),
  );
}

addGroupList(
    String cellName,
    TextEditingController controller,
    BuildContext context,
    Function callBackResetPanel,
    Function callBackChangeCheckBoxValue,
    List<int> chosen) {
  return Container(
    height: 250,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [Colors.indigoAccent, Colors.cyanAccent],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$cellName:',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        width: 150,
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Write here!',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Color(0xffb1b1b1),
                            ),
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'people:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    context.read<PeopleBloc>().state.data.isEmpty
                        ? const Text(
                            'No people available',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        : SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        context
                                            .read<PeopleBloc>()
                                            .state
                                            .data
                                            .length;
                                    i++)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          '${context.read<PeopleBloc>().state.data[i].name} ${context.read<PeopleBloc>().state.data[i].surname}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                          value: chosen.contains(context
                                              .read<PeopleBloc>()
                                              .state
                                              .data[i]
                                              .id),
                                          onChanged: (bool? value) {
                                            if (value!) {
                                              callBackChangeCheckBoxValue(
                                                  context
                                                      .read<PeopleBloc>()
                                                      .state
                                                      .data[i]
                                                      .id,
                                                  true);
                                            } else {
                                              callBackChangeCheckBoxValue(
                                                  context
                                                      .read<PeopleBloc>()
                                                      .state
                                                      .data[i]
                                                      .id,
                                                  false);
                                            }
                                          }),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          addToDatabaseButton(context, controller, callBackResetPanel, chosen),
        ],
      ),
    ),
  );
}

addToDatabaseButton(BuildContext context, TextEditingController controller,
    Function callBackResetPanel, List<int> chosen) {
  return ElevatedButton(
    onPressed: () {
      if (controller.text.isNotEmpty) {
        GroupsModel group =
            GroupsModel(name: controller.text, people: chosen, id: 0);
        callBackResetPanel();
        context
            .read<GroupsBloc>()
            .add(InsertGroupEvent(group: group, context: context));
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightGreen,
    ),
    child: const Center(
      child: Text(
        'Add to database',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}

containerViewGroup(
    BuildContext context,
    TextEditingController controller,
    bool isExpanded,
    Function callBackViewGroup,
    int id,
    String cellName,
    Function callBackChangeCheckBoxValue,
    List<int> chosen) {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.indigoAccent, Colors.cyanAccent],
          ),
          border: Border.symmetric(
              horizontal: BorderSide(width: 2, color: Colors.black)),
        ),
        child: Column(
          children: [
            rowForContainerViewGroup(
                isExpanded, callBackViewGroup, context, controller, id),
            isExpanded
                ? viewGroupList(cellName, controller, context, id, chosen,
                    callBackChangeCheckBoxValue)
                : const SizedBox(),
          ],
        ),
      ),
    ),
  );
}

rowForContainerViewGroup(bool isExpanded, Function callBackViewGroup,
    BuildContext context, TextEditingController controller, int id) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            overflow: TextOverflow.ellipsis,
            context.read<GroupsBloc>().state.data[id].name,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        buttonRowViewGroupDataPanel(
            callBackViewGroup, isExpanded, id, controller, context),
      ],
    ),
  );
}

buttonRowViewGroupDataPanel(Function callBackViewGroup, bool isExpanded, int id,
    TextEditingController controller, BuildContext context) {
  return Row(
    children: [
      deleteGroupButton(context, id),
      IconButton(
        onPressed: () {
          GroupsModel group = context.read<GroupsBloc>().state.data[id];
          callBackViewGroup(id, group.people);
          controller.text = group.name;
        },
        icon: Icon(
          isExpanded
              ? const IconData(0xe799, fontFamily: 'MaterialIcons')
              : const IconData(0xe798, fontFamily: 'MaterialIcons'),
          color: Colors.black,
          size: 40,
        ),
      ),
    ],
  );
}

deleteGroupButton(BuildContext context, int id) {
  return IconButton(
    onPressed: () {
      context.read<GroupsBloc>().add(DeleteGroupEvent(
          id: context.read<GroupsBloc>().state.data[id].id, context: context));
    },
    icon: const Icon(
      IconData(0xe8b7, fontFamily: 'MaterialIcons'),
      color: Colors.black,
      size: 20,
    ),
  );
}

viewGroupList(
    String cellName,
    TextEditingController controller,
    BuildContext context,
    int id,
    List<int> chosen,
    Function callBackChangeCheckBoxValue) {
  return Container(
    height: 250,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [Colors.indigoAccent, Colors.cyanAccent],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cellName,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        width: 150,
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Write here!',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Color(0xffb1b1b1),
                            ),
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'people:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    context.read<PeopleBloc>().state.data.isEmpty
                        ? const Text(
                            "Doesn't contain",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        : SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        context
                                            .read<PeopleBloc>()
                                            .state
                                            .data
                                            .length;
                                    i++)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          '${context.read<PeopleBloc>().state.data[i].name} ${context.read<PeopleBloc>().state.data[i].surname}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                          value: chosen.contains(context
                                              .read<PeopleBloc>()
                                              .state
                                              .data[i]
                                              .id),
                                          onChanged: (bool? value) {
                                            if (value!) {
                                              callBackChangeCheckBoxValue(
                                                  context
                                                      .read<PeopleBloc>()
                                                      .state
                                                      .data[i]
                                                      .id,
                                                  true);
                                            } else {
                                              callBackChangeCheckBoxValue(
                                                  context
                                                      .read<PeopleBloc>()
                                                      .state
                                                      .data[i]
                                                      .id,
                                                  false);
                                            }
                                          }),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          buttonUpdate(context, controller, id, chosen),
        ],
      ),
    ),
  );
}

buttonUpdate(BuildContext context, TextEditingController controller, int id,
    List<int> chosen) {
  return ElevatedButton(
    onPressed: () {
      if (controller.text != '') {
        GroupsModel group = GroupsModel(
            name: controller.text,
            people: chosen,
            id: context.read<GroupsBloc>().state.data[id].id);
        context
            .read<GroupsBloc>()
            .add(UpdateGroupEvent(group: group, context: context));
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightGreen,
    ),
    child: const Center(
      child: Text(
        'Update Group',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}
