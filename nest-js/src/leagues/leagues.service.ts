import { Injectable, NotFoundException } from '@nestjs/common';
import { AuthService } from 'src/auth/auth.service';

@Injectable()
export class LeaguesService {
  private readonly leagues = new Map<string, any>();

  constructor(private readonly authService: AuthService) {}

  createLeague(dto: { organizerId: string; name: string; maxTeams?: number }) {
    const league = {
      id: `league_${Date.now()}`,
      organizerId: dto.organizerId,
      name: dto.name,
      maxTeams: dto.maxTeams ?? 8,
      status: 'DRAFT',
      createdAt: new Date(),
      teams: [],
    };

    this.leagues.set(league.id, league);

    return {
      success: true,
      league,
    };
  }

  getAll() {
    return [...this.leagues.values()];
  }

  getLeague(id: string) {
    const league = this.leagues.get(id);
    if (!league) {
      throw new NotFoundException('League not found');
    }
    return league;
  }

  createInvite(dto: {
    leagueId: string;
    createdBy: string;
    inviteType: 'CAPTAIN' | 'PLAYER';
    teamId?: string;
  }) {
    const league = this.leagues.get(dto.leagueId);
    if (!league) {
      throw new NotFoundException('League not found');
    }

    const invite = {
      id: `invite_${Date.now()}`,
      code: `${dto.inviteType.toLowerCase()}_${Math.random().toString(36).slice(2, 9).toUpperCase()}`,
      leagueId: dto.leagueId,
      inviteType: dto.inviteType,
      createdBy: dto.createdBy,
      teamId: dto.teamId,
      usedBy: null,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 7),
      active: true,
    };

    this.authService.createInvite(invite);

    return {
      success: true,
      invite,
      message: 'Invite code generated successfully',
    };
  }
}
