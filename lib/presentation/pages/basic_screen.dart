import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/worker_api_service.dart';
import '../../core/services/user_storage_service.dart';
import '../../core/exceptions/api_exception.dart';
import '../../core/models/task_model.dart';
import '../../core/router/app_router.dart';

/// 스캔 화면 타입 정의
enum ReqType {
  scan('토트박스를 스캔해주세요', 'QR코드 스캔'),
  navigate('', '도착완료'), // 메시지는 동적으로 결정
  custom('', ''); // 커스텀 타입

  const ReqType(this.message, this.buttonText);

  /// 스캔 안내 메시지
  final String message;

  /// 버튼 텍스트
  final String buttonText;

  /// 라우트 경로에서 스캔 타입을 매핑
  static ReqType fromRoute(String? routePath) {
    if (routePath == null) return ReqType.scan;
    // 경로에 포함된 키워드로 타입 결정
    final path = routePath.toLowerCase();
    if (path.contains('scan')) {
      return ReqType.scan;
    }
    if (path.contains('navigate')) return ReqType.navigate;

    return ReqType.scan; // 기본값
  }

  /// 스캔 타입 파라미터에서 스캔 타입을 매핑
  static ReqType fromParameter(String? reqTypeParam) {
    if (reqTypeParam == null) return ReqType.scan;

    switch (reqTypeParam.toLowerCase()) {
      case 'navigate':
        return ReqType.navigate;
      default:
        return ReqType.scan;
    }
  }
}

/// Basic Screen - QR 코드 스캔 기능을 위한 기본 화면
/// 피그마 디자인을 기반으로 구현된 화면
/// 라우팅 경로에 따라 자동으로 스캔 타입이 결정됨
@RoutePage()
class BasicScreen extends StatefulWidget {
  final String? reqType; // 라우트 파라미터로 받는 스캔 타입 (경로에서 :reqType)
  final Function()? onButtonPressed; // 버튼 클릭 시 콜백

  const BasicScreen({super.key, @pathParam this.reqType, this.onButtonPressed});

  /// 실제 사용할 스캔 타입을 결정
  ReqType getEffectiveScanType(BuildContext context) {
    // 1. 라우트 파라미터에서 결정
    if (reqType != null) {
      return ReqType.fromParameter(reqType!);
    }

    // 2. 현재 라우트 경로에서 결정
    try {
      final routePath = context.routeData.path;
      return ReqType.fromRoute(routePath);
    } catch (e) {
      // 라우트 정보를 가져올 수 없는 경우
      return ReqType.scan;
    }
  }

  /// 실제 표시될 메시지를 반환
  String getDisplayMessage(BuildContext context) {
    final type = getEffectiveScanType(context);
    return type.message;
  }

  /// 실제 표시될 버튼 텍스트를 반환
  String getDisplayButtonText(BuildContext context) {
    final type = getEffectiveScanType(context);
    return type.buttonText;
  }

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  String? _targetLocation;

  @override
  void initState() {
    super.initState();
    _loadTargetLocation();
  }

  /// 목표 위치 로드
  Future<void> _loadTargetLocation() async {
    final targetLocation = await UserStorageService.getTargetLocation();
    setState(() {
      _targetLocation = targetLocation;
    });
    print('목표 위치: $_targetLocation');
  }

  /// 동적 메시지 생성
  String _getDisplayMessage() {
    final type = widget.getEffectiveScanType(context);

    if (type == ReqType.navigate && _targetLocation != null) {
      return '$_targetLocation로 이동하세요';
    }

    return type.message;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 스캔 메시지 - 테마의 headlineLarge 사용
              Center(
                child: Text(
                  _getDisplayMessage(), // 동적 메시지 사용
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenSize.height * 0.1), // 화면 높이의 10%
              // 에러 메시지 표시
              if (_errorMessage != null) ...[
                Center(
                  child: Container(
                    width: screenSize.width * 0.8, // 화면 너비의 80%
                    constraints: const BoxConstraints(maxWidth: 300.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: screenSize.width * 0.035, // 반응형 폰트 크기
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02), // 화면 높이의 2%
              ],

              // QR 스캔 버튼
              Center(child: _buildQRScanButton(screenSize)),
            ],
          ),
        ),
      ),
    );
  }

  /// QR 스캔 버튼 위젯
  Widget _buildQRScanButton(Size screenSize) {
    final buttonWidth = screenSize.width * 0.6; // 화면 너비의 60%
    final buttonHeight = 56.0;
    final iconSize = screenSize.width * 0.06; // 화면 너비의 6%

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleButton,
        child: _isLoading
            ? const SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // QR 코드 아이콘
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.03), // 화면 너비의 3%
                  // 버튼 텍스트
                  Text(
                    widget.getDisplayButtonText(context), // 라우트 기반 버튼 텍스트 사용
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04, // 반응형 폰트 크기
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// 버튼 처리 메서드
  Future<void> _handleButton() async {
    // 에러 메시지 초기화
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      // 콜백이 제공된 경우 콜백 실행
      if (widget.onButtonPressed != null) {
        await widget.onButtonPressed!();
      } else {
        // 현재 ReqType에 따른 처리
        final currentType = widget.getEffectiveScanType(context);

        if (currentType == ReqType.scan) {
          // 토트박스 스캔 API 호출
          print('토트박스 스캔 시작');
          await _handleToteBoxScan();
        } else {
          // TODO: 다른 스캔 기능 구현
          await Future.delayed(const Duration(seconds: 2)); // 임시 딜레이
        }
      }

      // 성공 시 처리
      if (mounted) {
        // TODO: 스캔 결과에 따른 네비게이션 처리
        print('버튼이 눌렸습니다');
      }
    } catch (e) {
      // 에러 처리
      if (mounted) {
        String errorMessage = '오류가 발생했습니다.';

        if (e is ApiException) {
          errorMessage = e.message;
        } else if (e is NetworkException) {
          errorMessage = e.message;
        } else if (e is ServerException) {
          errorMessage = e.message;
        }

        setState(() {
          _errorMessage = errorMessage;
        });
      }
    } finally {
      // 로딩 상태 해제
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 토트박스 스캔 처리
  Future<void> _handleToteBoxScan() async {
    // 저장된 사용자 정보 가져오기
    final userInfo = await UserStorageService.getUserInfo();
    final workType = userInfo['workType'] ?? 'IB';
    final workerId = userInfo['workerId'] ?? '1234';
    final toteId = 'TOTE-001';

    final result = await WorkerApiService.scanToteBox(
      workType,
      workerId,
      toteId,
    );

    print('토트박스 스캔 성공: ${result}');
    // 응답 데이터를 모델로 파싱
    final scanResponse = ToteBoxScanResponse.fromJson(result);

    // 태스크 데이터를 SharedPreferences에 저장
    await UserStorageService.saveTasks(scanResponse.tasks);

    print('토트박스 스캔 성공: ${scanResponse.tasks.length}개 작업');

    // Mission Briefing Screen으로 이동
    if (mounted) {
      context.router.push(MissionBriefingRoute());
    }
  }
}
