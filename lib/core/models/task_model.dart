/// 작업 태스크 모델
class Task {
  final String productId;
  final String name;
  final String img;
  final int quantity;
  final String targetLocationId;

  Task({
    required this.productId,
    required this.name,
    required this.img,
    required this.quantity,
    required this.targetLocationId,
  });

  /// JSON에서 Task 객체 생성
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      productId: json['product_id'] as String,
      name: json['name'] as String,
      img: json['img'] as String? ?? '', // null일 경우 빈 문자열
      quantity: json['quantity'] as int,
      targetLocationId: json['target_location_id'] as String,
    );
  }

  /// Task 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'img': img,
      'quantity': quantity,
      'target_location_id': targetLocationId,
    };
  }
}

/// 토트박스 스캔 응답 모델
class ToteBoxScanResponse {
  final List<Task> tasks;

  ToteBoxScanResponse({required this.tasks});

  /// JSON에서 ToteBoxScanResponse 객체 생성
  factory ToteBoxScanResponse.fromJson(Map<String, dynamic> json) {
    final tasksList = json['tasks'] as List<dynamic>;
    final tasks = tasksList
        .map((taskJson) => Task.fromJson(taskJson as Map<String, dynamic>))
        .toList();

    return ToteBoxScanResponse(tasks: tasks);
  }

  /// ToteBoxScanResponse 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {'tasks': tasks.map((task) => task.toJson()).toList()};
  }
}
