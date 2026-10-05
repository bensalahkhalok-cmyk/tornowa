import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcryptjs';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserRole } from 'src/common/enums/roles.enum';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async register(dto: {
    fullName: string;
    email: string;
    phone: string;
    password: string;
    role?: 'SUPER_ADMIN' | 'CAPTAIN' | 'PLAYER';
  }) {
    const existing = await this.prisma.user.findUnique({
      where: { email: dto.email },
    });

    if (existing) {
      throw new UnauthorizedException('Email already registered');
    }

    const hashedPassword = await bcrypt.hash(dto.password, 10);

    const user = await this.prisma.user.create({
      data: {
        fullName: dto.fullName,
        email: dto.email,
        phone: dto.phone,
        passwordHash: hashedPassword,
        role: dto.role ? (dto.role as UserRole) : UserRole.PLAYER,
      },
    });

    const token = this.jwtService.sign({
      sub: user.id,
      email: user.email,
      role: user.role,
    });

    return {
      success: true,
      message: 'User registered successfully',
      accessToken: token,
      user: {
        id: user.id,
        fullName: user.fullName,
        email: user.email,
        phone: user.phone,
        role: user.role,
      },
    };
  }

  async login(dto: { email: string; password: string }) {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email },
    });

    if (!user) {
      throw new UnauthorizedException('Invalid email or password');
    }

    const isValidPassword = await bcrypt.compare(dto.password, user.passwordHash);

    if (!isValidPassword) {
      throw new UnauthorizedException('Invalid email or password');
    }

    const token = this.jwtService.sign({
      sub: user.id,
      email: user.email,
      role: user.role,
    });

    return {
      success: true,
      message: 'Login successful',
      accessToken: token,
      user: {
        id: user.id,
        fullName: user.fullName,
        email: user.email,
        role: user.role,
      },
    };
  }

  async verifyInvite(dto: { code: string; userId: string }) {
    const invite = await this.prisma.leagueInvite.findUnique({
      where: { code: dto.code },
    });

    if (!invite) {
      throw new UnauthorizedException('Invite code is invalid');
    }

    if (invite.usedBy && invite.usedBy !== dto.userId) {
      throw new UnauthorizedException('Invite code already used');
    }

    const updatedInvite = await this.prisma.leagueInvite.update({
      where: { id: invite.id },
      data: {
        usedBy: dto.userId,
        status: 'USED',
      },
    });

    return {
      success: true,
      invite: updatedInvite,
      message: 'Invite verified successfully',
    };
  }

  async createInvite(invite: any) {
    return this.prisma.leagueInvite.create({
      data: {
        code: invite.code,
        leagueId: invite.leagueId,
        createdBy: invite.createdBy,
        inviteType: invite.inviteType,
        teamId: invite.teamId,
        expiresAt: invite.expiresAt,
        status: 'ACTIVE',
      },
    });
  }
}
