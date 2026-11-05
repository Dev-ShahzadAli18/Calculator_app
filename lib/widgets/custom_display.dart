import 'package:calculator_appp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDisplay extends StatelessWidget {
  final TextEditingController controller;
  final String answer;
  final String yourvalues;
  final bool showCursor;
  final VoidCallback onTap;

  const CustomDisplay({
    super.key,
    required this.controller,
    required this.answer,
    required this.yourvalues,
    required this.showCursor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isResult = answer.isNotEmpty;

    return Container(
      width: double.infinity,
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.symmetric(vertical: 0),
      child: isResult
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  yourvalues,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                ),
                SizedBox(height: 12),
                Text(
                  answer,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppColors.operatorButton,
                  ),
                ),
              ],
            )
          : TextFormField(
              controller: controller,
              readOnly: true,
              showCursor: showCursor,
              onTap: onTap,
              expands: true,
              maxLines: null,
              minLines: null,
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.bottom,
              scrollPhysics: NeverScrollableScrollPhysics(),
              style: TextStyle(
                fontSize: controller.text.length > 25
                    ? 25
                    : controller.text.length > 18
                    ? 30
                    : controller.text.length > 12
                    ? 35
                    : 40,
                color: AppColors.displayText,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
    );
  }
}
