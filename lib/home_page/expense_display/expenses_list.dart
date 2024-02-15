import 'package:expense_tracker/home_page/expense_display/expenses_item.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key,
      required this.expenseList,
      required this.onDismissed,
      required this.showOverlay});
  final void Function() showOverlay;
  final List<Expense> expenseList;
  final void Function(Expense toBeRemoved) onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: expenseList.length,
        itemBuilder: (context, index) {
          return Dismissible(
              background: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 40,
                  ),
                ),
              ),
              direction: DismissDirection.endToStart,
              key: ValueKey(expenseList[index]),
              onDismissed: (direction) {
                onDismissed(expenseList[index]);
              },
              child: ExpenseItem(expense: expenseList[index]));
        });
  }
}
