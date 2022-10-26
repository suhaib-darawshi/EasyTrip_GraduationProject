class Trip {
  String name;
  String location;
  String url;
  Trip(this.name, this.location, this.url);
  static List<Trip> generateTrips = [
    Trip('Place 1', 'Location 1', 'assets/imgs/t1.jpg'),
    Trip('Place 2', 'Location 2', 'assets/imgs/t2.jpg'),
    Trip('Place 3', 'Location 3', 'assets/imgs/t3.jpg'),
    Trip('Place 4', 'Location 4', 'assets/imgs/t4.jpg'),
    Trip('Place 5', 'Location 5', 'assets/imgs/t5.webp')
  ];
}
