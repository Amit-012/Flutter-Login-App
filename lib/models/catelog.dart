//object of class
class CatalogModel {
  static final items = [
    Item(
      id: "Item001",
      name: "iPhone 12 pro",
      desc: "Apple iPhone 12 pro",
      prize: 999,
      color: "#33505a",
      image:
          "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-12-pro-r1.jpg",
    )
  ];
}

// this is class
class Item {
  final String id;
  final String name;
  final String desc;
  final num prize;
  final String color;
  final String image;
// constructor of class
  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.prize,
      required this.color,
      required this.image});
}
