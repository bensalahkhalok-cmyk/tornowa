import { UserRole } from '../enums/roles.enum';

export type UserRecord = {
  id: string;
  fullName: string;
  email: string;
  phone: string;
  passwordHash: string;
  role: UserRole;
  teamId?: string;
  leagueId?: string;
  createdAt: Date;
};

export type InviteRecord = {
  id: string;
  code: string;
  leagueId: string;
  inviteType: 'CAPTAIN' | 'PLAYER';
  createdBy: string;
  teamId?: string;
  usedBy?: string;
  expiresAt?: Date;
  active: boolean;
};

export type TeamRecord = {
  id: string;
  name: string;
  leagueId: string;
  captainId: string;
  playerIds: string[];
  createdAt: Date;
};

export type LeagueRecord = {
  id: string;
  organizerId: string;
  name: string;
  maxTeams: number;
  status: 'DRAFT' | 'ACTIVE' | 'PAUSED' | 'COMPLETED';
  teams: string[];
  createdAt: Date;
};

export type MatchRecord = {
  id: string;
  leagueId: string;
  homeTeamId: string;
  awayTeamId: string;
  scheduledAt: Date;
  status: 'SCHEDULED' | 'IN_PROGRESS' | 'FINISHED' | 'CANCELLED';
  score: {
    home: number;
    away: number;
  };
};
