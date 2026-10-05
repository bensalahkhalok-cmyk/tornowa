import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

const String baseUrl = 'http://localhost:3000/api';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  );

  // Add interceptor for auth token
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // TODO: Add token from storage
        return handler.next(options);
      },
      onError: (error, handler) {
        // TODO: Handle errors globally
        return handler.next(error);
      },
    ),
  );

  return dio;
});

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  // Auth endpoints
  Future<dynamic> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'password': password,
          'role': role,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // League endpoints
  Future<List<dynamic>> getLeagues() async {
    try {
      final response = await dio.get('/leagues');
      return response.data is List ? response.data : [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> createLeague({
    required String name,
    required int maxTeams,
  }) async {
    try {
      final response = await dio.post(
        '/leagues',
        data: {
          'name': name,
          'maxTeams': maxTeams,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Teams endpoints
  Future<List<dynamic>> getTeams() async {
    try {
      final response = await dio.get('/teams');
      return response.data is List ? response.data : [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> createTeam({
    required String leagueId,
    required String name,
    required String captainId,
  }) async {
    try {
      final response = await dio.post(
        '/teams',
        data: {
          'leagueId': leagueId,
          'name': name,
          'captainId': captainId,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Matches endpoints
  Future<List<dynamic>> getMatches() async {
    try {
      final response = await dio.get('/matches');
      return response.data is List ? response.data : [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> createMatch({
    required String leagueId,
    required String homeTeamId,
    required String awayTeamId,
    required String scheduledAt,
  }) async {
    try {
      final response = await dio.post(
        '/matches',
        data: {
          'leagueId': leagueId,
          'homeTeamId': homeTeamId,
          'awayTeamId': awayTeamId,
          'scheduledAt': scheduledAt,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message'] ?? 'An error occurred';
    }
    return e.message ?? 'An error occurred';
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});
