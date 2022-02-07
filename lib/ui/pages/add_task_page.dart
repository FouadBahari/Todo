import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:todoapp/ui/widgets/input_field.dart';

import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.find();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now());
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> _remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add Task',
              style: Themes().subHeadingStyle,
            ),
            InputField(
              title: 'Title',
              hint: 'Enter title here',
              controller: _titleController,
            ),
            InputField(
              title: 'Note',
              hint: 'Enter note here',
              controller: _noteController,
            ),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today_outlined),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    title: 'Start Time',
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.access_time_outlined),
                    ),
                  ),
                ),
                Expanded(
                  child: InputField(
                    title: 'End Time',
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.access_time_outlined),
                    ),
                  ),
                ),
              ],
            ),
            InputField(
              title: 'Remind',
              hint: _selectedRemind.toString() + ' minutes early',
              widget: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: DropdownButton<int>(
                  iconSize: 32,
                  style: Themes().subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                  ),
                  onTap: () {},
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRemind = newValue!;
                    });
                  },
                  items: _remindList
                      .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text('$value', style: Themes().subTitleStyle)))
                      .toList(),
                ),
              ),
            ),
            InputField(
              title: 'Repeat',
              hint: _selectedRepeat,
              widget: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: DropdownButton<String>(
                  iconSize: 32,
                  style: Themes().subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                  ),
                  onTap: () {},
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items: _repeatList
                      .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value, style: Themes().subTitleStyle)))
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color',
                        style: Themes().titleStyle,
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, right: 8),
                              child: CircleAvatar(
                                radius: 18,
                                child: _selectedColor == index
                                    ? const Icon(
                                        Icons.done,
                                        size: 20,
                                        color: white,
                                      )
                                    : null,
                                backgroundColor: index == 0
                                    ? primaryClr
                                    : index == 1
                                        ? orangeClr
                                        : blueClr,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Text(''),
                  ),
                  MyButton(label: 'Create Task', onTap: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 24,
          ),
        ),
      ],
    );
  }
}
