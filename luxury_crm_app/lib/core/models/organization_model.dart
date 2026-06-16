import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  final String id;
  final String name;
  final String sector;
  final String classification;
  final String address;
  final GeoLocation location;
  final ContactInfo contactInfo;
  final BusinessInfo businessInfo;
  final List<Branch> branches;
  final List<VisitRecord> visits;
  final List<Proposal> proposals;
  final List<Contract> contracts;
  final List<EventRecord> events;
  final List<Note> notes;
  final String status;
  final double? satisfactionScore;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final List<String> assignedUsers;
  final Map<String, dynamic> customFields;
  final String? logoUrl;
  final bool isActive;
  final String? googleMapsUrl;
  final String? website;
  final String? socialMedia;

  const Organization({
    required this.id,
    required this.name,
    required this.sector,
    required this.classification,
    required this.address,
    required this.location,
    required this.contactInfo,
    required this.businessInfo,
    this.branches = const [],
    this.visits = const [],
    this.proposals = const [],
    this.contracts = const [],
    this.events = const [],
    this.notes = const [],
    this.status = 'active',
    this.satisfactionScore,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.assignedUsers = const [],
    this.customFields = const {},
    this.logoUrl,
    this.isActive = true,
    this.googleMapsUrl,
    this.website,
    this.socialMedia,
  });

  Organization copyWith({
    String? id,
    String? name,
    String? sector,
    String? classification,
    String? address,
    GeoLocation? location,
    ContactInfo? contactInfo,
    BusinessInfo? businessInfo,
    List<Branch>? branches,
    List<VisitRecord>? visits,
    List<Proposal>? proposals,
    List<Contract>? contracts,
    List<EventRecord>? events,
    List<Note>? notes,
    String? status,
    double? satisfactionScore,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    List<String>? assignedUsers,
    Map<String, dynamic>? customFields,
    String? logoUrl,
    bool? isActive,
    String? googleMapsUrl,
    String? website,
    String? socialMedia,
  }) {
    return Organization(
      id: id ?? this.id,
      name: name ?? this.name,
      sector: sector ?? this.sector,
      classification: classification ?? this.classification,
      address: address ?? this.address,
      location: location ?? this.location,
      contactInfo: contactInfo ?? this.contactInfo,
      businessInfo: businessInfo ?? this.businessInfo,
      branches: branches ?? this.branches,
      visits: visits ?? this.visits,
      proposals: proposals ?? this.proposals,
      contracts: contracts ?? this.contracts,
      events: events ?? this.events,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      satisfactionScore: satisfactionScore ?? this.satisfactionScore,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      assignedUsers: assignedUsers ?? this.assignedUsers,
      customFields: customFields ?? this.customFields,
      logoUrl: logoUrl ?? this.logoUrl,
      isActive: isActive ?? this.isActive,
      googleMapsUrl: googleMapsUrl ?? this.googleMapsUrl,
      website: website ?? this.website,
      socialMedia: socialMedia ?? this.socialMedia,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sector': sector,
      'classification': classification,
      'address': address,
      'location': location.toMap(),
      'contactInfo': contactInfo.toMap(),
      'businessInfo': businessInfo.toMap(),
      'branches': branches.map((b) => b.toMap()).toList(),
      'status': status,
      'satisfactionScore': satisfactionScore,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
      'assignedUsers': assignedUsers,
      'customFields': customFields,
      'logoUrl': logoUrl,
      'isActive': isActive,
      'googleMapsUrl': googleMapsUrl,
      'website': website,
      'socialMedia': socialMedia,
    };
  }

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      sector: map['sector'] ?? '',
      classification: map['classification'] ?? '',
      address: map['address'] ?? '',
      location: GeoLocation.fromMap(map['location'] ?? {}),
      contactInfo: ContactInfo.fromMap(map['contactInfo'] ?? {}),
      businessInfo: BusinessInfo.fromMap(map['businessInfo'] ?? {}),
      branches: (map['branches'] as List?)?.map((b) => Branch.fromMap(b)).toList() ?? [],
      status: map['status'] ?? 'active',
      satisfactionScore: map['satisfactionScore']?.toDouble(),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      createdBy: map['createdBy'] ?? '',
      assignedUsers: List<String>.from(map['assignedUsers'] ?? []),
      customFields: Map<String, dynamic>.from(map['customFields'] ?? {}),
      logoUrl: map['logoUrl'],
      isActive: map['isActive'] ?? true,
      googleMapsUrl: map['googleMapsUrl'],
      website: map['website'],
      socialMedia: map['socialMedia'],
    );
  }

  @override
  List<Object?> get props => [
    id, name, sector, classification, address, location,
    contactInfo, businessInfo, status, satisfactionScore,
    createdAt, updatedAt, isActive,
  ];
}

class GeoLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String? address;
  final String? city;
  final String? country;

  const GeoLocation({
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
    this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'country': country,
    };
  }

  factory GeoLocation.fromMap(Map<String, dynamic> map) {
    return GeoLocation(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      address: map['address'],
      city: map['city'],
      country: map['country'],
    );
  }

  @override
  List<Object?> get props => [latitude, longitude, address, city, country];
}

class ContactInfo extends Equatable {
  final String generalManager;
  final String purchasingManager;
  final String financeManager;
  final String phone;
  final String? mobile;
  final String? whatsapp;
  final String email;
  final String? alternativeEmail;
  final String? fax;

  const ContactInfo({
    required this.generalManager,
    required this.purchasingManager,
    required this.financeManager,
    required this.phone,
    this.mobile,
    this.whatsapp,
    required this.email,
    this.alternativeEmail,
    this.fax,
  });

  Map<String, dynamic> toMap() {
    return {
      'generalManager': generalManager,
      'purchasingManager': purchasingManager,
      'financeManager': financeManager,
      'phone': phone,
      'mobile': mobile,
      'whatsapp': whatsapp,
      'email': email,
      'alternativeEmail': alternativeEmail,
      'fax': fax,
    };
  }

  factory ContactInfo.fromMap(Map<String, dynamic> map) {
    return ContactInfo(
      generalManager: map['generalManager'] ?? '',
      purchasingManager: map['purchasingManager'] ?? '',
      financeManager: map['financeManager'] ?? '',
      phone: map['phone'] ?? '',
      mobile: map['mobile'],
      whatsapp: map['whatsapp'],
      email: map['email'] ?? '',
      alternativeEmail: map['alternativeEmail'],
      fax: map['fax'],
    );
  }

  @override
  List<Object?> get props => [
    generalManager, purchasingManager, financeManager,
    phone, mobile, whatsapp, email, alternativeEmail, fax,
  ];
}

class BusinessInfo extends Equatable {
  final String size;
  final int employeeCount;
  final int branchCount;
  final DateTime? establishedDate;
  final String? currentSupplier;
  final String? currentHospitalitySystem;
  final double? annualBudget;
  final String? industry;
  final String? subIndustry;

  const BusinessInfo({
    required this.size,
    required this.employeeCount,
    required this.branchCount,
    this.establishedDate,
    this.currentSupplier,
    this.currentHospitalitySystem,
    this.annualBudget,
    this.industry,
    this.subIndustry,
  });

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'employeeCount': employeeCount,
      'branchCount': branchCount,
      'establishedDate': establishedDate?.toIso8601String(),
      'currentSupplier': currentSupplier,
      'currentHospitalitySystem': currentHospitalitySystem,
      'annualBudget': annualBudget,
      'industry': industry,
      'subIndustry': subIndustry,
    };
  }

  factory BusinessInfo.fromMap(Map<String, dynamic> map) {
    return BusinessInfo(
      size: map['size'] ?? '',
      employeeCount: map['employeeCount'] ?? 0,
      branchCount: map['branchCount'] ?? 0,
      establishedDate: map['establishedDate'] != null 
          ? DateTime.parse(map['establishedDate']) 
          : null,
      currentSupplier: map['currentSupplier'],
      currentHospitalitySystem: map['currentHospitalitySystem'],
      annualBudget: map['annualBudget']?.toDouble(),
      industry: map['industry'],
      subIndustry: map['subIndustry'],
    );
  }

  @override
  List<Object?> get props => [
    size, employeeCount, branchCount, establishedDate,
    currentSupplier, currentHospitalitySystem, annualBudget,
    industry, subIndustry,
  ];
}

class Branch extends Equatable {
  final String id;
  final String name;
  final String address;
  final GeoLocation location;
  final String? phone;
  final String? manager;
  final int employeeCount;
  final bool isActive;

  const Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    this.phone,
    this.manager,
    this.employeeCount = 0,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'location': location.toMap(),
      'phone': phone,
      'manager': manager,
      'employeeCount': employeeCount,
      'isActive': isActive,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      location: GeoLocation.fromMap(map['location'] ?? {}),
      phone: map['phone'],
      manager: map['manager'],
      employeeCount: map['employeeCount'] ?? 0,
      isActive: map['isActive'] ?? true,
    );
  }

  @override
  List<Object?> get props => [id, name, address, location, phone, manager, employeeCount, isActive];
}

class Note extends Equatable {
  final String id;
  final String content;
  final String createdBy;
  final DateTime createdAt;
  final String? attachmentUrl;
  final bool isPrivate;

  const Note({
    required this.id,
    required this.content,
    required this.createdBy,
    required this.createdAt,
    this.attachmentUrl,
    this.isPrivate = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'attachmentUrl': attachmentUrl,
      'isPrivate': isPrivate,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      attachmentUrl: map['attachmentUrl'],
      isPrivate: map['isPrivate'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, content, createdBy, createdAt, isPrivate];
}

// Placeholder classes for relationships
class VisitRecord extends Equatable {
  final String id;
  final DateTime date;
  final String status;

  const VisitRecord({required this.id, required this.date, required this.status});

  Map<String, dynamic> toMap() => {'id': id, 'date': date.toIso8601String(), 'status': status};
  factory VisitRecord.fromMap(Map<String, dynamic> map) => VisitRecord(
    id: map['id'] ?? '',
    date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    status: map['status'] ?? '',
  );

  @override
  List<Object?> get props => [id, date, status];
}

class Proposal extends Equatable {
  final String id;
  final String number;
  final double amount;
  final String status;

  const Proposal({required this.id, required this.number, required this.amount, required this.status});

  Map<String, dynamic> toMap() => {'id': id, 'number': number, 'amount': amount, 'status': status};
  factory Proposal.fromMap(Map<String, dynamic> map) => Proposal(
    id: map['id'] ?? '',
    number: map['number'] ?? '',
    amount: map['amount']?.toDouble() ?? 0.0,
    status: map['status'] ?? '',
  );

  @override
  List<Object?> get props => [id, number, amount, status];
}

class Contract extends Equatable {
  final String id;
  final String number;
  final String type;
  final String status;

  const Contract({required this.id, required this.number, required this.type, required this.status});

  Map<String, dynamic> toMap() => {'id': id, 'number': number, 'type': type, 'status': status};
  factory Contract.fromMap(Map<String, dynamic> map) => Contract(
    id: map['id'] ?? '',
    number: map['number'] ?? '',
    type: map['type'] ?? '',
    status: map['status'] ?? '',
  );

  @override
  List<Object?> get props => [id, number, type, status];
}

class EventRecord extends Equatable {
  final String id;
  final String name;
  final DateTime date;
  final String status;

  const EventRecord({required this.id, required this.name, required this.date, required this.status});

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'date': date.toIso8601String(), 'status': status};
  factory EventRecord.fromMap(Map<String, dynamic> map) => EventRecord(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    status: map['status'] ?? '',
  );

  @override
  List<Object?> get props => [id, name, date, status];
}
