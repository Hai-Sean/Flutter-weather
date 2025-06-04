import 'package:flutter/material.dart';

class TenDaysForecastElement extends StatelessWidget {
  List<String> models;

  TenDaysForecastElement({super.key, required this.models});

  @override
  Widget build(BuildContext context) {
    var day = models[0];
    var iconUrl = models[1];
    var lowTemp = models[2];
    var highTemp = models[3];

    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(color: Colors.grey.shade500,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textFormated(text: day),
              Spacer(),
              SizedBox(width: 40, child: Image(image: NetworkImage(iconUrl))),
              SizedBox(width: 16),
              _textFormated(text: lowTemp),
              SizedBox(width: 8),
              Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    colors: [const Color(0xFFFFFF00), const Color(0xFFFF0000)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
              SizedBox(width: 8),
              _textFormated(text: highTemp),
            ],
          ),
        ],
      ),
    );
  }
}

class _textFormated extends StatelessWidget {
  const _textFormated({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 22));
  }
}
