class QuizRegisterMainEvent {
  QuizRegisterEvent data;

  QuizRegisterMainEvent(this.data);
}

class QuizRegisterEvent {
  late int joinedUserCount;
  late String maxPlayerCount;
  late dynamic winningAmount;
  late dynamic totalSpentAmount;

  @override
  String toString() {
    return 'QuizRegisterEvent{joinedUserCount: $joinedUserCount, maxPlayerCount: $maxPlayerCount, winningAmount: $winningAmount, totalSpentAmount: $totalSpentAmount}';
  }

  QuizRegisterEvent(
      {required this.joinedUserCount,
      required this.maxPlayerCount,
      required this.winningAmount,
      required this.totalSpentAmount});

  QuizRegisterEvent.fromJson(Map<String, dynamic> json) {
    joinedUserCount = json['joined_user_count'];
    maxPlayerCount = json['max_player_count'];
    winningAmount = json['winning_amount'];
    totalSpentAmount = json['totalSpentAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['joined_user_count'] = joinedUserCount;
    data['max_player_count'] = maxPlayerCount;
    data['winning_amount'] = winningAmount;
    data['totalSpentAmount'] = totalSpentAmount;

    return data;
  }
}
