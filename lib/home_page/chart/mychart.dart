import 'package:expense_tracker/home_page/chart/mychart_bar.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class MyChart extends StatelessWidget {
  const MyChart({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    List<ExpenseBucket> l = [];
    for (final i in Category.values) {
      l.add(ExpenseBucket.forCategory(expenses, i));
    }
    var maxCategoryAmount = 0.0;
    for (final i in l) {
      if (i.totalExpense > maxCategoryAmount) {
        maxCategoryAmount = i.totalExpense;
      }
    }
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.background.withOpacity(0),
          Theme.of(context).colorScheme.primary.withOpacity(.3)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              for (final i in l)
                ChartBar(
                    fill: i.totalExpense == 0
                        ? 0.0
                        : i.totalExpense / maxCategoryAmount)
            ]),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: l.map((e) {
                return Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(categoryIcons[e.category],
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? colorScheme.primary
                          : colorScheme.onSecondaryContainer),
                ));
              }).toList()),
        ],
      ),
    );
  }
}
