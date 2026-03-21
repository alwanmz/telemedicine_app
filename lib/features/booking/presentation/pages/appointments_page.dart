import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/appointment.dart';
import '../../providers/appointment_provider.dart';

class AppointmentsPage extends ConsumerStatefulWidget {
  const AppointmentsPage({super.key});

  @override
  ConsumerState<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends ConsumerState<AppointmentsPage> {
  static const List<String> _filters = [
    'Semua',
    'Terjadwal',
    'Dijadwalkan Ulang',
    'Dibatalkan',
  ];

  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final appointments = ref.watch(appointmentsProvider);
    final filterCounts = <String, int>{
      'Semua': appointments.length,
      'Terjadwal': appointments
          .where((item) => item.status == Appointment.statusScheduled)
          .length,
      'Dijadwalkan Ulang': appointments
          .where((item) => item.status == Appointment.statusRescheduled)
          .length,
      'Dibatalkan': appointments
          .where((item) => item.status == Appointment.statusCancelled)
          .length,
    };
    final filteredAppointments = appointments.where((item) {
      if (_selectedFilter == 'Semua') return true;
      return item.status == _statusForFilter(_selectedFilter);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Janji Temu'), centerTitle: false),
      body: appointments.isEmpty
          ? const _EmptyState()
          : Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    itemCount: _filters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = filter == _selectedFilter;

                      return InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2F80ED)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2F80ED)
                                  : const Color(0xFFE5E7EB),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                filter,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF4B5563),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 22,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.18)
                                      : const Color(0xFFEFF4FF),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  '${filterCounts[filter] ?? 0}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF2F80ED),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: filteredAppointments.isEmpty
                      ? _EmptyState(selectedFilter: _selectedFilter)
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                          itemCount: filteredAppointments.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final item = filteredAppointments[index];

                            return GestureDetector(
                              onTap: () {
                                context.push(
                                  '/appointment-detail',
                                  extra: item.id,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: const Color(0xFFE5E7EB),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.03,
                                      ),
                                      blurRadius: 14,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEAF4FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.calendar_month_rounded,
                                        color: Color(0xFF2F80ED),
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.doctorName,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF1F2937),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item.specialization,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF2F80ED),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${item.date} \u2022 ${item.time}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6B7280),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            item.consultationType,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6B7280),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Builder(
                                            builder: (context) {
                                              final status =
                                                  item.status;
                                              final statusLabel =
                                                  item.statusLabel;

                                              Color bgColor;
                                              Color textColor;

                                              if (status ==
                                                  Appointment.statusCancelled) {
                                                bgColor = const Color(
                                                  0xFFFEF2F2,
                                                );
                                                textColor = const Color(
                                                  0xFFDC2626,
                                                );
                                              } else if (status ==
                                                  Appointment
                                                      .statusRescheduled) {
                                                bgColor = const Color(
                                                  0xFFFFF7ED,
                                                );
                                                textColor = const Color(
                                                  0xFFEA580C,
                                                );
                                              } else {
                                                bgColor = const Color(
                                                  0xFFE9FBF6,
                                                );
                                                textColor = const Color(
                                                  0xFF20B486,
                                                );
                                              }

                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: bgColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        999,
                                                      ),
                                                ),
                                                child: Text(
                                                  statusLabel,
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  String? _statusForFilter(String filter) {
    if (filter == 'Terjadwal') {
      return Appointment.statusScheduled;
    }
    if (filter == 'Dijadwalkan Ulang') {
      return Appointment.statusRescheduled;
    }
    if (filter == 'Dibatalkan') {
      return Appointment.statusCancelled;
    }
    return null;
  }
}

class _EmptyState extends StatelessWidget {
  final String? selectedFilter;

  const _EmptyState({this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    final isFilteredEmpty = selectedFilter != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.event_busy_outlined,
                size: 42,
                color: Color(0xFF9CA3AF),
              ),
              const SizedBox(height: 12),
              Text(
                isFilteredEmpty
                    ? 'Belum ada janji ${selectedFilter!.toLowerCase()}'
                    : 'Belum ada janji temu',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isFilteredEmpty
                    ? 'Coba pilih filter lain untuk melihat janji temu yang tersedia.'
                    : 'Booking dokter terlebih dahulu untuk melihat daftar janji di sini.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
