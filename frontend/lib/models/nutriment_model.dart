class Nutriments {
  int? carbohydrates;
  int? energy;
  int? fat;
  int? proteins;
  int? salt;
  int? sodium;
  int? sugars;
  int? fiber;
  int? saturatedFat;
  

  Nutriments({
    this.carbohydrates,
    this.energy,
    this.fat,
    this.proteins,
    this.salt,
    this.sodium,
    this.sugars,
    this.fiber,
    this.saturatedFat,
  });
  factory Nutriments.fromJson(Map<String, dynamic> json) {
    return Nutriments(
      carbohydrates: json['carbohydrates'],
      energy: json['energy'],
      fat: json['fat'],
      proteins: json['proteins'],
      salt: json['salt'],
      sodium: json['sodium'],
      sugars: json['sugars'],
      fiber: json['fiber'],
      saturatedFat: json['saturated-fat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carbohydrates' : carbohydrates,
      'energy' : energy,
      'fat': fat,
      'proteins': proteins,
      'salt': salt,
      'sodium': sodium,
      'sugars': sugars,
      'fiber': fiber,
      'saturated-fat': saturatedFat,
    };
  }
}
