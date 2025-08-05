import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rescuepang_pda/presentation/pages/basic_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/app_router.dart';
import '../../core/constants/app_sizes.dart';
import '../widgets/rescue_pang_logo.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/work_type_dropdown.dart';
import '../widgets/login_button.dart';
import '../../core/services/worker_api_service.dart';
import '../../core/exceptions/api_exception.dart';

/// 로그인 페이지
/// 사용자 ID와 작업 유형을 입력받아 로그인 처리
@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIdController = TextEditingController();
  WorkType? _selectedWorkType;
  bool _isLoading = false;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_userIdController.text.isEmpty || _selectedWorkType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사용자 ID와 작업 유형을 모두 입력해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // API 호출
      final workType = _selectedWorkType!.value; // IB 또는 OB
      final workerId = _userIdController.text.trim();

      await WorkerApiService.registerWorker(workType, workerId);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        context.router.push(BasicRoute(reqType: 'scan'));
      }
    } on NetworkException catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } on ServerException catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } on ApiException catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // 로고
                  const Center(child: RescuePangLogo()),

                  const SizedBox(height: AppSizes.verticalSpacing),

                  // 로그인 폼 컨테이너
                  Container(
                    width: AppSizes.formContainerWidth,
                    constraints: const BoxConstraints(
                      minHeight: AppSizes.formContainerHeight,
                      maxHeight: 450,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.inputBackground,
                      borderRadius: BorderRadius.circular(
                        AppSizes.formContainerRadius,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 사용자 ID 입력 필드
                          CustomInputField(
                            label: '사용자 ID 입력',
                            hintText: '사용자 ID를 입력하세요',
                            controller: _userIdController,
                          ),

                          const SizedBox(height: AppSizes.verticalSpacing),

                          // 작업 유형 선택
                          WorkTypeDropdown(
                            selectedValue: _selectedWorkType,
                            onChanged: (WorkType? value) {
                              setState(() {
                                _selectedWorkType = value;
                              });
                            },
                          ),

                          const SizedBox(height: AppSizes.verticalSpacing),

                          // 로그인 버튼
                          LoginButton(
                            onPressed: _handleLogin,
                            isLoading: _isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
