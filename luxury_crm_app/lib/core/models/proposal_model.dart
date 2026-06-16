import 'package:equatable/equatable.dart';

class Proposal extends Equatable {
  final String id;
  final String number;
  final String organizationId;
  final String organizationName;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String? expiryTime;
  final List<ProposalItem> items;
  final PricingSummary pricing;
  final ApprovalWorkflow approvalWorkflow;
  final String status;
  final String? pdfUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> ccEmails;
  final String? notes;
  final String? termsAndConditions;
  final bool isTemplate;
  final String? templateName;
  final List<ProposalHistory> history;

  const Proposal({
    required this.id,
    required this.number,
    required this.organizationId,
    required this.organizationName,
    required this.issueDate,
    required this.expiryDate,
    this.expiryTime,
    this.items = const [],
    required this.pricing,
    required this.approvalWorkflow,
    this.status = 'draft',
    this.pdfUrl,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.ccEmails = const [],
    this.notes,
    this.termsAndConditions,
    this.isTemplate = false,
    this.templateName,
    this.history = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'issueDate': issueDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'expiryTime': expiryTime,
      'items': items.map((i) => i.toMap()).toList(),
      'pricing': pricing.toMap(),
      'approvalWorkflow': approvalWorkflow.toMap(),
      'status': status,
      'pdfUrl': pdfUrl,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'ccEmails': ccEmails,
      'notes': notes,
      'termsAndConditions': termsAndConditions,
      'isTemplate': isTemplate,
      'templateName': templateName,
      'history': history.map((h) => h.toMap()).toList(),
    };
  }

  factory Proposal.fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'] ?? '',
      number: map['number'] ?? '',
      organizationId: map['organizationId'] ?? '',
      organizationName: map['organizationName'] ?? '',
      issueDate: DateTime.parse(map['issueDate'] ?? DateTime.now().toIso8601String()),
      expiryDate: DateTime.parse(map['expiryDate'] ?? DateTime.now().toIso8601String()),
      expiryTime: map['expiryTime'],
      items: (map['items'] as List?)?.map((i) => ProposalItem.fromMap(i)).toList() ?? [],
      pricing: PricingSummary.fromMap(map['pricing'] ?? {}),
      approvalWorkflow: ApprovalWorkflow.fromMap(map['approvalWorkflow'] ?? {}),
      status: map['status'] ?? 'draft',
      pdfUrl: map['pdfUrl'],
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      ccEmails: List<String>.from(map['ccEmails'] ?? []),
      notes: map['notes'],
      termsAndConditions: map['termsAndConditions'],
      isTemplate: map['isTemplate'] ?? false,
      templateName: map['templateName'],
      history: (map['history'] as List?)?.map((h) => ProposalHistory.fromMap(h)).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [id, number, status, organizationId];
}

class ProposalItem extends Equatable {
  final String id;
  final String serviceType;
  final String description;
  final String details;
  final double unitPrice;
  final int quantity;
  final double discount;
  final double taxRate;
  final double subtotal;
  final double total;
  final String? notes;

  const ProposalItem({
    required this.id,
    required this.serviceType,
    required this.description,
    required this.details,
    required this.unitPrice,
    required this.quantity,
    this.discount = 0,
    this.taxRate = 0.15,
    required this.subtotal,
    required this.total,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceType': serviceType,
      'description': description,
      'details': details,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'discount': discount,
      'taxRate': taxRate,
      'subtotal': subtotal,
      'total': total,
      'notes': notes,
    };
  }

  factory ProposalItem.fromMap(Map<String, dynamic> map) {
    return ProposalItem(
      id: map['id'] ?? '',
      serviceType: map['serviceType'] ?? '',
      description: map['description'] ?? '',
      details: map['details'] ?? '',
      unitPrice: map['unitPrice']?.toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 1,
      discount: map['discount']?.toDouble() ?? 0.0,
      taxRate: map['taxRate']?.toDouble() ?? 0.15,
      subtotal: map['subtotal']?.toDouble() ?? 0.0,
      total: map['total']?.toDouble() ?? 0.0,
      notes: map['notes'],
    );
  }

  @override
  List<Object?> get props => [id, serviceType, unitPrice, quantity, total];
}

class PricingSummary extends Equatable {
  final double subtotal;
  final double totalDiscount;
  final double taxableAmount;
  final double taxAmount;
  final double total;
  final String currency;

  const PricingSummary({
    required this.subtotal,
    required this.totalDiscount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.total,
    this.currency = 'SAR',
  });

  Map<String, dynamic> toMap() {
    return {
      'subtotal': subtotal,
      'totalDiscount': totalDiscount,
      'taxableAmount': taxableAmount,
      'taxAmount': taxAmount,
      'total': total,
      'currency': currency,
    };
  }

  factory PricingSummary.fromMap(Map<String, dynamic> map) {
    return PricingSummary(
      subtotal: map['subtotal']?.toDouble() ?? 0.0,
      totalDiscount: map['totalDiscount']?.toDouble() ?? 0.0,
      taxableAmount: map['taxableAmount']?.toDouble() ?? 0.0,
      taxAmount: map['taxAmount']?.toDouble() ?? 0.0,
      total: map['total']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? 'SAR',
    );
  }

  @override
  List<Object?> get props => [subtotal, totalDiscount, taxAmount, total, currency];
}

class ApprovalWorkflow extends Equatable {
  final List<ApprovalStep> steps;
  final bool isComplete;
  final String? currentStepId;
  final DateTime? completedAt;

  const ApprovalWorkflow({
    this.steps = const [],
    this.isComplete = false,
    this.currentStepId,
    this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'steps': steps.map((s) => s.toMap()).toList(),
      'isComplete': isComplete,
      'currentStepId': currentStepId,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory ApprovalWorkflow.fromMap(Map<String, dynamic> map) {
    return ApprovalWorkflow(
      steps: (map['steps'] as List?)?.map((s) => ApprovalStep.fromMap(s)).toList() ?? [],
      isComplete: map['isComplete'] ?? false,
      currentStepId: map['currentStepId'],
      completedAt: map['completedAt'] != null ? DateTime.parse(map['completedAt']) : null,
    );
  }

  @override
  List<Object?> get props => [steps, isComplete, currentStepId];
}

class ApprovalStep extends Equatable {
  final String id;
  final String role;
  final String roleDisplayName;
  final String? approverId;
  final String? approverName;
  final String status;
  final DateTime? approvedAt;
  final String? notes;
  final int order;
  final bool isRequired;

  const ApprovalStep({
    required this.id,
    required this.role,
    required this.roleDisplayName,
    this.approverId,
    this.approverName,
    this.status = 'pending',
    this.approvedAt,
    this.notes,
    required this.order,
    this.isRequired = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'roleDisplayName': roleDisplayName,
      'approverId': approverId,
      'approverName': approverName,
      'status': status,
      'approvedAt': approvedAt?.toIso8601String(),
      'notes': notes,
      'order': order,
      'isRequired': isRequired,
    };
  }

  factory ApprovalStep.fromMap(Map<String, dynamic> map) {
    return ApprovalStep(
      id: map['id'] ?? '',
      role: map['role'] ?? '',
      roleDisplayName: map['roleDisplayName'] ?? '',
      approverId: map['approverId'],
      approverName: map['approverName'],
      status: map['status'] ?? 'pending',
      approvedAt: map['approvedAt'] != null ? DateTime.parse(map['approvedAt']) : null,
      notes: map['notes'],
      order: map['order'] ?? 0,
      isRequired: map['isRequired'] ?? true,
    );
  }

  @override
  List<Object?> get props => [id, role, status, order, approverId];
}

class ProposalHistory extends Equatable {
  final String id;
  final String action;
  final String performedBy;
  final DateTime performedAt;
  final String? details;
  final String? oldValue;
  final String? newValue;

  const ProposalHistory({
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

  factory ProposalHistory.fromMap(Map<String, dynamic> map) {
    return ProposalHistory(
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
