export enum UserRole {
  SUPER_ADMIN = 'SUPER_ADMIN',
  CAPTAIN = 'CAPTAIN',
  PLAYER = 'PLAYER',
}

export enum InviteType {
  CAPTAIN = 'CAPTAIN',
  PLAYER = 'PLAYER',
}

export type LeagueStatus = 'DRAFT' | 'ACTIVE' | 'PAUSED' | 'COMPLETED';
export type MatchStatus = 'SCHEDULED' | 'IN_PROGRESS' | 'FINISHED' | 'CANCELLED';
