import 'package:equatable/equatable.dart';

class Visit extends Equatable {
  final String id;
  final String organizationId;
  final String organizationName;
  final DateTime date;
  final String day;
  final String time;
  final String duration;
  final String location;
  final String? googleMapsUrl;
  final String sector;
  final String organizationType;
  final ContactPerson contactPerson;
  final int employeeCount;
  final int branchCount;
  final List<String> branchLocations;
  final String? currentHospitalitySystem;
  final String? currentSupplier;
  final List<TeamMember> team;
  final List<VisitObjective> objectives;
  final OrganizationNeed need;
  final String generalNotes;
  final String outputs;
  final String recommendations;
  final String contractProbability;
  final String opportunitySize;
  final String followUpPriority;
  final String customerStatus;
  final List<Signature> signatures;
  final String status;
  final DateTime createdAt;
  final String createdBy;
  final List<String> photos;
  final String? voiceNoteUrl;
  final bool isSynced;
  final DateTime? syncedAt;

  const Visit({
    required this.id,
    required this.organizationId,
    required this.organizationName,
    required this.date,
    required this.day,
    required this.time,
    required this.duration,
    required this.location,
    this.googleMapsUrl,
    required this.sector,
    required this.organizationType,
    required this.contactPerson,
    required this.employeeCount,
    required this.branchCount,
    this.branchLocations = const [],
    this.currentHospitalitySystem,
    this.currentSupplier,
    this.team = const [],
    this.objectives = const [],
    required this.need,
    this.generalNotes = '',
    this.outputs = '',
    this.recommendations = '',
    this.contractProbability = 'medium',
    this.opportunitySize = 'medium',
    this.followUpPriority = 'normal',
    this.customerStatus = 'following',
    this.signatures = const [],
    this.status = 'completed',
    required this.createdAt,
    required this.createdBy,
    this.photos = const [],
    this.voiceNoteUrl,
    this.isSynced = false,
    this.syncedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'date': date.toIso8601String(),
      'day': day,
      'time': time,
      'duration': duration,
      'location': location,
      'googleMapsUrl': googleMapsUrl,
      'sector': sector,
      'organizationType': organizationType,
      'contactPerson': contactPerson.toMap(),
      'employeeCount': employeeCount,
      'branchCount': branchCount,
      'branchLocations': branchLocations,
      'currentHospitalitySystem': currentHospitalitySystem,
      'currentSupplier': currentSupplier,
      'team': team.map((t) => t.toMap()).toList(),
      'objectives': objectives.map((o) => o.toMap()).toList(),
      'need': need.toMap(),
      'generalNotes': generalNotes,
      'outputs': outputs,
      'recommendations': recommendations,
      'contractProbability': contractProbability,
      'opportunitySize': opportunitySize,
      'followUpPriority': followUpPriority,
      'customerStatus': customerStatus,
      'signatures': signatures.map((s) => s.toMap()).toList(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'photos': photos,
      'voiceNoteUrl': voiceNoteUrl,
      'isSynced': isSynced,
      'syncedAt': syncedAt?.toIso8601String(),
    };
  }

  factory Visit.fromMap(Map<String, dynamic> map) {
    return Visit(
      id: map['id'] ?? '',
      organizationId: map['organizationId'] ?? '',
      organizationName: map['organizationName'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      day: map['day'] ?? '',
      time: map['time'] ?? '',
      duration: map['duration'] ?? '',
      location: map['location'] ?? '',
      googleMapsUrl: map['googleMapsUrl'],
      sector: map['sector'] ?? '',
      organizationType: map['organizationType'] ?? '',
      contactPerson: ContactPerson.fromMap(map['contactPerson'] ?? {}),
      employeeCount: map['employeeCount'] ?? 0,
      branchCount: map['branchCount'] ?? 0,
      branchLocations: List<String>.from(map['branchLocations'] ?? []),
      currentHospitalitySystem: map['currentHospitalitySystem'],
      currentSupplier: map['currentSupplier'],
      team: (map['team'] as List?)?.map((t) => TeamMember.fromMap(t)).toList() ?? [],
      objectives: (map['objectives'] as List?)?.map((o) => VisitObjective.fromMap(o)).toList() ?? [],
      need: OrganizationNeed.fromMap(map['need'] ?? {}),
      generalNotes: map['generalNotes'] ?? '',
      outputs: map['outputs'] ?? '',
      recommendations: map['recommendations'] ?? '',
      contractProbability: map['contractProbability'] ?? 'medium',
      opportunitySize: map['opportunitySize'] ?? 'medium',
      followUpPriority: map['followUpPriority'] ?? 'normal',
      customerStatus: map['customerStatus'] ?? 'following',
      signatures: (map['signatures'] as List?)?.map((s) => Signature.fromMap(s)).toList() ?? [],
      status: map['status'] ?? 'completed',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      createdBy: map['createdBy'] ?? '',
      photos: List<String>.from(map['photos'] ?? []),
      voiceNoteUrl: map['voiceNoteUrl'],
      isSynced: map['isSynced'] ?? false,
      syncedAt: map['syncedAt'] != null ? DateTime.parse(map['syncedAt']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, organizationId, date, status, isSynced,
  ];
}

class ContactPerson extends Equatable {
  final String name;
  final String position;
  final String phone;
  final String? whatsapp;
  final String email;

  const ContactPerson({
    required this.name,
    required this.position,
    required this.phone,
    this.whatsapp,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
      'phone': phone,
      'whatsapp': whatsapp,
      'email': email,
    };
  }

  factory ContactPerson.fromMap(Map<String, dynamic> map) {
    return ContactPerson(
      name: map['name'] ?? '',
      position: map['position'] ?? '',
      phone: map['phone'] ?? '',
      whatsapp: map['whatsapp'],
      email: map['email'] ?? '',
    );
  }

  @override
  List<Object?> get props => [name, position, phone, whatsapp, email];
}

class TeamMember extends Equatable {
  final String name;
  final String department;
  final String position;

  const TeamMember({
    required this.name,
    required this.department,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'department': department,
      'position': position,
    };
  }

  factory TeamMember.fromMap(Map<String, dynamic> map) {
    return TeamMember(
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      position: map['position'] ?? '',
    );
  }

  @override
  List<Object?> get props => [name, department, position];
}

class VisitObjective extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final String? notes;

  const VisitObjective({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'notes': notes,
    };
  }

  factory VisitObjective.fromMap(Map<String, dynamic> map) {
    return VisitObjective(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      notes: map['notes'],
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}

class OrganizationNeed extends Equatable {
  final String type;
  final String details;
  final int? expectedMealCount;
  final int? monthlyEventsCount;
  final int? averageAttendance;
  final double? estimatedBudget;
  final String? requiredDeliveryTimes;
  final String? specialRequirements;
  final String? additionalNotes;

  const OrganizationNeed({
    required this.type,
    required this.details,
    this.expectedMealCount,
    this.monthlyEventsCount,
    this.averageAttendance,
    this.estimatedBudget,
    this.requiredDeliveryTimes,
    this.specialRequirements,
    this.additionalNotes,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'details': details,
      'expectedMealCount': expectedMealCount,
      'monthlyEventsCount': monthlyEventsCount,
      'averageAttendance': averageAttendance,
      'estimatedBudget': estimatedBudget,
      'requiredDeliveryTimes': requiredDeliveryTimes,
      'specialRequirements': specialRequirements,
      'additionalNotes': additionalNotes,
    };
  }

  factory OrganizationNeed.fromMap(Map<String, dynamic> map) {
    return OrganizationNeed(
      type: map['type'] ?? '',
      details: map['details'] ?? '',
      expectedMealCount: map['expectedMealCount'],
      monthlyEventsCount: map['monthlyEventsCount'],
      averageAttendance: map['averageAttendance'],
      estimatedBudget: map['estimatedBudget']?.toDouble(),
      requiredDeliveryTimes: map['requiredDeliveryTimes'],
      specialRequirements: map['specialRequirements'],
      additionalNotes: map['additionalNotes'],
    );
  }

  @override
  List<Object?> get props => [
    type, details, expectedMealCount, monthlyEventsCount,
    averageAttendance, estimatedBudget, requiredDeliveryTimes,
    specialRequirements, additionalNotes,
  ];
}

class Signature extends Equatable {
  final String name;
  final String? signatureUrl;
  final DateTime? signedAt;

  const Signature({
    required this.name,
    this.signatureUrl,
    this.signedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'signatureUrl': signatureUrl,
      'signedAt': signedAt?.toIso8601String(),
    };
  }

  factory Signature.fromMap(Map<String, dynamic> map) {
    return Signature(
      name: map['name'] ?? '',
      signatureUrl: map['signatureUrl'],
      signedAt: map['signedAt'] != null ? DateTime.parse(map['signedAt']) : null,
    );
  }

  @override
  List<Object?> get props => [name, signatureUrl, signedAt];
}
