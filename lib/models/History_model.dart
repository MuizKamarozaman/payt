// lib/models/recycle_history_model.dart
class RecycleHistory {
  final double weight;
  final double plastic;
  final double glass;
  final double paper;
  final double rubber;
  final double metal;
  final double money;
  final double point;

  RecycleHistory({
    required this.weight,
    required this.plastic,
    required this.glass,
    required this.paper,
    required this.rubber,
    required this.metal,
    required this.money,
    required this.point,
  });

  factory RecycleHistory.fromMap(Map<String, dynamic> map) {
    return RecycleHistory(
      weight: map['weight'].toDouble(),
      plastic: map['plastic'].toDouble(),
      glass: map['glass'].toDouble(),
      paper: map['paper'].toDouble(),
      rubber: map['rubber'].toDouble(),
      metal: map['metal'].toDouble(),
      money: map['money'].toDouble(),
      point: map['point'].toDouble(),
    );
  }
}
