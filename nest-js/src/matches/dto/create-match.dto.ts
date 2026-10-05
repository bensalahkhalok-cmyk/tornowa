import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class CreateMatchDto {
  @IsString()
  @IsNotEmpty()
  leagueId: string;

  @IsString()
  @IsNotEmpty()
  homeTeamId: string;

  @IsString()
  @IsNotEmpty()
  awayTeamId: string;

  @IsOptional()
  @IsString()
  venueId?: string;

  @IsString()
  @IsNotEmpty()
  scheduledAt: string;
}
