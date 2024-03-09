import 'package:flutter/material.dart';

void main() {
  runApp(const VerifyCodeForm());
}

class VerifyCodeForm extends StatelessWidget {
  const VerifyCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verify Code Form',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Code Form'),
        ),
        body: const VerifyCodeWidget(),
      ),
    );
  }
}

class VerifyCodeWidget extends StatefulWidget {
  const VerifyCodeWidget({super.key});

  @override
  _VerifyCodeWidgetState createState() => _VerifyCodeWidgetState();
}

class _VerifyCodeWidgetState extends State<VerifyCodeWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildCodeDigitField(0),
              buildCodeDigitField(1),
              buildCodeDigitField(2),
              buildCodeDigitField(3),
            ],
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Verify the code here
              // You can access the entered code using _controller.text
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }

  Widget buildCodeDigitField(int index) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
