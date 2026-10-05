import { Injectable, NotFoundException } from '@nestjs/common';

@Injectable()
export class MatchesService {
  private readonly matches = new Map<string, any>();

  createMatch(dto: {
    leagueId: string;
    homeTeamId: string;
    awayTeamId: string;
    venueId?: string;
    scheduledAt: string;
  }) {
    const match = {
      id: `match_${Date.now()}`,
      leagueId: dto.leagueId,
      homeTeamId: dto.homeTeamId,
      awayTeamId: dto.awayTeamId,
      venueId: dto.venueId ?? null,
      scheduledAt: new Date(dto.scheduledAt),
      status: 'SCHEDULED',
      score: { home: 0, away: 0 },
    };

    this.matches.set(match.id, match);

    return {
      success: true,
      match,
    };
  }

  getAll() {
    return [...this.matches.values()];
  }

  getMatch(id: string) {
    const match = this.matches.get(id);
    if (!match) {
      throw new NotFoundException('Match not found');
    }
    return match;
  }

  updateResult(id: string, dto: { homeScore: number; awayScore: number }) {
    const match = this.matches.get(id);
    if (!match) {
      throw new NotFoundException('Match not found');
    }

    match.score = {
      home: dto.homeScore,
      away: dto.awayScore,
    };
    match.status = 'FINISHED';

    return {
      success: true,
      match,
    };
  }
}
