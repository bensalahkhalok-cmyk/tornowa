import { IsEnum, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export enum InviteKind {
  CAPTAIN = 'CAPTAIN',
  PLAYER = 'PLAYER',
}

export class CreateInviteDto {
  @IsString()
  @IsNotEmpty()
  leagueId: string;

  @IsString()
  @IsNotEmpty()
  createdBy: string;

  @IsEnum(InviteKind)
  inviteType: InviteKind;

  @IsOptional()
  @IsString()
  teamId?: string;
}
