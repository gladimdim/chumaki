import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/views/logger_stock_view.dart';
import 'package:flutter/material.dart';

class LoggerStatsView extends StatelessWidget {
  final Logger logger;
  final VoidCallback onClose;
  const LoggerStatsView({Key? key, required this.logger, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/ui/papyrus_3.png"), fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: onClose, icon: Icon(Icons.close)),
              TitleText("Game Stats"),
              IconButton(onPressed: onClose, icon: Icon(Icons.close)),
            ],
          ),
          LoggerStockView(stock: logger.boughtStock),
        ],
      ),
    );
  }
}
