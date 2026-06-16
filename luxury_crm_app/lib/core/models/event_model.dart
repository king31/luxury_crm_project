import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String eventNumber;
  final String name;
  final String type;
  final DateTime date;
  final String day;
  final String time;
  final String organizationId;
  final String organizationName;
  final String coordinatorName;
  final String coordinatorPhone;
  final String location;
  final String? googleMapsUrl;
  final String? supplierId;
  final String? supplierName;
  final List<EventService> services;
  final EventDetails details;
  final FinancialDetails financial;
  final String? paymentMethod;
  final PaymentDetails? paymentDetails;
  final String operationalNotes;
  final String clientNotes;
  final EventEvaluation evaluation;
  final List<Approval> approvals;
  final List<String> attachments;
  final String status;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final bool isSynced;

  const Event({
    required this.id,
    required this.eventNumber,
    required this.name,
    required this.type,
    required this.date,
    required this.day,
    required this.time,
    required this.organizationId,
    required this.organizationName,
    required this.coordinatorName,
    required this.coordinatorPhone,
    required this.location,
    this.googleMapsUrl,
    this.supplierId,
    this.supplierName,
    this.services = const [],
    required this.details,
    required this.financial,
    this.paymentMethod,
    this.paymentDetails,
    this.operationalNotes = '',
    this.clientNotes = '',
    required this.evaluation,
    this.approvals = const [],
    this.attachments = const [],
    this.status = 'planned',
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventNumber': eventNumber,
      'name': name,
      'type': type,
      'date': date.toIso8601String(),
      'day': day,
      'time': time,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'coordinatorName': coordinatorName,
      'coordinatorPhone': coordinatorPhone,
      'location': location,
      'googleMapsUrl': googleMapsUrl,
      'supplierId': supplierId,
      'supplierName': supplierName,
      'services': services.map((s) => s.toMap()).toList(),
      'details': details.toMap(),
      'financial': financial.toMap(),
      'paymentMethod': paymentMethod,
      'paymentDetails': paymentDetails?.toMap(),
      'operationalNotes': operationalNotes,
      'clientNotes': clientNotes,
      'evaluation': evaluation.toMap(),
      'approvals': approvals.map((a) => a.toMap()).toList(),
      'attachments': attachments,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'updatedAt': updatedAt.toIso8601String(),
      'isSynced': isSynced,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      eventNumber: map['eventNumber'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      day: map['day'] ?? '',
      time: map['time'] ?? '',
      organizationId: map['organizationId'] ?? '',
      organizationName: map['organizationName'] ?? '',
      coordinatorName: map['coordinatorName'] ?? '',
      coordinatorPhone: map['coordinatorPhone'] ?? '',
      location: map['location'] ?? '',
      googleMapsUrl: map['googleMapsUrl'],
      supplierId: map['supplierId'],
      supplierName: map['supplierName'],
      services: (map['services'] as List?)?.map((s) => EventService.fromMap(s)).toList() ?? [],
      details: EventDetails.fromMap(map['details'] ?? {}),
      financial: FinancialDetails.fromMap(map['financial'] ?? {}),
      paymentMethod: map['paymentMethod'],
      paymentDetails: map['paymentDetails'] != null ? PaymentDetails.fromMap(map['paymentDetails']) : null,
      operationalNotes: map['operationalNotes'] ?? '',
      clientNotes: map['clientNotes'] ?? '',
      evaluation: EventEvaluation.fromMap(map['evaluation'] ?? {}),
      approvals: (map['approvals'] as List?)?.map((a) => Approval.fromMap(a)).toList() ?? [],
      attachments: List<String>.from(map['attachments'] ?? []),
      status: map['status'] ?? 'planned',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      createdBy: map['createdBy'] ?? '',
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      isSynced: map['isSynced'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, eventNumber, name, type, date, status];
}

class EventService extends Equatable {
  final String id;
  final String item;
  final String details;
  final String? mealType;
  final String? beverages;
  final String? desserts;
  final String? specialAdditions;
  final String serviceType;
  final String? specialRequirements;

  const EventService({
    required this.id,
    required this.item,
    required this.details,
    this.mealType,
    this.beverages,
    this.desserts,
    this.specialAdditions,
    required this.serviceType,
    this.specialRequirements,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item': item,
      'details': details,
      'mealType': mealType,
      'beverages': beverages,
      'desserts': desserts,
      'specialAdditions': specialAdditions,
      'serviceType': serviceType,
      'specialRequirements': specialRequirements,
    };
  }

  factory EventService.fromMap(Map<String, dynamic> map) {
    return EventService(
      id: map['id'] ?? '',
      item: map['item'] ?? '',
      details: map['details'] ?? '',
      mealType: map['mealType'],
      beverages: map['beverages'],
      desserts: map['desserts'],
      specialAdditions: map['specialAdditions'],
      serviceType: map['serviceType'] ?? '',
      specialRequirements: map['specialRequirements'],
    );
  }

  @override
  List<Object?> get props => [id, item, serviceType];
}

class EventDetails extends Equatable {
  final int personCount;
  final double pricePerPerson;
  final int tableCount;
  final int staffCount;
  final String supervisorName;
  final String preparationTime;
  final String deliveryTime;
  final String serviceEndTime;
  final String? setupRequirements;
  final String? cleanupRequirements;
  final String? equipmentNeeded;

  const EventDetails({
    required this.personCount,
    required this.pricePerPerson,
    required this.tableCount,
    required this.staffCount,
    required this.supervisorName,
    required this.preparationTime,
    required this.deliveryTime,
    required this.serviceEndTime,
    this.setupRequirements,
    this.cleanupRequirements,
    this.equipmentNeeded,
  });

  Map<String, dynamic> toMap() {
    return {
      'personCount': personCount,
      'pricePerPerson': pricePerPerson,
      'tableCount': tableCount,
      'staffCount': staffCount,
      'supervisorName': supervisorName,
      'preparationTime': preparationTime,
      'deliveryTime': deliveryTime,
      'serviceEndTime': serviceEndTime,
      'setupRequirements': setupRequirements,
      'cleanupRequirements': cleanupRequirements,
      'equipmentNeeded': equipmentNeeded,
    };
  }

  factory EventDetails.fromMap(Map<String, dynamic> map) {
    return EventDetails(
      personCount: map['personCount'] ?? 0,
      pricePerPerson: map['pricePerPerson']?.toDouble() ?? 0.0,
      tableCount: map['tableCount'] ?? 0,
      staffCount: map['staffCount'] ?? 0,
      supervisorName: map['supervisorName'] ?? '',
      preparationTime: map['preparationTime'] ?? '',
      deliveryTime: map['deliveryTime'] ?? '',
      serviceEndTime: map['serviceEndTime'] ?? '',
      setupRequirements: map['setupRequirements'],
      cleanupRequirements: map['cleanupRequirements'],
      equipmentNeeded: map['equipmentNeeded'],
    );
  }

  @override
  List<Object?> get props => [
    personCount, pricePerPerson, tableCount, staffCount,
    supervisorName, preparationTime, deliveryTime, serviceEndTime,
  ];
}

class FinancialDetails extends Equatable {
  final double pricePerPerson;
  final int personCount;
  final double subtotal;
  final double taxDiscountValue;
  final double discountPercentage;
  final double amountAfterDiscount;
  final double taxAmount;
  final double finalAmount;
  final String currency;

  const FinancialDetails({
    required this.pricePerPerson,
    required this.personCount,
    required this.subtotal,
    required this.taxDiscountValue,
    required this.discountPercentage,
    required this.amountAfterDiscount,
    required this.taxAmount,
    required this.finalAmount,
    this.currency = 'SAR',
  });

  Map<String, dynamic> toMap() {
    return {
      'pricePerPerson': pricePerPerson,
      'personCount': personCount,
      'subtotal': subtotal,
      'taxDiscountValue': taxDiscountValue,
      'discountPercentage': discountPercentage,
      'amountAfterDiscount': amountAfterDiscount,
      'taxAmount': taxAmount,
      'finalAmount': finalAmount,
      'currency': currency,
    };
  }

  factory FinancialDetails.fromMap(Map<String, dynamic> map) {
    return FinancialDetails(
      pricePerPerson: map['pricePerPerson']?.toDouble() ?? 0.0,
      personCount: map['personCount'] ?? 0,
      subtotal: map['subtotal']?.toDouble() ?? 0.0,
      taxDiscountValue: map['taxDiscountValue']?.toDouble() ?? 0.0,
      discountPercentage: map['discountPercentage']?.toDouble() ?? 0.0,
      amountAfterDiscount: map['amountAfterDiscount']?.toDouble() ?? 0.0,
      taxAmount: map['taxAmount']?.toDouble() ?? 0.0,
      finalAmount: map['finalAmount']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? 'SAR',
    );
  }

  @override
  List<Object?> get props => [
    pricePerPerson, personCount, subtotal, taxDiscountValue,
    discountPercentage, amountAfterDiscount, taxAmount, finalAmount, currency,
  ];
}

class PaymentDetails extends Equatable {
  final String? bankName;
  final String? accountNumber;
  final String? checkNumber;
  final DateTime? checkDate;
  final String? installmentPlan;
  final int? installmentCount;
  final double? installmentAmount;
  final String? notes;

  const PaymentDetails({
    this.bankName,
    this.accountNumber,
    this.checkNumber,
    this.checkDate,
    this.installmentPlan,
    this.installmentCount,
    this.installmentAmount,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'accountNumber': accountNumber,
      'checkNumber': checkNumber,
      'checkDate': checkDate?.toIso8601String(),
      'installmentPlan': installmentPlan,
      'installmentCount': installmentCount,
      'installmentAmount': installmentAmount,
      'notes': notes,
    };
  }

  factory PaymentDetails.fromMap(Map<String, dynamic> map) {
    return PaymentDetails(
      bankName: map['bankName'],
      accountNumber: map['accountNumber'],
      checkNumber: map['checkNumber'],
      checkDate: map['checkDate'] != null ? DateTime.parse(map['checkDate']) : null,
      installmentPlan: map['installmentPlan'],
      installmentCount: map['installmentCount'],
      installmentAmount: map['installmentAmount']?.toDouble(),
      notes: map['notes'],
    );
  }

  @override
  List<Object?> get props => [
    bankName, accountNumber, checkNumber, checkDate,
    installmentPlan, installmentCount, installmentAmount,
  ];
}

class EventEvaluation extends Equatable {
  final String serviceQuality;
  final String timeCompliance;
  final String customerSatisfaction;
  final String futureContractProbability;
  final String? notes;
  final DateTime? evaluatedAt;
  final String? evaluatedBy;

  const EventEvaluation({
    required this.serviceQuality,
    required this.timeCompliance,
    required this.customerSatisfaction,
    required this.futureContractProbability,
    this.notes,
    this.evaluatedAt,
    this.evaluatedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceQuality': serviceQuality,
      'timeCompliance': timeCompliance,
      'customerSatisfaction': customerSatisfaction,
      'futureContractProbability': futureContractProbability,
      'notes': notes,
      'evaluatedAt': evaluatedAt?.toIso8601String(),
      'evaluatedBy': evaluatedBy,
    };
  }

  factory EventEvaluation.fromMap(Map<String, dynamic> map) {
    return EventEvaluation(
      serviceQuality: map['serviceQuality'] ?? '',
      timeCompliance: map['timeCompliance'] ?? '',
      customerSatisfaction: map['customerSatisfaction'] ?? '',
      futureContractProbability: map['futureContractProbability'] ?? '',
      notes: map['notes'],
      evaluatedAt: map['evaluatedAt'] != null ? DateTime.parse(map['evaluatedAt']) : null,
      evaluatedBy: map['evaluatedBy'],
    );
  }

  @override
  List<Object?> get props => [
    serviceQuality, timeCompliance, customerSatisfaction,
    futureContractProbability, evaluatedAt, evaluatedBy,
  ];
}

class Approval extends Equatable {
  final String department;
  final String responsibleName;
  final String? position;
  final String? signatureUrl;
  final DateTime? approvedAt;
  final String status;

  const Approval({
    required this.department,
    required this.responsibleName,
    this.position,
    this.signatureUrl,
    this.approvedAt,
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'department': department,
      'responsibleName': responsibleName,
      'position': position,
      'signatureUrl': signatureUrl,
      'approvedAt': approvedAt?.toIso8601String(),
      'status': status,
    };
  }

  factory Approval.fromMap(Map<String, dynamic> map) {
    return Approval(
      department: map['department'] ?? '',
      responsibleName: map['responsibleName'] ?? '',
      position: map['position'],
      signatureUrl: map['signatureUrl'],
      approvedAt: map['approvedAt'] != null ? DateTime.parse(map['approvedAt']) : null,
      status: map['status'] ?? 'pending',
    );
  }

  @override
  List<Object?> get props => [department, responsibleName, status, approvedAt];
}
