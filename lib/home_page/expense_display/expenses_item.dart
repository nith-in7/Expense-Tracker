import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
      child: Card(
        
        child: InkWell(
          onTap: (){
            
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(expense.title,style: Theme.of(context).textTheme.headlineSmall,),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text("Rs. ${expense.amount.toStringAsFixed(2)}",style: Theme.of(context).textTheme.bodyLarge,),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category],size: 30, ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(expense.dateFormatter,style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
