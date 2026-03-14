import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        'name': 'Dr. Amanda Putri',
        'message': 'Silakan lanjutkan obat selama 3 hari.',
        'time': '09:12',
      },
      {
        'name': 'Dr. Budi Santoso',
        'message': 'Bagaimana kondisi demam hari ini?',
        'time': 'Kemarin',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Chat'), centerTitle: false),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: chats.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFFEAF4FF),
                  child: Icon(Icons.person, color: Color(0xFF2F80ED)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat['name']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chat['message']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  chat['time']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
