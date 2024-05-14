import 'dart:ffi';

class User {
  String name;
  String email;
  String eventName;
  int ageAtEventStart;
  String status;
  String entryTime;
  Map items;
  bool valid;
  String reason;



  User(this.name, this.email, this.eventName, this.ageAtEventStart,
      this.status, this.entryTime,this.items, this.valid, this.reason);
}