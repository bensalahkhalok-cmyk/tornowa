class TeamModel {
  final String id;
  final String leagueId;
  final String name;
  final String? logoUrl;
  final String? primaryColor;
  final String? secondaryColor;
  final String captainId;
  final String status;
  final DateTime createdAt;

  TeamModel({
    required this.id,
    required this.leagueId,
    required this.name,
    this.logoUrl,
    this.primaryColor,
    this.secondaryColor,
    required this.captainId,
    required this.status,
    required this.createdAt,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? '',
      leagueId: json['leagueId'] ?? '',
      name: json['name'] ?? '',
      logoUrl: json['logoUrl'],
      primaryColor: json['primaryColor'],
      secondaryColor: json['secondaryColor'],
      captainId: json['captainId'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leagueId': leagueId,
      'name': name,
      'logoUrl': logoUrl,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'captainId': captainId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
