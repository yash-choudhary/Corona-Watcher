class Notes{
  String country;
  String total_case;
  String new_case;
  String total_death;
  String new_death;
  String total_recovered;
  String active_case;
  String critical;

  Notes(this.country,this.total_case,this.new_case,this.total_death,this.new_death,this.total_recovered,this.active_case,this.critical);
  Notes.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    total_case= json['total_case'];
    new_case= json['new_case'];
    total_death= json['total_death'];
    new_death= json['new_death'];
    total_recovered= json['total_recovered'];
    active_case= json['active_case'];
    critical= json['critical'];
  }

  toLowerCase() {}
}
