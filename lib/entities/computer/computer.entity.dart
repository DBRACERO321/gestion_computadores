class Computer {
  final int? id;
  final String model;
  final String processor;
  final String hardDisk;
  final String ram;

  Computer({
    this.id,
    required this.model,
    required this.processor,
    required this.hardDisk,
    required this.ram,
  });

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'processor': processor,
      'hardDisk': hardDisk,
      'ram': ram,
    };
  }

  factory Computer.fromMap(Map<String, dynamic> map) {
    return Computer(
      id: map['id'],
      model:map['model'],
      processor: map['processor'],
      hardDisk: map['hardDisk'],
      ram: map['ram'],
    );
  }

  @override
  String toString() {
    return 'Computadora {id: $id, procesador: $processor, discoDuro: $hardDisk, ram: ${ram}GB}';
  }
}
