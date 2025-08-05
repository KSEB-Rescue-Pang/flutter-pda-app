/// API 설정 상수
class ApiConfig {
  /// API 기본 URL
  /// TODO: 실제 서버 URL로 변경 필요
  static const String baseUrl = 'http://localhost:3000';

  /// API 타임아웃 (초)
  static const int timeoutSeconds = 30;

  /// 작업자 등록 엔드포인트
  static const String workerLoginEndpoint = '/{work_type}/{worker_id}/login';
}
