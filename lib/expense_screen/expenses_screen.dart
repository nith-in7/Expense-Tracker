import 'dart:convert';
import 'package:expense_tracker/home_page/chart/mychart.dart';
import 'package:expense_tracker/home_page/expense_display/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/modal_screen/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesTracker extends StatefulWidget {
  const ExpensesTracker({super.key});

  @override
  State<ExpensesTracker> createState() => _ExpensesState();
}

class _ExpensesState extends State<ExpensesTracker> {
  static const keyName = "expense";
  List<Expense> _expenseList = [];

  @override
  void initState() {
    getExpense();
    super.initState();
  }

  Future<List<Expense>> getExpense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? expenseStringList = prefs.getStringList(keyName);

    if (expenseStringList != null) {
      _expenseList = expenseStringList.map(
        (e) {
          final expense = jsonDecode(e);

          return Expense(
              title: expense["title"],
              amount: double.parse(expense["amount"]),
              date: DateTime.parse(expense["date"]),
              category: Category.values.firstWhere(
                  (element) => expense["category"] == element.toString()));
        },
      ).toList();
    }
    return _expenseList;
  }

  Future addExpense(Expense newExpense) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? expenseStringList = prefs.getStringList(keyName);
    final encodeNewExpense = jsonEncode(
      {
        "title": newExpense.title,
        "amount": newExpense.amount.toString(),
        "date": newExpense.date.toString(),
        "category": newExpense.category.toString(),
      },
    );

    if (expenseStringList != null) {
      await prefs
          .setStringList(keyName, [encodeNewExpense, ...expenseStringList]);
    } else {
      await prefs.setStringList(keyName, [encodeNewExpense]);
    }
  }

  Future deleteExpense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? expenseStringList = _expenseList.map(
      (e) {
        return jsonEncode(
          {
            "title": e.title,
            "amount": e.amount.toString(),
            "date": e.date.toString(),
            "category": e.category.toString()
          },
        );
      },
    ).toList();
    await prefs.setStringList(keyName, expenseStringList);
  }

  Future onDismissed(Expense toBeRemoved) async {
    setState(() {
      _expenseList.remove(toBeRemoved);
    });

    await deleteExpense();
  }

  Future addNewExpense(Expense newExpense) async {
    setState(() {
      _expenseList.add(newExpense);
    });
    await addExpense(newExpense);
  }

  void _showOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          addNewExpense: addNewExpense,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget whatToShow = const Center(
      child: Text("No Expenses Registered"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _showOverlay,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          splashColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add)),
      body: FutureBuilder(
          future: getExpense(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              whatToShow = ExpenseList(
                  expenseList: snapshot.data!,
                  onDismissed: onDismissed,
                  showOverlay: _showOverlay);
            }
            if (snapshot.hasData) {
              return Column(
                children: [
                  MyChart(expenses: _expenseList),
                  Expanded(child: whatToShow),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
