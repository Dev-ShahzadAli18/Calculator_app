import 'package:flutter/material.dart';

void handleButtonPress(
  String value,
  TextEditingController controller,
  dynamic logic,
  Function(String) yourvalues,
  Function() scrollToRight,
) {
  if (value == '=') {
    logic.selectvalue = controller.text;
    logic.handleButtonPress('=');
    controller.text = logic.selectvalue;
    yourvalues(controller.text);
  } else if (value == 'C') {
    logic.handleButtonPress('C');
    controller.text = logic.selectvalue;
    yourvalues('');
  } else if (value == '%') {
    if (logic.isequalpress &&
        logic.answer.isNotEmpty &&
        logic.answer != 'Error') {
      String previousResult = logic.answer;
      logic.handleButtonPress('%');

      controller.text = logic.selectvalue;
      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );
      yourvalues('$previousResult%');
    } else {
      final text = controller.text;
      final selection = controller.selection;

      if (!text.endsWith('%')) {
        final newText = text.replaceRange(selection.start, selection.end, '%');
        controller.text = newText;
        controller.selection = TextSelection.collapsed(
          offset: selection.start + 1,
        );
      }
      logic.selectvalue = controller.text;
    }
  } else if (value == '⌫') {
    final text = controller.text;
    final selectvalue = controller.selection;

    if (selectvalue.isValid &&
        selectvalue.isCollapsed &&
        selectvalue.start > 0) {
      final newText = text.replaceRange(
        selectvalue.start - 1,
        selectvalue.start,
        '',
      );
      controller.text = newText.isEmpty ? '0' : newText;
      controller.selection = TextSelection.collapsed(
        offset: selectvalue.start - 1,
      );
    } else if (text.length > 1) {
      controller.text = text.substring(0, text.length - 1);
    } else {
      controller.text = '0';
    }

    logic.selectvalue = controller.text;
    logic.answer = '';
    logic.isequalpress = false;
  } else {
    final text = controller.text;
    final selectvalue = controller.selection;

    if (text == '0' && !'+−×÷.%'.contains(value)) {
      controller.text = value;
      controller.selection = TextSelection.collapsed(offset: 1);
    } else if (selectvalue.isValid) {
      final newText = text.replaceRange(
        selectvalue.start,
        selectvalue.end,
        value,
      );
      controller.text = newText;
      controller.selection = TextSelection.collapsed(
        offset: selectvalue.start + value.length,
      );
    } else {
      controller.text += value;
      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );
    }

    logic.selectvalue = controller.text;
    logic.answer = '';
    logic.isequalpress = false;
  }

  scrollToRight();
}
