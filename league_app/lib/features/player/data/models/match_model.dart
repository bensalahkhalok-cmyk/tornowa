class MatchModel {
  final String id;
  final String leagueId;
  final String homeTeamId;
  final String awayTeamId;
  final String? venueId;
  final DateTime scheduledAt;
  final String status;
  final int homeScore;
  final int awayScore;
  final DateTime createdAt;

  MatchModel({
    required this.id,
    required this.leagueId,
    required this.homeTeamId,
    required this.awayTeamId,
    this.venueId,
    required this.scheduledAt,
    required this.status,
    required this.homeScore,
    required this.awayScore,
    required this.createdAt,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] ?? '',
      leagueId: json['leagueId'] ?? '',
      homeTeamId: json['homeTeamId'] ?? '',
      awayTeamId: json['awayTeamId'] ?? '',
      venueId: json['venueId'],
      scheduledAt: DateTime.parse(json['scheduledAt'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'SCHEDULED',
      homeScore: json['score']?['home'] ?? 0,
      awayScore: json['score']?['away'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leagueId': leagueId,
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'venueId': venueId,
      'scheduledAt': scheduledAt.toIso8601String(),
      'status': status,
      'score': {'home': homeScore, 'away': awayScore},
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
