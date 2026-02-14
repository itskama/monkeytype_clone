import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int time;
  final int totalTime;
  final VoidCallback? onTimeSelected;

  const TimerWidget({
    super.key,
    required this.time,
    this.totalTime = 30,
    this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final progress = time / totalTime;
    final color = _getTimerColor(context, progress);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Осталось времени:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Text(
                  '$time сек',
                  key: ValueKey(time),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          if (onTimeSelected != null) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [15, 30, 60, 120].map((seconds) {
                return ChoiceChip(
                  label: Text('${seconds} сек'),
                  selected: totalTime == seconds,
                  onSelected: (_) {
                    onTimeSelected!();
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Color _getTimerColor(BuildContext context, double progress) {
    if (progress > 0.5) return Theme.of(context).colorScheme.primary;
    if (progress > 0.25) return Colors.orange;
    return Theme.of(context).colorScheme.error;
  }
}