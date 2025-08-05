import 'package:shared_preferences/shared_preferences.dart';

/// 사용자 정보 로컬 저장 서비스
class UserStorageService {
  static const String _workTypeKey = 'work_type';
  static const String _workerIdKey = 'worker_id';

  /// 사용자 로그인 정보 저장
  static Future<void> saveUserInfo(String workType, String workerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_workTypeKey, workType);
    await prefs.setString(_workerIdKey, workerId);
  }

  /// 작업 타입 가져오기
  static Future<String?> getWorkType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_workTypeKey);
  }

  /// 작업자 ID 가져오기
  static Future<String?> getWorkerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_workerIdKey);
  }

  /// 사용자 정보 모두 가져오기
  static Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'workType': prefs.getString(_workTypeKey),
      'workerId': prefs.getString(_workerIdKey),
    };
  }

  /// 사용자 정보 삭제 (로그아웃)
  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_workTypeKey);
    await prefs.remove(_workerIdKey);
  }

  /// 로그인 상태 확인
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final workType = prefs.getString(_workTypeKey);
    final workerId = prefs.getString(_workerIdKey);
    return workType != null && workerId != null;
  }
}
