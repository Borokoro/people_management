import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_managment/features/groups/presentation/bloc/groups_bloc.dart';
import 'package:people_managment/features/people/data/models/people_model.dart';
import 'package:people_managment/features/post_code/presentation/bloc/post_code_cubit.dart';

import '../bloc/people_bloc.dart';

containerAddPerson(
    BuildContext context,
    bool isExpanded,
    Function callBackAddPerson,
    List<TextEditingController> controllers,
    List<String> cellNames,
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
              rowForContainerAddPerson(
                  isExpanded, callBackAddPerson, context, controllers),
              isExpanded
                  ? addPersonList(cellNames, controllers, context,
                      callBackResetPanel, callBackChangeCheckBoxValue, chosen)
                  : const SizedBox(),
            ],
          )),
    ),
  );
}

rowForContainerAddPerson(bool isExpanded, Function callBackAddPerson,
    BuildContext context, List<TextEditingController> controllers) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Add Person',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        showAddPersonDataPanel(callBackAddPerson, isExpanded),
      ],
    ),
  );
}

showAddPersonDataPanel(Function callBackAddPerson, bool isExpanded) {
  return IconButton(
    onPressed: () {
      callBackAddPerson();
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

deletePersonButton(BuildContext context, int id) {
  return IconButton(
    onPressed: () {
      context.read<PeopleBloc>().add(DeletePersonEvent(
          id: context.read<PeopleBloc>().state.data[id].id, context: context));
    },
    icon: const Icon(
      IconData(0xe8b7, fontFamily: 'MaterialIcons'),
      color: Colors.black,
      size: 20,
    ),
  );
}

containerViewPerson(
    BuildContext context,
    List<TextEditingController> controllers,
    bool isExpanded,
    Function callBackViewPerson,
    int id,
    List<String> cellNames,
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
            rowForContainerViewPerson(
                isExpanded, callBackViewPerson, context, controllers, id),
            isExpanded
                ? viewPersonList(cellNames, controllers, context, id, chosen,
                    callBackChangeCheckBoxValue)
                : const SizedBox(),
          ],
        ),
      ),
    ),
  );
}

rowForContainerViewPerson(bool isExpanded, Function callBackViewPerson,
    BuildContext context, List<TextEditingController> controllers, int id) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            overflow: TextOverflow.ellipsis,
            '${context.read<PeopleBloc>().state.data[id].name} ${context.read<PeopleBloc>().state.data[id].surname}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        buttonRowViewPersonDataPanel(
            callBackViewPerson, isExpanded, id, controllers, context),
      ],
    ),
  );
}

buttonRowViewPersonDataPanel(Function callBackViewPerson, bool isExpanded,
    int id, List<TextEditingController> controllers, BuildContext context) {
  return Row(
    children: [
      deletePersonButton(context, id),
      IconButton(
        onPressed: () {
          PeopleModel person = context.read<PeopleBloc>().state.data[id];
          callBackViewPerson(id, person.groups);
          controllers[0].text = person.birthDate;
          controllers[1].text = person.city;
          controllers[2].text = person.county;
          controllers[3].text = person.name;
          controllers[4].text = person.postCode;
          controllers[5].text = person.street;
          controllers[6].text = person.surname;
          controllers[7].text = person.voivodeship;
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

addPersonList(
    List<String> cellNames,
    List<TextEditingController> controllers,
    BuildContext context,
    Function callBackResetPanel,
    Function callBackChangeCheckBoxValue,
    List<int> chosen) {
  return BlocConsumer<PostCodeCubit, PostCodeState>(
    listener: (context, state) {
      if (state is PostCodeLoading) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            });
      }
      if (state is PostCodeLoaded) {
        controllers[1].text = state.postCodeDataModel.city;
        controllers[2].text = state.postCodeDataModel.county;
        controllers[4].text = state.postCodeDataModel.postCode;
        controllers[5].text = state.postCodeDataModel.street;
        controllers[7].text = state.postCodeDataModel.voivodeship;
        Navigator.of(context).pop();
      }
      if (state is PostCodeError) {
        Navigator.of(context).pop();
      }
    },
    builder: (context, state) {
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
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == cellNames.length) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'groups:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    context.read<GroupsBloc>().state.data.isEmpty
                        ? const Text(
                            'No groups available',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        : SizedBox(
                            width: 150,
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i <
                                        context
                                            .read<GroupsBloc>()
                                            .state
                                            .data
                                            .length;
                                    i++)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          context
                                              .read<GroupsBloc>()
                                              .state
                                              .data[i]
                                              .name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                          value: chosen.contains(context
                                              .read<GroupsBloc>()
                                              .state
                                              .data[i]
                                              .id),
                                          onChanged: (bool? value) {
                                            if (value!) {
                                              callBackChangeCheckBoxValue(
                                                  context
                                                      .read<GroupsBloc>()
                                                      .state
                                                      .data[i]
                                                      .id,
                                                  true);
                                            } else {
                                              callBackChangeCheckBoxValue(
                                                  context
                                                      .read<GroupsBloc>()
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
                );
              }
              if (index == cellNames.length + 1) {
                return addToDatabaseButton(
                    context, controllers, callBackResetPanel, chosen);
              }
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${cellNames[index]}:',
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
                        onFieldSubmitted: (value) {
                          if (index == 4) {
                            context
                                .read<PostCodeCubit>()
                                .getPostCodeData(value);
                          }
                        },
                        controller: controllers[index],
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
                  ]);
            },
            itemCount: cellNames.length + 2,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 10,
            ),
          ),
        ),
      );
    },
  );
}

addToDatabaseButton(
    BuildContext context,
    List<TextEditingController> controllers,
    Function callBackResetPanel,
    List<int> chosen) {
  return ElevatedButton(
    onPressed: () {
      bool isEveryCellFilled = true;
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isEmpty) {
          isEveryCellFilled = false;
        }
      }
      if (isEveryCellFilled) {
        PeopleModel person = PeopleModel(
            birthDate: controllers[0].text,
            city: controllers[1].text,
            county: controllers[2].text,
            name: controllers[3].text,
            postCode: controllers[4].text,
            street: controllers[5].text,
            surname: controllers[6].text,
            voivodeship: controllers[7].text,
            groups: chosen,
            id: 0);
        callBackResetPanel();
        context
            .read<PeopleBloc>()
            .add(InsertPersonEvent(person: person, context: context));
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

viewPersonList(
    List<String> cellNames,
    List<TextEditingController> controllers,
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
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == cellNames.length) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'groups:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                context.read<GroupsBloc>().state.data.isEmpty
                    ? const Text(
                        "Doesn't belong",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            for (int i = 0;
                                i <
                                    context
                                        .read<GroupsBloc>()
                                        .state
                                        .data
                                        .length;
                                i++)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      context
                                          .read<GroupsBloc>()
                                          .state
                                          .data[i]
                                          .name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                      value: chosen.contains(context
                                          .read<GroupsBloc>()
                                          .state
                                          .data[i]
                                          .id),
                                      onChanged: (bool? value) {
                                        if (value!) {
                                          callBackChangeCheckBoxValue(
                                              context
                                                  .read<GroupsBloc>()
                                                  .state
                                                  .data[i]
                                                  .id,
                                              true);
                                        } else {
                                          callBackChangeCheckBoxValue(
                                              context
                                                  .read<GroupsBloc>()
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
            );
          }
          if (index == cellNames.length + 1) {
            return buttonUpdate(context, controllers, id, chosen);
          }
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cellNames[index]}:',
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
                    controller: controllers[index],
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
              ]);
        },
        itemCount: cellNames.length + 2,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 10,
        ),
      ),
    ),
  );
}

buttonUpdate(BuildContext context, List<TextEditingController> controllers,
    int id, List<int> chosen) {
  return ElevatedButton(
    onPressed: () {
      bool isEverythingFilled = true;
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text == '') isEverythingFilled = false;
      }
      if (isEverythingFilled) {
        PeopleModel person = PeopleModel(
            birthDate: controllers[0].text,
            city: controllers[1].text,
            county: controllers[2].text,
            name: controllers[3].text,
            postCode: controllers[4].text,
            street: controllers[5].text,
            surname: controllers[6].text,
            voivodeship: controllers[7].text,
            groups: chosen,
            id: context.read<PeopleBloc>().state.data[id].id);
        context
            .read<PeopleBloc>()
            .add(UpdatePersonEvent(person: person, context: context));
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightGreen,
    ),
    child: const Center(
      child: Text(
        'Update Person',
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
