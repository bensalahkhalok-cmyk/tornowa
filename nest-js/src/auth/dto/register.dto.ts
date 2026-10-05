import { IsEmail, IsEnum, IsNotEmpty, IsOptional, IsPhoneNumber, MinLength } from 'class-validator';
import { UserRole } from 'src/common/enums/roles.enum';

export class RegisterDto {
  @IsNotEmpty()
  fullName: string;

  @IsEmail()
  email: string;

  @IsPhoneNumber('SA')
  phone: string;

  @IsNotEmpty()
  @MinLength(6)
  password: string;

  @IsOptional()
  @IsEnum(UserRole)
  role?: UserRole;
}
