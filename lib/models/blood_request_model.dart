class BloodRequestModel {
  String? name;
  int? birthday;
  String? bloodType;
  String? city;
  String? address;
  String? phoneNumber;
  String? uId;
  String? imageUrl;

  BloodRequestModel(this.name, this.birthday, this.bloodType, this.city,
      this.address, this.phoneNumber, this.uId, this.imageUrl);

  BloodRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthday = json['birthday'];
    bloodType = json['bloodType'];
    city = json['city'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    uId = json['uId'];
    imageUrl = json['imageUrl'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthday': birthday,
      'bloodType': bloodType,
      'city': city,
      'address': address,
      'phoneNumber': phoneNumber,
      'uId': uId,
      'imageUrl': imageUrl,
    };
  }
}
