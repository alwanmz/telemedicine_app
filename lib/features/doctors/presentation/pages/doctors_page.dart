import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telemedicine_app/features/doctors/presentation/widget/doctor_card.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> specializations = const [
    'Semua',
    'Umum',
    'Anak',
    'Penyakit Dalam',
    'Kulit',
  ];

  final List<Map<String, dynamic>> allDoctors = const [
    {
      'name': 'Dr. Amanda Putri, Sp.PD',
      'specialization': 'Penyakit Dalam',
      'hospital': 'RS Sehat Sentosa',
      'experience': '8 tahun pengalaman',
      'rating': 4.9,
      'available': true,
      'category': 'Penyakit Dalam',
    },
    {
      'name': 'Dr. Budi Santoso, Sp.A',
      'specialization': 'Dokter Anak',
      'hospital': 'Klinik Medika Keluarga',
      'experience': '10 tahun pengalaman',
      'rating': 4.8,
      'available': true,
      'category': 'Anak',
    },
    {
      'name': 'Dr. Citra Lestari, Sp.KK',
      'specialization': 'Kulit & Kelamin',
      'hospital': 'RS Mitra Husada',
      'experience': '6 tahun pengalaman',
      'rating': 4.7,
      'available': false,
      'category': 'Kulit',
    },
    {
      'name': 'Dr. Dimas Pratama',
      'specialization': 'Dokter Umum',
      'hospital': 'Klinik Pratama Sejahtera',
      'experience': '5 tahun pengalaman',
      'rating': 4.6,
      'available': true,
      'category': 'Umum',
    },
  ];

  String selectedSpecialization = 'Semua';

  List<Map<String, dynamic>> get filteredDoctors {
    final query = _searchController.text.trim().toLowerCase();

    return allDoctors.where((doctor) {
      final doctorName = (doctor['name'] as String).toLowerCase();
      final specialization = (doctor['specialization'] as String).toLowerCase();
      final hospital = (doctor['hospital'] as String).toLowerCase();
      final category = doctor['category'] as String;

      final matchesSearch =
          query.isEmpty ||
          doctorName.contains(query) ||
          specialization.contains(query) ||
          hospital.contains(query);

      final matchesCategory =
          selectedSpecialization == 'Semua' ||
          category == selectedSpecialization;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {});
  }

  void _onSelectSpecialization(String value) {
    setState(() {
      selectedSpecialization = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctors = filteredDoctors;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Dokter'), centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF9CA3AF),
                ),
                hintText: 'Cari dokter atau spesialis',
                border: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF9CA3AF),
                        ),
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: specializations.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = specializations[index];
                final selected = item == selectedSpecialization;

                return GestureDetector(
                  onTap: () => _onSelectSpecialization(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF2F80ED) : Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF2F80ED)
                            : const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : const Color(0xFF374151),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            doctors.isEmpty ? 'Hasil Pencarian' : 'Dokter Tersedia',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 14),
          if (doctors.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 42,
                    color: Color(0xFF9CA3AF),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Dokter tidak ditemukan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Coba ganti kata kunci pencarian atau pilih filter lain.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )
          else
            ...doctors.map(
              (doctor) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: DoctorCard(
                  doctorName: doctor['name'] as String,
                  specialization: doctor['specialization'] as String,
                  hospitalName: doctor['hospital'] as String,
                  experience: doctor['experience'] as String,
                  rating: doctor['rating'] as double,
                  isAvailable: doctor['available'] as bool,
                  onTap: () {
                    context.push('/doctor-detail', extra: doctor);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
