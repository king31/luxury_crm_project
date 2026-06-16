import 'package:flutter/material.dart';

class CRMScreen extends StatefulWidget {
  const CRMScreen({super.key});

  @override
  State<CRMScreen> createState() => _CRMScreenState();
}

class _CRMScreenState extends State<CRMScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'الكل';
  final List<String> _filters = ['الكل', 'نشط', 'غير نشط', 'VIP', 'جديد'];

  final List<Map<String, dynamic>> _organizations = [
    {
      'name': 'أرامكو السعودية',
      'sector': 'نفط وغاز',
      'classification': 'VIP',
      'status': 'active',
      'contacts': 5,
      'visits': 12,
      'proposals': 8,
      'contracts': 3,
      'satisfaction': 95,
    },
    {
      'name': 'STC',
      'sector': 'اتصالات',
      'classification': 'VIP',
      'status': 'active',
      'contacts': 4,
      'visits': 10,
      'proposals': 6,
      'contracts': 2,
      'satisfaction': 92,
    },
    {
      'name': 'بنك الراجحي',
      'sector': 'مصارف',
      'classification': 'A',
      'status': 'active',
      'contacts': 3,
      'visits': 8,
      'proposals': 4,
      'contracts': 1,
      'satisfaction': 88,
    },
    {
      'name': 'سابك',
      'sector': 'بتروكيماويات',
      'classification': 'VIP',
      'status': 'active',
      'contacts': 6,
      'visits': 15,
      'proposals': 10,
      'contracts': 4,
      'satisfaction': 90,
    },
    {
      'name': 'جامعة الملك سعود',
      'sector': 'تعليم',
      'classification': 'A',
      'status': 'following',
      'contacts': 2,
      'visits': 5,
      'proposals': 2,
      'contracts': 0,
      'satisfaction': 85,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text('إدارة العملاء والمؤسسات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
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
                hintText: 'بحث عن مؤسسة...',
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
                    selectedColor: const Color(0xFF1A1A2E),
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
              itemCount: _organizations.length,
              itemBuilder: (context, index) {
                final org = _organizations[index];
                return _buildOrganizationCard(org);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrganizationDialog(),
        icon: const Icon(Icons.add_business),
        label: const Text('مؤسسة جديدة'),
      ),
    );
  }

  Widget _buildOrganizationCard(Map<String, dynamic> org) {
    Color classificationColor;
    switch (org['classification']) {
      case 'VIP':
        classificationColor = const Color(0xFFFFC107);
        break;
      case 'A':
        classificationColor = const Color(0xFF17A2B8);
        break;
      default:
        classificationColor = const Color(0xFF6C757D);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showOrganizationDetails(org),
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
                          org['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          org['sector'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6C757D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: classificationColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: classificationColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      org['classification'],
                      style: TextStyle(
                        color: classificationColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn(Icons.people, '${org['contacts']}', 'جهات اتصال'),
                  _buildStatColumn(Icons.location_on, '${org['visits']}', 'زيارة'),
                  _buildStatColumn(Icons.description, '${org['proposals']}', 'عرض سعر'),
                  _buildStatColumn(Icons.assignment, '${org['contracts']}', 'عقد'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.sentiment_satisfied, size: 16, color: Color(0xFF28A745)),
                  const SizedBox(width: 4),
                  Text(
                    'رضا العملاء: ${org['satisfaction']}%',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF28A745),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: org['status'] == 'active'
                          ? const Color(0xFF28A745).withOpacity(0.1)
                          : const Color(0xFFFFC107).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      org['status'] == 'active' ? 'نشط' : 'متابعة',
                      style: TextStyle(
                        fontSize: 11,
                        color: org['status'] == 'active' ? const Color(0xFF28A745) : const Color(0xFFFFC107),
                        fontWeight: FontWeight.w600,
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

  Widget _buildStatColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFFADB5BD)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF1A1A2E),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFFADB5BD),
          ),
        ),
      ],
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
            const Text('تصفية المؤسسات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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

  void _showAddOrganizationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة مؤسسة جديدة'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'اسم المؤسسة'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'القطاع'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'التصنيف'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'العنوان'),
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

  void _showOrganizationDetails(Map<String, dynamic> org) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
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
              Text(
                org['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                org['sector'],
                style: const TextStyle(fontSize: 16, color: Color(0xFF6C757D)),
              ),
              const SizedBox(height: 24),
              _buildDetailSection('معلومات التواصل', [
                _buildDetailRow(Icons.person, 'المدير العام', 'محمد العبدالله'),
                _buildDetailRow(Icons.phone, 'الجوال', '0501234567'),
                _buildDetailRow(Icons.email, 'البريد', 'info@company.com'),
              ]),
              _buildDetailSection('الإحصائيات', [
                _buildDetailRow(Icons.location_on, 'الزيارات', '${org['visits']} زيارة'),
                _buildDetailRow(Icons.description, 'عروض الأسعار', '${org['proposals']} عرض'),
                _buildDetailRow(Icons.assignment, 'العقود', '${org['contracts']} عقد'),
              ]),
              _buildDetailSection('الموقع', [
                ListTile(
                  leading: const Icon(Icons.map, color: Color(0xFF17A2B8)),
                  title: const Text('عرض على الخريطة'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
        ),
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
}
