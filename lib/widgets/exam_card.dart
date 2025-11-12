import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../screens/exam_detail_screen.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

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
    final now = DateTime.now();
    final isPast = exam.dateTime.isBefore(now);
    final dateStr = _formatDate(exam.dateTime);
    final timeStr = _formatTime(exam.dateTime);

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: isPast ? Colors.grey.shade100 : Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ExamDetailScreen(exam: exam)),
          );
        },
        child: Row(
          children: [
            Container(
              width: 6,
              height: 120,
              decoration: BoxDecoration(
                color: isPast ? Colors.red : Colors.green,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'exam_${exam.title}_${exam.dateTime.toIso8601String()}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          exam.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 6),
                        Text('$dateStr • $timeStr', style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 6),
                        Expanded(child: Text(exam.rooms.join(', '), style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Chip(
                      label: Text(isPast ? 'Поминат' : 'Активен'),
                      backgroundColor: isPast ? Colors.grey.shade200 : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
