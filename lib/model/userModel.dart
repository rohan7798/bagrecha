UserModal currentUser = UserModal();

class UserModal {
  String uid;
  String name;
  String address;
  String marriageStatus;
  String aadharNo;
  String licenseNo;
  String bloodGroup;
  String driverType;
  String profileUrl;
  String phoneNumber;

  UserModal();

  UserModal.fromJson(Map<String, dynamic> user) {
    this.uid = user["uid"]??user["uid"];
    this.name = user["name"]??user["name"];
    this.address = user["address"]??user["address"];
    this.marriageStatus = user["marriageStatus"]??user["marriageStatus"];
    this.aadharNo = user["aadharNo"]??user["aadharNo"];
    this.licenseNo = user["licenseNo"]??user["licenseNo"];
    this.bloodGroup = user["bloodGroup"]??user["bloodGroup"];
    this.profileUrl = user["profileUrl"]??user["profileUrl"];
    this.driverType = user["driverType"]??user["driverType"];
    this.phoneNumber = user["phoneNumber"]??user["phoneNumber"];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> user = Map<String, dynamic>();
    user["uid"] = this.uid;
    user["name"] = this.name;
    user["address"] = this.address;
    user["marriageStatus"] = this.marriageStatus;
    user["aadharNo"] = this.aadharNo;
    user["licenseNo"] = this.licenseNo;
    user["bloodGroup"] = this.bloodGroup;
    user["driverType"] = this.driverType;
    user["profileUrl"] = this.profileUrl;
    user["phoneNumber"] = this.phoneNumber;
    return user;
  }
}
