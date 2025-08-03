import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../core/constants/app_colors.dart';

/// Item Confirmation Screen - 물품 확인 화면
/// 스캔된 물품의 정보를 확인하고 작업을 진행하는 화면
@RoutePage()
class ItemConfirmationScreen extends StatefulWidget {
  const ItemConfirmationScreen({super.key});

  @override
  State<ItemConfirmationScreen> createState() => _ItemConfirmationScreenState();
}

class _ItemConfirmationScreenState extends State<ItemConfirmationScreen> {
  // 샘플 제품 데이터
  final Map<String, dynamic> _product = {
    'name': '노트북 컴퓨터',
    'quantity': 5,
    'imageUrl': null, // 실제 이미지 URL로 교체 가능
  };

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final availableHeight = screenSize.height - padding.top - padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),

              // 제품 이미지 카드
              Center(
                child: Container(
                  width: screenSize.width * 0.75, // 화면 너비의 75%
                  height: screenSize.width * 0.75, // 정사각형 유지
                  constraints: const BoxConstraints(
                    maxWidth: 280.0,
                    maxHeight: 280.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color(0xFFF2F2F2),
                      child: _product['imageUrl'] != null
                          ? Image.network(
                              _product['imageUrl'],
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.laptop_mac_outlined,
                              color: AppColors.textSecondary,
                              size: 64.0,
                            ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              // 제품 이름 배경
              Center(
                child: Container(
                  width: screenSize.width * 0.6, // 화면 너비의 60%
                  constraints: const BoxConstraints(
                    maxWidth: 200.0,
                    minHeight: 60.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        _product['name'],
                        style: TextStyle(
                          fontSize: screenSize.width * 0.06, // 반응형 폰트 크기
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              // 수량 정보 배경
              Center(
                child: Container(
                  width: screenSize.width * 0.6, // 화면 너비의 60%
                  constraints: const BoxConstraints(
                    maxWidth: 200.0,
                    minHeight: 50.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '남은 수량: ${_product['quantity']}개',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.045, // 반응형 폰트 크기
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // 확인 버튼
              Center(
                child: SizedBox(
                  width: screenSize.width * 0.8, // 화면 너비의 80%
                  height: 64.0,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            '확인',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.045, // 반응형 폰트 크기
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(height: availableHeight * 0.05), // 화면 높이의 5%
            ],
          ),
        ),
      ),
    );
  }

  /// 확인 버튼 처리 메서드
  Future<void> _handleConfirm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 확인 로직 구현
      await Future.delayed(const Duration(seconds: 2)); // 임시 딜레이

      if (mounted) {
        // TODO: 다음 화면으로 네비게이션 또는 작업 완료 처리
        print('물품 확인이 완료되었습니다.');

        // 성공 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('물품이 성공적으로 확인되었습니다.'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('확인 중 오류가 발생했습니다: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
