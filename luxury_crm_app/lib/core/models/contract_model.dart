import 'package:equatable/equatable.dart';

class Contract extends Equatable {
  final String id;
  final String contractNumber;
  final String type;
  final String organizationId;
  final String organizationName;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? renewalDate;
  final bool autoRenewal;
  final double value;
  final String currency;
  final String paymentTerms;
  final List<ContractItem> items;
  final List<ContractAlert> alerts;
  final String status;
  final String? pdfUrl;
  final String? signedPdfUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> attachments;
  final String? notes;
  final String? terminationReason;
  final DateTime? terminatedAt;
  final List<ContractHistory> history;
  final bool isSynced;

  const Contract({
    required this.id,
    required this.contractNumber,
    required this.type,
    required this.organizationId,
    required this.organizationName,
    required this.startDate,
    required this.endDate,
    this.renewalDate,
    this.autoRenewal = false,
    required this.value,
    this.currency = 'SAR',
    required this.paymentTerms,
    this.items = const [],
    this.alerts = const [],
    this.status = 'active',
    this.pdfUrl,
    this.signedPdfUrl,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.attachments = const [],
    this.notes,
    this.terminationReason,
    this.terminatedAt,
    this.history = const [],
    this.isSynced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contractNumber': contractNumber,
      'type': type,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'renewalDate': renewalDate?.toIso8601String(),
      'autoRenewal': autoRenewal,
      'value': value,
      'currency': currency,
      'paymentTerms': paymentTerms,
      'items': items.map((i) => i.toMap()).toList(),
      'alerts': alerts.map((a) => a.toMap()).toList(),
      'status': status,
      'pdfUrl': pdfUrl,
      'signedPdfUrl': signedPdfUrl,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'attachments': attachments,
      'notes': notes,
      'terminationReason': terminationReason,
      'terminatedAt': terminatedAt?.toIso8601String(),
      'history': history.map((h) => h.toMap()).toList(),
      'isSynced': isSynced,
    };
  }

  factory Contract.fromMap(Map<String, dynamic> map) {
    return Contract(
      id: map['id'] ?? '',
      contractNumber: map['contractNumber'] ?? '',
      type: map['type'] ?? '',
      organizationId: map['organizationId'] ?? '',
      organizationName: map['organizationName'] ?? '',
      startDate: DateTime.parse(map['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(map['endDate'] ?? DateTime.now().toIso8601String()),
      renewalDate: map['renewalDate'] != null ? DateTime.parse(map['renewalDate']) : null,
      autoRenewal: map['autoRenewal'] ?? false,
      value: map['value']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? 'SAR',
      paymentTerms: map['paymentTerms'] ?? '',
      items: (map['items'] as List?)?.map((i) => ContractItem.fromMap(i)).toList() ?? [],
      alerts: (map['alerts'] as List?)?.map((a) => ContractAlert.fromMap(a)).toList() ?? [],
      status: map['status'] ?? 'active',
      pdfUrl: map['pdfUrl'],
      signedPdfUrl: map['signedPdfUrl'],
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      attachments: List<String>.from(map['attachments'] ?? []),
      notes: map['notes'],
      terminationReason: map['terminationReason'],
      terminatedAt: map['terminatedAt'] != null ? DateTime.parse(map['terminatedAt']) : null,
      history: (map['history'] as List?)?.map((h) => ContractHistory.fromMap(h)).toList() ?? [],
      isSynced: map['isSynced'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, contractNumber, type, status, organizationId, endDate];
}

class ContractItem extends Equatable {
  final String id;
  final String serviceType;
  final String description;
  final double unitPrice;
  final int quantity;
  final double frequency;
  final double total;
  final String? notes;

  const ContractItem({
    required this.id,
    required this.serviceType,
    required this.description,
    required this.unitPrice,
    required this.quantity,
    required this.frequency,
    required this.total,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceType': serviceType,
      'description': description,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'frequency': frequency,
      'total': total,
      'notes': notes,
    };
  }

  factory ContractItem.fromMap(Map<String, dynamic> map) {
    return ContractItem(
      id: map['id'] ?? '',
      serviceType: map['serviceType'] ?? '',
      description: map['description'] ?? '',
      unitPrice: map['unitPrice']?.toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 1,
      frequency: map['frequency']?.toDouble() ?? 1.0,
      total: map['total']?.toDouble() ?? 0.0,
      notes: map['notes'],
    );
  }

  @override
  List<Object?> get props => [id, serviceType, unitPrice, quantity, total];
}

class ContractAlert extends Equatable {
  final String id;
  final String type;
  final String message;
  final DateTime triggerDate;
  final bool isTriggered;
  final DateTime? triggeredAt;
  final String? actionTaken;
  final bool isResolved;

  const ContractAlert({
    required this.id,
    required this.type,
    required this.message,
    required this.triggerDate,
    this.isTriggered = false,
    this.triggeredAt,
    this.actionTaken,
    this.isResolved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'message': message,
      'triggerDate': triggerDate.toIso8601String(),
      'isTriggered': isTriggered,
      'triggeredAt': triggeredAt?.toIso8601String(),
      'actionTaken': actionTaken,
      'isResolved': isResolved,
    };
  }

  factory ContractAlert.fromMap(Map<String, dynamic> map) {
    return ContractAlert(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      message: map['message'] ?? '',
      triggerDate: DateTime.parse(map['triggerDate'] ?? DateTime.now().toIso8601String()),
      isTriggered: map['isTriggered'] ?? false,
      triggeredAt: map['triggeredAt'] != null ? DateTime.parse(map['triggeredAt']) : null,
      actionTaken: map['actionTaken'],
      isResolved: map['isResolved'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, type, triggerDate, isTriggered, isResolved];
}

class ContractHistory extends Equatable {
  final String id;
  final String action;
  final String performedBy;
  final DateTime performedAt;
  final String? details;
  final String? oldValue;
  final String? newValue;

  const ContractHistory({
    required this.id,
    required this.action,
    required this.performedBy,
    required this.performedAt,
    this.details,
    this.oldValue,
    this.newValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
      'performedBy': performedBy,
      'performedAt': performedAt.toIso8601String(),
      'details': details,
      'oldValue': oldValue,
      'newValue': newValue,
    };
  }

  factory ContractHistory.fromMap(Map<String, dynamic> map) {
    return ContractHistory(
      id: map['id'] ?? '',
      action: map['action'] ?? '',
      performedBy: map['performedBy'] ?? '',
      performedAt: DateTime.parse(map['performedAt'] ?? DateTime.now().toIso8601String()),
      details: map['details'],
      oldValue: map['oldValue'],
      newValue: map['newValue'],
    );
  }

  @override
  List<Object?> get props => [id, action, performedBy, performedAt];
}
