import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { AddPlayerDto } from './dto/add-player.dto';
import { CreateTeamDto } from './dto/create-team.dto';
import { TeamsService } from './teams.service';

@Controller('teams')
export class TeamsController {
  constructor(private readonly teamsService: TeamsService) {}

  @Post()
  createTeam(@Body() dto: CreateTeamDto) {
    return this.teamsService.createTeam(dto);
  }

  @Get()
  getAll() {
    return this.teamsService.getAll();
  }

  @Get(':id')
  getTeam(@Param('id') id: string) {
    return this.teamsService.getTeam(id);
  }

  @Post(':id/players')
  addPlayer(@Param('id') id: string, @Body() dto: AddPlayerDto) {
    return this.teamsService.addPlayer(id, dto);
  }
}
