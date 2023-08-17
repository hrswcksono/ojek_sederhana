class SendGood {
  final int id;
  final double latDriver;
  final double longDriver;
  final double latOffice;
  final double longOffice;
  final double distance;
  final String image;
  final String date;

  const SendGood({
    required this.id,
    required this.latDriver,
    required this.longDriver,
    required this.latOffice,
    required this.longOffice,
    required this.distance,
    required this.image,
    required this.date,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latDriver': latDriver,
      'longDriver': longDriver,
      'latOffice': latOffice,
      'longOffice': longOffice,
      'distance': distance,
      'image': image,
      'date': date,
    };
  }

  // // Implement toString to make it easier to see information about
  // // each dog when using the print statement.
  // @override
  // String toString() {
  //   return 'Dog{id: $id, name: $name, age: $age}';
  // }
}
