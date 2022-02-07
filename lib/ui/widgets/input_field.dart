import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/ui/size_config.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Themes().titleStyle,
          ),
          Container(
            height: 52,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: Themes().titleStyle,
                    readOnly: widget == null ? false : true,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: Themes().hintStyle,
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
