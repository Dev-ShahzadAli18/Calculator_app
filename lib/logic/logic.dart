import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  String selectvalue = '0';
  String answer = '';
  bool isequalpress = false;

  void handleButtonPress(String value) {
    if (value == 'C') {
      _reset();
    } else if (value == '⌫') {
      _backspace();
    } else if (value == '=') {
      _calculate();
    } else if (value == '%') {
      _percentage();
    } else {
      _addValue(value);
    }
  }

  // Clear calculator
  void _reset() {
    selectvalue = '0';
    answer = '';
    isequalpress = false;
  }

  // Delete last character
  void _backspace() {
    if (isequalpress) {
      _reset();
      return;
    }

    if (selectvalue.length > 1) {
      selectvalue = selectvalue.substring(0, selectvalue.length - 1);
    } else {
      selectvalue = '0';
    }

    answer = '';
  }

  // Percentage
  void _percentage() {
    if (isequalpress) {
      if (answer.isEmpty || answer == 'Error') return;

      selectvalue = answer;
      answer = '';
      isequalpress = false;
    }

    if (selectvalue.endsWith('%')) return;

    if ('+-×÷.'.contains(selectvalue[selectvalue.length - 1])) {
      return;
    }

    selectvalue += '%';
    _calculate();
  }

  // Add numbers and operators
  void _addValue(String value) {
    const operators = '+-×÷';

    if (operators.contains(value) &&
        operators.contains(selectvalue[selectvalue.length - 1])) {
      return;
    }

    if (isequalpress) {
      if (operators.contains(value)) {
        selectvalue = answer + value;
      } else {
        selectvalue = value;
      }

      answer = '';
      isequalpress = false;
    } else if (selectvalue == '0' && value != '.') {
      selectvalue = value;
    } else {
      selectvalue += value;
    }
  }

  // Calculate using math_expressions
  void _calculate() {
    try {
      String expression = selectvalue
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100');

      Parser parser = Parser();
      Expression parsedExpression = parser.parse(expression);

      double result = parsedExpression.evaluate(
        EvaluationType.REAL,
        ContextModel(),
      );

      answer = _formatResult(result);
      isequalpress = true;
    } catch (e) {
      answer = 'Error';
    }
  }

  // Format answer
  String _formatResult(double result) {
    if (!result.isFinite) {
      return 'Error';
    }

    if (result == result.toInt()) {
      return result.toInt().toString();
    }

    return result.toString();
  }
}
