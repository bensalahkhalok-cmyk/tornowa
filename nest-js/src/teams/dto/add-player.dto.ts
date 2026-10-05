import { IsNumber, IsOptional, IsString } from 'class-validator';

export class AddPlayerDto {
  @IsString()
  userId: string;

  @IsOptional()
  @IsNumber()
  jerseyNumber?: number;

  @IsOptional()
  @IsString()
  position?: string;
}
