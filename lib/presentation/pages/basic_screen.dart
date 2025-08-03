import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../core/constants/app_colors.dart';

/// Basic Screen - QR 코드 스캔 기능을 위한 기본 화면
/// 피그마 디자인을 기반으로 구현된 화면
@RoutePage()
class BasicScreen extends StatefulWidget {
  const BasicScreen({super.key});

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  // 버튼 크기 상수들
  static const double _buttonWidth = 200.0;
  static const double _buttonHeight = 56.0;
  static const double _iconSize = 24.0;
  static const double _iconRadius = 4.0;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 스캔 메시지 - 테마의 headlineLarge 사용
              Text(
                '토트박스를 스캔해주세요',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80.0),

              // 에러 메시지 표시
              if (_errorMessage != null) ...[
                Container(
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
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],

              // QR 스캔 버튼
              _buildQRScanButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// QR 스캔 버튼 위젯
  Widget _buildQRScanButton() {
    return SizedBox(
      width: _buttonWidth,
      height: _buttonHeight,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleQRScan,
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
                    width: _iconSize,
                    height: _iconSize,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(_iconRadius),
                    ),
                  ),
                  const SizedBox(width: 12.0),

                  // 버튼 텍스트
                  const Text('QR코드 스캔'),
                ],
              ),
      ),
    );
  }

  /// QR 스캔 처리 메서드
  Future<void> _handleQRScan() async {
    // 에러 메시지 초기화
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      // TODO: QR 스캔 기능 구현
      // 예: 카메라 권한 요청, QR 스캐너 라이브러리 사용 등
      await Future.delayed(const Duration(seconds: 2)); // 임시 딜레이

      // 성공 시 처리
      if (mounted) {
        // TODO: 스캔 결과에 따른 네비게이션 처리
        print('QR 스캔이 완료되었습니다.');
      }
    } catch (e) {
      // 에러 처리
      if (mounted) {
        setState(() {
          _errorMessage = 'QR 스캔 중 오류가 발생했습니다: ${e.toString()}';
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
}
