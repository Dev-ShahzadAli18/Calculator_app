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
      _calculateResult();
    } else if (value == '%') {
      _percentage();
    } else {
      _appendValue(value);
    }
  }

  void _reset() {
    selectvalue = '0';
    answer = '';
    isequalpress = false;
  }

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
  }

  void _percentage() {
    if (isequalpress && answer.isNotEmpty) {
      double value = double.parse(answer);

      selectvalue = '$answer%';
      answer = _formatResult(value / 100);

      isequalpress = true;
    } else {
      if (!selectvalue.endsWith('%')) {
        selectvalue += '%';
      }
    }
  }

  void _appendValue(String val) {
    if (isequalpress) {
      if (val == '+' || val == '-' || val == '×' || val == '÷') {
        selectvalue = answer + val;
      } else {
        selectvalue = val;
      }

      answer = '';
      isequalpress = false;
      return;
    }

    if (selectvalue == '0' &&
        val != '.' &&
        val != '+' &&
        val != '-' &&
        val != '×' &&
        val != '÷') {
      selectvalue = val;
    } else {
      selectvalue += val;
    }
  }

  void _calculateResult() {
    try {
      String finalvalue = selectvalue
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-');

      double result = _evaluateBasic(finalvalue);

      answer = _formatResult(result);
      isequalpress = true;
    } catch (e) {
      answer = 'Error';
    }
  }

  String _formatResult(double result) {
    if (!result.isFinite) {
      return 'Error';
    }

    return result == result.toInt()
        ? result.toInt().toString()
        : result.toString();
  }

  double _evaluateBasic(String expression) {
    List<String> values = [];
    String current = '';

    for (int i = 0; i < expression.length; i++) {
      String value = expression[i];

      if (value == '+' || value == '-' || value == '*' || value == '/') {
        values.add(current);
        values.add(value);
        current = '';
      } else {
        current += value;
      }
    }

    values.add(current);

    for (int i = 0; i < values.length; i++) {
      String op = values[i];

      if (op == '*' || op == '/') {
        double previous = double.parse(values[i - 1]);
        double next = double.parse(values[i + 1]);

        double res = op == '*' ? previous * next : previous / next;

        if (op == '/' && next == 0) {
          throw Exception('Cannot divide by zero');
        }

        values[i - 1] = res.toString();
        values.removeAt(i);
        values.removeAt(i);
        i--;
      }
    }

    double finalResult = double.parse(values[0]);

    for (int i = 1; i < values.length; i += 2) {
      String operator = values[i];
      double next = double.parse(values[i + 1]);

      if (operator == '+') {
        finalResult += next;
      } else if (operator == '-') {
        finalResult -= next;
      }
    }

    return finalResult;
  }
}
