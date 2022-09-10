import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amount;
  final double multiplicador;
  final String dayLabel;

  @override
  ChartBar(
    this.amount,
    this.multiplicador,
    this.dayLabel,
  );

//______________________________________________________________________________Widget build
  @override
  Widget build(BuildContext context) {
    const double barHeight = 100;

    return LayoutBuilder(
      builder: ((context, constraints) {
        return Column(
          children: [
//______________________________________________________________________________amount
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$${amount.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
//______________________________________________________________________________chart bar
            Container(
              height: constraints.maxHeight * 0.6,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: barHeight,
                    width: 20,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 1.0,
                      //   style: BorderStyle.solid,
                      // ),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 241, 241, 241),
                    ),
                  ),
                  Container(
                    height: (barHeight * multiplicador),
                    width: 20,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 1.0,
                      //   style: BorderStyle.solid,
                      // ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
//______________________________________________________________________________day label
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  dayLabel,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
