class UserLocation {
  double latitude;
  double longitude;

  UserLocation(this.latitude, this.longitude);

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> userLocation = Map<String, dynamic>();
    userLocation["latitude"] = this.latitude;
    userLocation["longitude"] = this.longitude;
    return userLocation;
  }
  
}
