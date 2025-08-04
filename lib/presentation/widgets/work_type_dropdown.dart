import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

enum WorkType {
  inbound('IB'),
  outbound('OB');

  const WorkType(this.value);
  final String value;
}

class WorkTypeDropdown extends StatefulWidget {
  final Function(WorkType?) onChanged;
  final WorkType? selectedValue;

  const WorkTypeDropdown({
    super.key,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  State<WorkTypeDropdown> createState() => _WorkTypeDropdownState();
}

class _WorkTypeDropdownState extends State<WorkTypeDropdown> {
  WorkType? _selectedValue;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '작업 유형 선택',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: AppSizes.smallSpacing),
        Container(
          width: AppSizes.inputFieldWidth,
          height: AppSizes.inputFieldHeight,
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(AppSizes.dropdownRadius),
            border: Border.all(color: AppColors.inputBorder, width: 1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.dropdownRadius),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedValue == null
                            ? '작업 유형을 선택하세요'
                            : _selectedValue == WorkType.inbound
                            ? 'IB'
                            : 'OB',
                        style: TextStyle(
                          color: _selectedValue == null
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    if (_selectedValue != null)
                      Container(
                        width: AppSizes.iconSize,
                        height: AppSizes.iconSize,
                        decoration: BoxDecoration(
                          color: _selectedValue == WorkType.inbound
                              ? AppColors.inboundIcon
                              : AppColors.outboundIcon,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            width: AppSizes.inputFieldWidth,
            margin: const EdgeInsets.only(top: 4),
            constraints: const BoxConstraints(maxHeight: 120),
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
              border: Border.all(color: AppColors.inputBorder, width: 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDropdownItem(
                    WorkType.inbound,
                    'IB',
                    AppColors.inboundIcon,
                  ),
                  _buildDropdownItem(
                    WorkType.outbound,
                    'OB',
                    AppColors.outboundIcon,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownItem(WorkType type, String label, Color iconColor) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedValue = type;
            _isExpanded = false;
          });
          widget.onChanged(type);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Container(
                width: AppSizes.iconSize,
                height: AppSizes.iconSize,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
