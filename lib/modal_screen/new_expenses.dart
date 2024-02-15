import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat("dd/MM/yyyy");

class NewExpense extends StatefulWidget {
  const NewExpense({required this.addNewExpense, super.key});
  final void Function(Expense newExpense) addNewExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  Category? _selectedCategory;

  void _showDialog() {
    final titleText = _titleController.text.trim().isEmpty;
    final amountText = double.tryParse(_amountController.text);

    if (titleText ||
        amountText == null ||
        _dateController.text == "" ||
        amountText <= 0 ||
        _selectedCategory == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Invalid Input"),
              actions: [
              
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"),
                ),
              ],
            );
          });
    } else {
      Expense newMember = Expense(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          date: selectedDate,
          category: _selectedCategory!);
      widget.addNewExpense(newMember);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  DateTime selectedDate = DateTime.now();
  void onDateSelect(DateTime selected) {
    selectedDate = selected;
    _dateController.text = formatter.format(selectedDate);
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    onDateSelect(pickedDate!);
  }

  TextField getTextField(
      {required TextEditingController textController,
      required InputDecoration decoration,
      required int? maxLength,
      required TextInputAction keyBoardAction,
      required TextInputType? keyBoardType}) {
    return TextField(
      controller: textController,
      maxLength: maxLength,
      decoration: decoration,
      keyboardType: keyBoardType,
      textInputAction: keyBoardAction,
    );
  }

  // TextField(
  //                 controller: _amountController,
  //                 decoration: const InputDecoration(
  //                   label: Text("Amount"),
  //                   prefixIcon: Icon(Icons.currency_rupee),
  //                   prefix: Text("Rs. "),
  //                 ),
  //                 keyboardType: TextInputType.number,
  //                 textInputAction: TextInputAction.done,
  //               ),
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        children: [
          getTextField(
              textController: _titleController,
              maxLength: 30,
              keyBoardType: null,
              keyBoardAction: TextInputAction.next,
              decoration: const InputDecoration(
                  label: Text("Title"), prefixIcon: Icon(Icons.title))),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: getTextField(
                    textController: _amountController,
                    decoration: const InputDecoration(
                      label: Text("Amount"),
                      prefixIcon: Icon(Icons.currency_rupee),
                      prefix: Text("Rs. "),
                    ),
                    maxLength: null,
                    keyBoardAction: TextInputAction.done,
                    keyBoardType: TextInputType.number),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextField(
                  readOnly: true,
                  onTap: _openDatePicker,
                  controller: _dateController,
                  decoration: const InputDecoration(
                      label: Text("Date"),
                      prefixIcon: Icon(Icons.calendar_month_outlined)),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          DropdownButtonFormField(
              hint: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  Icon(Icons.category_outlined),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Select the Category"),
                ],
              ),
              items: Category.values.map((e) {
                return DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 14,
                        ),
                        Icon(categoryIcons[e]),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(e.name[0].toUpperCase() + e.name.substring(1))
                      ],
                    ));
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedCategory = value;
                });
              }),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 160,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  child: const Text("Cancel"),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 160,
                height: 50,
                child: FilledButton(
                  onPressed: _showDialog,
                  style: FilledButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal)),
                  child: const Text("Save Expense"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
