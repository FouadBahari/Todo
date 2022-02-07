import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/services/notification_services.dart';
import 'package:todoapp/services/theme_services.dart';
import 'package:todoapp/ui/widgets/button.dart';

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
          // Get.to(const NotificationScreen(payload: 'title|description|10:10'));
          // NotifyHelper()
          //     .displayNotification(title: 'Theme switched', body: 'body');

          NotifyHelper().displayScheduledNotification(
              title: 'Theme switched', body: 'body');
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
              ThemeServices().switchTheme();
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
    return Expanded(child: _noTaskMsg());
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 2000),
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
        )
      ],
    );
  }
}
