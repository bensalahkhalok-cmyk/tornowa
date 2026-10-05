import { IsNotEmpty, IsString } from 'class-validator';

export class VerifyInviteDto {
  @IsString()
  @IsNotEmpty()
  code: string;

  @IsString()
  @IsNotEmpty()
  userId: string;
}
