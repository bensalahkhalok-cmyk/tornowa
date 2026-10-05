import { Injectable, NotFoundException } from '@nestjs/common';

@Injectable()
export class TeamsService {
  private readonly teams = new Map<string, any>();

  createTeam(dto: {
    leagueId: string;
    name: string;
    captainId: string;
    primaryColor?: string;
    secondaryColor?: string;
  }) {
    const team = {
      id: `team_${Date.now()}`,
      leagueId: dto.leagueId,
      name: dto.name,
      captainId: dto.captainId,
      primaryColor: dto.primaryColor ?? '#000000',
      secondaryColor: dto.secondaryColor ?? '#ffffff',
      playerIds: [],
      createdAt: new Date(),
    };

    this.teams.set(team.id, team);

    return {
      success: true,
      team,
    };
  }

  getAll() {
    return [...this.teams.values()];
  }

  getTeam(id: string) {
    const team = this.teams.get(id);
    if (!team) {
      throw new NotFoundException('Team not found');
    }
    return team;
  }

  addPlayer(teamId: string, dto: { userId: string; jerseyNumber?: number; position?: string }) {
    const team = this.teams.get(teamId);
    if (!team) {
      throw new NotFoundException('Team not found');
    }

    const membership = {
      userId: dto.userId,
      jerseyNumber: dto.jerseyNumber ?? 0,
      position: dto.position ?? 'Unknown',
      joinedAt: new Date(),
    };

    team.playerIds.push(dto.userId);

    return {
      success: true,
      membership,
      team,
    };
  }
}
