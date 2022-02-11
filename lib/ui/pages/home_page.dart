import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/services/notification_services.dart';
import 'package:todoapp/services/theme_services.dart';
import 'package:todoapp/ui/widgets/button.dart';
import 'package:todoapp/ui/widgets/task_tile.dart';

import '../size_config.dart';
import '../theme.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              _addTaskBar(),
              const SizedBox(
                height: 10,
              ),
              _addDateBar(),
              const SizedBox(
                height: 10,
              ),
              _showTasks(),
            ],
          ),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
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

  _addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()).toString(),
              style: Themes().subHeadingStyle,
            ),
            Text(
              'Today',
              style: Themes().headingStyle,
            ),
          ],
        ),
        MyButton(
            label: '+ add Task',
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTasks();
            }),
      ],
    );
  }

  _addDateBar() {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: _selectedDate,
      width: 80,
      height: 100,
      selectedTextColor: white,
      selectionColor: primaryClr,
      dayTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      dateTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      monthTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onDateChange: (newDate) {
        setState(() {
          _selectedDate = newDate;
        });
      },
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          if (_taskController.taskList.isEmpty) {
            print(_taskController.taskList.length);
            return _noTaskMsg();
          } else {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                scrollDirection: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                itemCount: _taskController.taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  Task task = _taskController.taskList[index];

                  if (task.repeat == 'Daily' ||
                      task.date == DateFormat.yMd().format(_selectedDate) ||
                      (task.repeat == 'Weekly' &&
                          _selectedDate
                                      .difference(
                                          DateFormat.yMd().parse(task.date!))
                                      .inDays %
                                  7 ==
                              0) ||
                      (task.repeat == 'Monthly' &&
                          DateFormat.yMd().parse(task.date!).day ==
                              _selectedDate.day)) {
                    var date = DateFormat.jm().parse(task.startTime!);
                    var myTime = DateFormat('HH:mm').format(date);

                    // NotifyHelper().displayNotification(
                    //     title: task.title!, body: task.note!);
                    NotifyHelper().displayScheduledNotification(
                        int.parse(myTime.toString().split(':')[0]),
                        int.parse(myTime.toString().split(':')[1]),
                        task);

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ),
                      ),
                    );
                  } else
                    return Container();
                },
              ),
            );
          }
        },
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 220,
                        ),
                  SvgPicture.asset(
                    'images/task.svg',
                    color: primaryClr.withOpacity(0.5),
                    height: 140,
                  ),
                  Text(
                    'You do not have any tasks yet\nAdd new tasks to make your days productive.',
                    textAlign: TextAlign.center,
                    style: Themes().subTitleStyle,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color color,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? Themes().titleStyle
                : Themes().titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.39),
        width: SizeConfig.screenWidth,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const SizedBox(height: 10),
            (task.isCompleted == 1)
                ? Container()
                : _buildBottomSheet(
                    label: 'Task Completed',
                    onTap: () {
                      NotifyHelper().cancelNotification(id: task.id!);
                      _taskController.markAsCompleted(id: task.id!);
                      Get.back();
                    },
                    color: primaryClr),
            _buildBottomSheet(
                label: 'Delete Task',
                onTap: () {
                  NotifyHelper().cancelNotification(id: task.id!);
                  _taskController.deleteTasks(task: task);
                  Get.back();
                },
                color: Colors.red[300]!),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            _buildBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                color: primaryClr),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ));
  }

  Future<void> _onRefresh() async {
    _taskController.getTasks();
  }
}
