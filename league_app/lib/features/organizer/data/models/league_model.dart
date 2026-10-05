class LeagueModel {
  final String id;
  final String organizerId;
  final String name;
  final String? description;
  final int maxTeams;
  final String status; // DRAFT, ACTIVE, PAUSED, COMPLETED
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime createdAt;

  LeagueModel({
    required this.id,
    required this.organizerId,
    required this.name,
    this.description,
    required this.maxTeams,
    required this.status,
    this.startDate,
    this.endDate,
    required this.createdAt,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      id: json['id'] ?? '',
      organizerId: json['organizerId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      maxTeams: json['maxTeams'] ?? 8,
      status: json['status'] ?? 'DRAFT',
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizerId': organizerId,
      'name': name,
      'description': description,
      'maxTeams': maxTeams,
      'status': status,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
