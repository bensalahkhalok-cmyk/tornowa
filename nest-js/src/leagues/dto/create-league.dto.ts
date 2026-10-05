import { IsNotEmpty, IsOptional, IsString, Min } from 'class-validator';

export class CreateLeagueDto {
  @IsString()
  @IsNotEmpty()
  organizerId: string;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsOptional()
  @Min(2)
  maxTeams?: number;
}
