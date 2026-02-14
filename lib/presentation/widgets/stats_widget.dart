import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final int wpm;
  final double accuracy;
  final int correctChars;
  final int incorrectChars;

  const StatsWidget({
    super.key,
    required this.wpm,
    required this.accuracy,
    required this.correctChars,
    required this.incorrectChars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                'Скорость',
                '$wpm',
                'зн/мин',
                Icons.speed,
                Theme.of(context).colorScheme.primary,
              ),
              _buildStatItem(
                context,
                'Точность',
                '${accuracy.toStringAsFixed(1)}',
                '%',
                Icons.flag,
                _getAccuracyColor(context, accuracy),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                'Правильно',
                '$correctChars',
                'символов',
                Icons.check_circle,
                Colors.green,
              ),
              _buildStatItem(
                context,
                'Ошибки',
                '$incorrectChars',
                'символов',
                Icons.error,
                Theme.of(context).colorScheme.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String title,
    String value,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Text(
            value,
            key: ValueKey('$title$value'),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Text(
          unit,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Color _getAccuracyColor(BuildContext context, double accuracy) {
    if (accuracy >= 95) return Colors.green;
    if (accuracy >= 85) return Colors.orange;
    return Theme.of(context).colorScheme.error;
  }
}