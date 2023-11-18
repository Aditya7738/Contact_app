class Records{
  final String name,address,contact, photo, url;

  const Records({required this.name, required this.address, required this.contact, required this.photo, required this.url});

  factory Records.fromJSON(Map<String, dynamic> json){
    return Records(name: json["name"], address: json["address"], contact: json["contact"], photo: json["photo"], url: json["url"]);
  }
}