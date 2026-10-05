import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { CreateMatchDto } from './dto/create-match.dto';
import { UpdateResultDto } from './dto/update-result.dto';
import { MatchesService } from './matches.service';

@Controller('matches')
export class MatchesController {
  constructor(private readonly matchesService: MatchesService) {}

  @Post()
  createMatch(@Body() dto: CreateMatchDto) {
    return this.matchesService.createMatch(dto);
  }

  @Get()
  getAll() {
    return this.matchesService.getAll();
  }

  @Get(':id')
  getMatch(@Param('id') id: string) {
    return this.matchesService.getMatch(id);
  }

  @Post(':id/result')
  updateResult(@Param('id') id: string, @Body() dto: UpdateResultDto) {
    return this.matchesService.updateResult(id, dto);
  }
}
