class LoginModel{
  
  bool status;
  String message;
  UserData data;

  // named constructor
  LoginModel.dataFromJson(Map<String , dynamic> jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
    data = jsonData['data'] != null ? UserData.dataFromJson(jsonData['data']) : null ;
  }

}


class UserData {
  int id;
  String name;
  String email;
  String phone; 
  String image;
  int points;
  int credit;
  String token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token});
// named constructor
  UserData.dataFromJson(Map<String , dynamic> jsonData){
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    points = jsonData['points'];
    credit = jsonData['credit'];
    token = jsonData['token'];
  }
}