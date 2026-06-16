import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String type;
  final String status;
  final String priority;
  final DateTime dueDate;
  final DateTime? startDate;
  final DateTime? completedDate;
  final String? organizationId;
  final String? organizationName;
  final String? contactId;
  final String? contactName;
  final String assignedTo;
  final String assignedToName;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final List<Reminder> reminders;
  final List<TaskComment> comments;
  final List<String> attachments;
  final String? relatedProposalId;
  final String? relatedContractId;
  final String? relatedVisitId;
  final String? relatedEventId;
  final String? location;
  final String? googleMapsUrl;
  final String? result;
  final String? nextAction;
  final bool isRecurring;
  final String? recurrencePattern;
  final bool isSynced;
  final DateTime? syncedAt;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.status = 'new',
    this.priority = 'normal',
    required this.dueDate,
    this.startDate,
    this.completedDate,
    this.organizationId,
    this.organizationName,
    this.contactId,
    this.contactName,
    required this.assignedTo,
    required this.assignedToName,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    this.reminders = const [],
    this.comments = const [],
    this.attachments = const [],
    this.relatedProposalId,
    this.relatedContractId,
    this.relatedVisitId,
    this.relatedEventId,
    this.location,
    this.googleMapsUrl,
    this.result,
    this.nextAction,
    this.isRecurring = false,
    this.recurrencePattern,
    this.isSynced = false,
    this.syncedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'status': status,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'startDate': startDate?.toIso8601String(),
      'completedDate': completedDate?.toIso8601String(),
      'organizationId': organizationId,
      'organizationName': organizationName,
      'contactId': contactId,
      'contactName': contactName,
      'assignedTo': assignedTo,
      'assignedToName': assignedToName,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'reminders': reminders.map((r) => r.toMap()).toList(),
      'comments': comments.map((c) => c.toMap()).toList(),
      'attachments': attachments,
      'relatedProposalId': relatedProposalId,
      'relatedContractId': relatedContractId,
      'relatedVisitId': relatedVisitId,
      'relatedEventId': relatedEventId,
      'location': location,
      'googleMapsUrl': googleMapsUrl,
      'result': result,
      'nextAction': nextAction,
      'isRecurring': isRecurring,
      'recurrencePattern': recurrencePattern,
      'isSynced': isSynced,
      'syncedAt': syncedAt?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      status: map['status'] ?? 'new',
      priority: map['priority'] ?? 'normal',
      dueDate: DateTime.parse(map['dueDate'] ?? DateTime.now().toIso8601String()),
      startDate: map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
      completedDate: map['completedDate'] != null ? DateTime.parse(map['completedDate']) : null,
      organizationId: map['organizationId'],
      organizationName: map['organizationName'],
      contactId: map['contactId'],
      contactName: map['contactName'],
      assignedTo: map['assignedTo'] ?? '',
      assignedToName: map['assignedToName'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      tags: List<String>.from(map['tags'] ?? []),
      reminders: (map['reminders'] as List?)?.map((r) => Reminder.fromMap(r)).toList() ?? [],
      comments: (map['comments'] as List?)?.map((c) => TaskComment.fromMap(c)).toList() ?? [],
      attachments: List<String>.from(map['attachments'] ?? []),
      relatedProposalId: map['relatedProposalId'],
      relatedContractId: map['relatedContractId'],
      relatedVisitId: map['relatedVisitId'],
      relatedEventId: map['relatedEventId'],
      location: map['location'],
      googleMapsUrl: map['googleMapsUrl'],
      result: map['result'],
      nextAction: map['nextAction'],
      isRecurring: map['isRecurring'] ?? false,
      recurrencePattern: map['recurrencePattern'],
      isSynced: map['isSynced'] ?? false,
      syncedAt: map['syncedAt'] != null ? DateTime.parse(map['syncedAt']) : null,
    );
  }

  @override
  List<Object?> get props => [id, title, status, priority, dueDate, assignedTo];
}

class Reminder extends Equatable {
  final String id;
  final DateTime reminderTime;
  final String type;
  final String? message;
  final bool isSent;
  final DateTime? sentAt;

  const Reminder({
    required this.id,
    required this.reminderTime,
    required this.type,
    this.message,
    this.isSent = false,
    this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reminderTime': reminderTime.toIso8601String(),
      'type': type,
      'message': message,
      'isSent': isSent,
      'sentAt': sentAt?.toIso8601String(),
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'] ?? '',
      reminderTime: DateTime.parse(map['reminderTime'] ?? DateTime.now().toIso8601String()),
      type: map['type'] ?? 'notification',
      message: map['message'],
      isSent: map['isSent'] ?? false,
      sentAt: map['sentAt'] != null ? DateTime.parse(map['sentAt']) : null,
    );
  }

  @override
  List<Object?> get props => [id, reminderTime, type, isSent];
}

class TaskComment extends Equatable {
  final String id;
  final String content;
  final String createdBy;
  final String createdByName;
  final DateTime createdAt;
  final List<String> attachments;
  final String? parentId;

  const TaskComment({
    required this.id,
    required this.content,
    required this.createdBy,
    required this.createdByName,
    required this.createdAt,
    this.attachments = const [],
    this.parentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'createdBy': createdBy,
      'createdByName': createdByName,
      'createdAt': createdAt.toIso8601String(),
      'attachments': attachments,
      'parentId': parentId,
    };
  }

  factory TaskComment.fromMap(Map<String, dynamic> map) {
    return TaskComment(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdByName: map['createdByName'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      attachments: List<String>.from(map['attachments'] ?? []),
      parentId: map['parentId'],
    );
  }

  @override
  List<Object?> get props => [id, content, createdBy, createdAt];
}
