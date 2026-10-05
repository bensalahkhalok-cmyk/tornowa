import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return JSON.stringify({
      app: 'League Mini Football Management API',
      version: '1.0.0',
      modules: ['auth', 'leagues', 'teams', 'matches'],
      status: 'running',
    }, null, 2);
  }
}
