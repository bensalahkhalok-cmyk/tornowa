import { IsInt, IsNotEmpty, Min } from 'class-validator';

export class UpdateResultDto {
  @IsInt()
  @Min(0)
  @IsNotEmpty()
  homeScore: number;

  @IsInt()
  @Min(0)
  @IsNotEmpty()
  awayScore: number;
}
