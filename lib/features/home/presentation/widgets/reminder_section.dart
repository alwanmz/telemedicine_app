import 'package:flutter/material.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'reminder_card.dart';

class ReminderSection extends StatelessWidget {
  const ReminderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Pengingat Saya', style: AppTextStyles.titleMedium),
            ),
            TextButton(onPressed: () {}, child: const Text('Tambah Baru')),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ReminderCard(
                medicineName: 'Amlodipin',
                dosage: '10mg, 1 Kapsul',
                time: '21.00, Sebelum Tidur',
                actionText: 'Tandai Selesai',
              ),
              SizedBox(width: 12),
              ReminderCard(
                medicineName: 'RS Fatmawati',
                dosage: 'Dokter Fisioterapi',
                time: '15.00, Hari ini',
                actionText: 'Tandai Selesai',
                icon: Icons.calendar_today_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
