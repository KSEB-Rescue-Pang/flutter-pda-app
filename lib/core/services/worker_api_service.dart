import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/api_config.dart';
import '../exceptions/api_exception.dart';

class WorkerApiService {
  /// 작업자 등록 API 호출
  ///
  /// [workType] - 작업 유형 (IB 또는 OB)
  /// [workerId] - 작업자 ID (전화번호 뒷자리)
  ///
  /// Returns: 성공 시 true, 실패 시 ApiException 발생
  static Future<bool> registerWorker(String workType, String workerId) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}/$workType/$workerId/login');

      final response = await http
          .put(url, headers: {'Content-Type': 'application/json'})
          .timeout(Duration(seconds: ApiConfig.timeoutSeconds));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException(
          message: '작업자 등록에 실패했습니다.',
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }
    } on http.ClientException {
      throw const NetworkException(message: '네트워크 연결에 실패했습니다.');
    } on SocketException {
      throw const NetworkException(message: '서버에 연결할 수 없습니다.');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(message: '알 수 없는 오류가 발생했습니다: $e');
    }
  }
}
