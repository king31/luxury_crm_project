import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'الكل';
  final List<String> _filters = ['الكل', 'اليوم', 'الأسبوع', 'الشهر', 'مكتملة', 'قيد التنفيذ'];

  final List<Map<String, dynamic>> _visits = [
    {
      'organization': 'أرامكو السعودية',
      'date': '2024-01-15',
      'time': '10:00 ص',
      'duration': '2 ساعة',
      'location': 'الظهران',
      'type': 'زيارة',
      'status': 'completed',
      'probability': 'high',
      'team': ['أحمد', 'خالد'],
      'objectives': ['تقديم عرض', 'متابعة عقد'],
      'notes': 'العميل مهتم جداً بالخدمة',
    },
    {
      'organization': 'STC',
      'date': '2024-01-16',
      'time': '14:00 م',
      'duration': '1.5 ساعة',
      'location': 'الرياض',
      'type': 'اجتماع',
      'status': 'completed',
      'probability': 'medium',
      'team': ['أحمد'],
      'objectives': ['مناقشة تجديد العقد'],
      'notes': 'في انتظار الموافقة المالية',
    },
    {
      'organization': 'بنك الراجحي',
      'date': '2024-01-17',
      'time': '09:00 ص',
      'duration': '3 ساعات',
      'location': 'الرياض',
      'type': 'زيارة',
      'status': 'in_progress',
      'probability': 'high',
      'team': ['أحمد', 'محمد', 'سعد'],
      'objectives': ['تقييم الخدمة الحالية', 'عرض خدمات جديدة'],
      'notes': 'زيارة تقييمية شهرية',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('الزيارات الميدانية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => _showMapView(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'بحث عن زيارة...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchController.clear()),
                      )
                    : null,
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final isSelected = _filters[index] == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_filters[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedFilter = _filters[index]);
                    },
                    selectedColor: const Color(0xFFE94560),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF6C757D),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _visits.length,
              itemBuilder: (context, index) {
                final visit = _visits[index];
                return _buildVisitCard(visit);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddVisitDialog(),
        icon: const Icon(Icons.add_location),
        label: const Text('زيارة جديدة'),
      ),
    );
  }

  Widget _buildVisitCard(Map<String, dynamic> visit) {
    Color statusColor;
    String statusText;
    switch (visit['status']) {
      case 'completed':
        statusColor = const Color(0xFF28A745);
        statusText = 'مكتملة';
        break;
      case 'in_progress':
        statusColor = const Color(0xFFFFC107);
        statusText = 'قيد التنفيذ';
        break;
      default:
        statusColor = const Color(0xFF6C757D);
        statusText = 'جديدة';
    }

    Color probabilityColor;
    String probabilityText;
    switch (visit['probability']) {
      case 'high':
        probabilityColor = const Color(0xFF28A745);
        probabilityText = 'مرتفعة';
        break;
      case 'medium':
        probabilityColor = const Color(0xFFFFC107);
        probabilityText = 'متوسطة';
        break;
      default:
        probabilityColor = const Color(0xFFDC3545);
        probabilityText = 'منخفضة';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showVisitDetails(visit),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visit['organization'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 14, color: Color(0xFF6C757D)),
                            const SizedBox(width: 4),
                            Text(
                              '${visit['date']} - ${visit['time']}',
                              style: const TextStyle(fontSize: 12, color: Color(0xFF6C757D)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  _buildInfoChip(Icons.location_on, visit['location']),
                  const SizedBox(width: 8),
                  _buildInfoChip(Icons.access_time, visit['duration']),
                  const SizedBox(width: 8),
                  _buildInfoChip(Icons.people, '${visit['team'].length} أعضاء'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: probabilityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'احتمالية: $probabilityText',
                      style: TextStyle(fontSize: 11, color: probabilityColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => _showVisitReport(visit),
                    icon: const Icon(Icons.description, size: 16),
                    label: const Text('التقرير', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF6C757D)),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF6C757D))),
        ],
      ),
    );
  }

  void _showMapView() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('خريطة الزيارات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(24.7136, 46.6753),
                  zoom: 10,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('1'),
                    position: const LatLng(24.7136, 46.6753),
                    infoWindow: const InfoWindow(title: 'أرامكو السعودية'),
                  ),
                  Marker(
                    markerId: const MarkerId('2'),
                    position: const LatLng(24.7689, 46.7023),
                    infoWindow: const InfoWindow(title: 'STC'),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVisitDetails(Map<String, dynamic> visit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFADB5BD),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(visit['organization'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              _buildDetailSection('معلومات الزيارة', [
                _buildDetailRow(Icons.calendar_today, 'التاريخ', visit['date']),
                _buildDetailRow(Icons.access_time, 'الوقت', visit['time']),
                _buildDetailRow(Icons.timer, 'المدة', visit['duration']),
                _buildDetailRow(Icons.location_on, 'الموقع', visit['location']),
                _buildDetailRow(Icons.category, 'نوع الزيارة', visit['type']),
              ]),
              _buildDetailSection('الفريق', [
                ...visit['team'].map<Widget>((member) => ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF1A1A2E),
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  title: Text(member),
                  subtitle: const Text('مسؤول علاقات خارجية'),
                )).toList(),
              ]),
              _buildDetailSection('الأهداف', [
                ...visit['objectives'].map<Widget>((objective) => ListTile(
                  leading: const Icon(Icons.check_circle, color: Color(0xFF28A745)),
                  title: Text(objective),
                )).toList(),
              ]),
              _buildDetailSection('الملاحظات', [
                ListTile(
                  leading: const Icon(Icons.notes, color: Color(0xFF6C757D)),
                  title: Text(visit['notes']),
                ),
              ]),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('تعديل'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF17A2B8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('تقرير PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC3545),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVisitReport(Map<String, dynamic> visit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تقرير زيارة: ${visit['organization']}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReportSection('معلومات الزيارة', [
                'التاريخ: ${visit['date']}',
                'الوقت: ${visit['time']}',
                'المدة: ${visit['duration']}',
                'الموقع: ${visit['location']}',
              ]),
              _buildReportSection('الفريق', visit['team']),
              _buildReportSection('الأهداف', visit['objectives']),
              _buildReportSection('الملاحظات', [visit['notes']]),
              _buildReportSection('التقييم', [
                'احتمالية التعاقد: ${visit['probability']}',
                'حجم الفرصة: متوسطة',
                'أولوية المتابعة: عاجلة',
              ]),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.share),
            label: const Text('مشاركة'),
          ),
        ],
      ),
    );
  }

  Widget _buildReportSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              const Icon(Icons.check, size: 16, color: Color(0xFF28A745)),
              const SizedBox(width: 8),
              Text(item),
            ],
          ),
        )),
        const Divider(height: 24),
      ],
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        const SizedBox(height: 8),
        ...children,
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6C757D)),
      title: Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF6C757D))),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('تصفية الزيارات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _filters.map((filter) => FilterChip(
                label: Text(filter),
                selected: _selectedFilter == filter,
                onSelected: (selected) {
                  setState(() => _selectedFilter = filter);
                  Navigator.pop(context);
                },
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddVisitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة زيارة جديدة'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'المؤسسة'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'التاريخ'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'الوقت'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'الموقع'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'الأهداف'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}
