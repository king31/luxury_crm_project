import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String role;
  final String department;
  final String? avatarUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final List<String> permissions;
  final List<String> assignedOrganizations;
  final Map<String, dynamic> preferences;
  final String? signatureUrl;
  final String? deviceToken;
  final bool twoFactorEnabled;
  final String? googleId;
  final String? microsoftId;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.department,
    this.avatarUrl,
    this.isActive = true,
    required this.createdAt,
    this.lastLogin,
    this.permissions = const [],
    this.assignedOrganizations = const [],
    this.preferences = const {},
    this.signatureUrl,
    this.deviceToken,
    this.twoFactorEnabled = false,
    this.googleId,
    this.microsoftId,
  });

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? role,
    String? department,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLogin,
    List<String>? permissions,
    List<String>? assignedOrganizations,
    Map<String, dynamic>? preferences,
    String? signatureUrl,
    String? deviceToken,
    bool? twoFactorEnabled,
    String? googleId,
    String? microsoftId,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      department: department ?? this.department,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      permissions: permissions ?? this.permissions,
      assignedOrganizations: assignedOrganizations ?? this.assignedOrganizations,
      preferences: preferences ?? this.preferences,
      signatureUrl: signatureUrl ?? this.signatureUrl,
      deviceToken: deviceToken ?? this.deviceToken,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      googleId: googleId ?? this.googleId,
      microsoftId: microsoftId ?? this.microsoftId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'role': role,
      'department': department,
      'avatarUrl': avatarUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'permissions': permissions,
      'assignedOrganizations': assignedOrganizations,
      'preferences': preferences,
      'signatureUrl': signatureUrl,
      'deviceToken': deviceToken,
      'twoFactorEnabled': twoFactorEnabled,
      'googleId': googleId,
      'microsoftId': microsoftId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      department: map['department'] ?? '',
      avatarUrl: map['avatarUrl'],
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLogin: map['lastLogin'] != null ? DateTime.parse(map['lastLogin']) : null,
      permissions: List<String>.from(map['permissions'] ?? []),
      assignedOrganizations: List<String>.from(map['assignedOrganizations'] ?? []),
      preferences: Map<String, dynamic>.from(map['preferences'] ?? {}),
      signatureUrl: map['signatureUrl'],
      deviceToken: map['deviceToken'],
      twoFactorEnabled: map['twoFactorEnabled'] ?? false,
      googleId: map['googleId'],
      microsoftId: map['microsoftId'],
    );
  }

  @override
  List<Object?> get props => [
    id, email, fullName, phone, role, department, 
    avatarUrl, isActive, createdAt, lastLogin, 
    permissions, assignedOrganizations, preferences,
    signatureUrl, deviceToken, twoFactorEnabled,
    googleId, microsoftId,
  ];
}

class Role extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final String description;
  final List<String> permissions;
  final int level;
  final bool isSystem;
  final DateTime createdAt;

  const Role({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
    required this.permissions,
    required this.level,
    this.isSystem = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'description': description,
      'permissions': permissions,
      'level': level,
      'isSystem': isSystem,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      displayName: map['displayName'] ?? '',
      description: map['description'] ?? '',
      permissions: List<String>.from(map['permissions'] ?? []),
      level: map['level'] ?? 0,
      isSystem: map['isSystem'] ?? false,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object?> get props => [id, name, displayName, permissions, level];
}

class Permission extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final String module;
  final String action;
  final String description;

  const Permission({
    required this.id,
    required this.name,
    required this.displayName,
    required this.module,
    required this.action,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, module, action];
}
