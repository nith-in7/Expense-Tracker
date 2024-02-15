
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});
  final double fill;
  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          alignment: Alignment.bottomLeft,
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                shape: BoxShape.rectangle,
                color: isDark
                    ? Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(.8)
                    : Theme.of(context).colorScheme.primary.withOpacity(.6)),
          ),
        ),
      ),
    );
  }
}
