import 'package:calculator_appp/logic/calculator_function.dart';
import 'package:calculator_appp/logic/logic.dart';
import 'package:calculator_appp/utils/app_colors.dart';
import 'package:calculator_appp/widgets/custom_button.dart';
import 'package:calculator_appp/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _logic = CalculatorLogic();

  final TextEditingController _controller = TextEditingController(text: '0');

  String _yourvalues = '';
  bool _showCursor = false;

  final List buttons = [
    {'text': 'C', 'color': AppColors.lightButton},
    {'text': '⌫', 'color': AppColors.lightButton},
    {'text': '%', 'color': AppColors.lightButton},
    {'text': '÷', 'color': AppColors.operatorButton},

    {'text': '7', 'color': AppColors.darkButton},
    {'text': '8', 'color': AppColors.darkButton},
    {'text': '9', 'color': AppColors.darkButton},
    {'text': '×', 'color': AppColors.operatorButton},

    {'text': '4', 'color': AppColors.darkButton},
    {'text': '5', 'color': AppColors.darkButton},
    {'text': '6', 'color': AppColors.darkButton},
    {'text': '-', 'color': AppColors.operatorButton},

    {'text': '1', 'color': AppColors.darkButton},
    {'text': '2', 'color': AppColors.darkButton},
    {'text': '3', 'color': AppColors.darkButton},
    {'text': '+', 'color': AppColors.operatorButton},

    {'text': '0', 'color': AppColors.darkButton},
    {'text': '.', 'color': AppColors.darkButton},
    {'text': '=', 'color': AppColors.operatorButton},
  ];

  @override
  void initState() {
    super.initState();
    _controller.text = _logic.selectvalue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonPressed(String value) {
    setState(() {
      _showCursor = false;

      handleButtonPress(value, _controller, _logic, (newanswer) {
        if (value == '=') {
          _yourvalues = newanswer;
        } else if (value == 'C') {
          _yourvalues = '';
        } else if (value == '%') {
          _yourvalues = newanswer;
        }
      }, () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),

          child: Column(
            children: [
              Expanded(
                child: CustomContainer(
                  controller: _controller,
                  answer: _logic.answer,
                  yourvalues: _yourvalues,
                  showCursor: _showCursor,
                  onTap: () {
                    setState(() {
                      _showCursor = true;
                    });
                  },
                ),
              ),

              SizedBox(height: 15),

              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                children: buttons.map((button) {
                  final text = button['text'];

                  final calculatorButton = CalculatorButton(
                    text: text,
                    color: button['color'],
                    onTap: () => _onButtonPressed(text),
                  );

                  if (text == '0') {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: calculatorButton,
                    );
                  }

                  return calculatorButton;
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
