import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  String _timeRemaining() {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    if (diff.isNegative) return 'Испитот е поминат';
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    return '$days дена, $hours часа';
  }

  String _formatDate(DateTime dt) {
    const days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${days[dt.weekday % 7]}, ${dt.day.toString().padLeft(2,'0')} ${months[dt.month-1]} ${dt.year}';
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = _formatDate(exam.dateTime);
    final timeStr = _formatTime(exam.dateTime);

    return Scaffold(
      appBar: AppBar(title: const Text('Детали за испит')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'exam_${exam.title}_${exam.dateTime.toIso8601String()}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  exam.title,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [const Icon(Icons.calendar_today), const SizedBox(width: 8), Text('$dateStr • $timeStr')]),
            const SizedBox(height: 12),
            Row(children: [const Icon(Icons.location_on), const SizedBox(width: 8), Text(exam.rooms.join(', '))]),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [const Icon(Icons.timer), const SizedBox(width: 12), Text(_timeRemaining())],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
