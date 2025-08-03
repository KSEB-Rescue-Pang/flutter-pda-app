import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// Mission Briefing Screen - 진열 물품 리스트 화면
/// 작업 시작 전 물품 목록을 확인하는 화면
@RoutePage()
class MissionBriefingScreen extends StatefulWidget {
  const MissionBriefingScreen({super.key});

  @override
  State<MissionBriefingScreen> createState() => _MissionBriefingScreenState();
}

class _MissionBriefingScreenState extends State<MissionBriefingScreen> {
  // 샘플 물품 데이터
  final List<Map<String, dynamic>> _items = [
    {
      'name': '노트북 컴퓨터',
      'quantity': 5,
      'imageUrl': null, // 실제 이미지 URL로 교체 가능
    },
    {'name': '스마트폰', 'quantity': 12, 'imageUrl': null},
    {'name': '태블릿 PC', 'quantity': 8, 'imageUrl': null},
  ];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),

              // 헤더 제목
              Text(
                '진열 물품 리스트',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 20.0),

              // 물품 리스트 컨테이너
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return _buildItemCard(item);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              // 작업 시작 버튼
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleStartMission,
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
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          '작업 시작',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  /// 물품 카드 위젯
  Widget _buildItemCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // 물품 이미지
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: item['imageUrl'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(item['imageUrl'], fit: BoxFit.cover),
                  )
                : const Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.textSecondary,
                    size: 32.0,
                  ),
          ),

          const SizedBox(width: 16.0),

          // 물품 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '수량: ${item['quantity']}개',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 작업 시작 처리 메서드
  Future<void> _handleStartMission() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 작업 시작 로직 구현
      await Future.delayed(const Duration(seconds: 2)); // 임시 딜레이

      if (mounted) {
        // TODO: 다음 화면으로 네비게이션
        print('작업이 시작되었습니다.');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('작업 시작 중 오류가 발생했습니다: ${e.toString()}'),
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
