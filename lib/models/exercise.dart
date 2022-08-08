class Exercise {
  final String muscleGroup;
  final String name;
  final int repCount;
  final int setCount;

  Exercise({
    required this.muscleGroup,
    required this.name,
    required this.repCount,
    required this.setCount,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "muscleGroup": muscleGroup,
      "name": name,
      "repCount": repCount,
      "setCount": setCount,
    };
  }

}