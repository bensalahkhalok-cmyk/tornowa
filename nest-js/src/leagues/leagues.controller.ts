import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { CreateInviteDto } from './dto/create-invite.dto';
import { CreateLeagueDto } from './dto/create-league.dto';
import { LeaguesService } from './leagues.service';

@Controller('leagues')
export class LeaguesController {
  constructor(private readonly leaguesService: LeaguesService) {}

  @Post()
  createLeague(@Body() dto: CreateLeagueDto) {
    return this.leaguesService.createLeague(dto);
  }

  @Get()
  getAll() {
    return this.leaguesService.getAll();
  }

  @Get(':id')
  getLeague(@Param('id') id: string) {
    return this.leaguesService.getLeague(id);
  }

  @Post(':id/invites')
  createInvite(@Param('id') leagueId: string, @Body() dto: Omit<CreateInviteDto, 'leagueId'>) {
    return this.leaguesService.createInvite({ leagueId, ...dto });
  }
}
