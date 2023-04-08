class UserModel{
  String? name;
  String? email;
  String? password;
  int? birthday;
  String? bloodType;
  String? city;
  String? address;
  String? phoneNumber;
  bool isDonor= false;
  String? uId;
  String? imageUrl;



  UserModel({this.name, this.email, this.password, this.birthday, this.bloodType,
      this.city, this.address, this.phoneNumber,this.uId,this.imageUrl='',this.isDonor=false});


  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, birthday: $birthday, bloodType: $bloodType, city: $city, address: $address, phoneNumber: $phoneNumber, isDonor: $isDonor, uId: $uId, imageUrl: $imageUrl}';
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    birthday = json['birthday'];
    bloodType = json['bloodType'];
    city = json['city'];
    address = json['address'];
    isDonor = json['isDonor']??false;
    phoneNumber = json['phoneNumber'];
    uId = json['uId'];
    imageUrl = json['imageUrl'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isDonor':isDonor,
      'password': password,
      'birthday': birthday,
      'bloodType': bloodType,
      'city': city,
      'address': address,
      'phoneNumber': phoneNumber,
      'uId': uId,
      'imageUrl': imageUrl
    };
  }


}
