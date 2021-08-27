//esto podria estar en el core porque en algun momento puede que todos accedan al usuario
class Usuario {
  String codUsuario = '';
  String nombreUsuario = '';
  String codPersona = '';
  String password = '';
  String estado = ''; // this is a char
  String email = '';
  bool flagActDir = false;
  String userNew = '';
  DateTime dateNew = DateTime.now();
  String userEdit = '';
  DateTime dateEdit = DateTime.now();

  Usuario(
      this.codUsuario,
      this.nombreUsuario,
      this.codPersona,
      this.password,
      this.estado,
      this.email,
      this.flagActDir,
      this.userNew,
      this.dateNew,
      this.userEdit,
      this.dateEdit);

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      json["Cod_Usuario"],
      json["Nombre_Usuario"],
      json["Cod_Persona"],
      json["Passwd"],
      json["Estado"],
      json["EMail"],
      json["flagActDir"] == "true",
      json["UserNew"],
      json["DateNew"],
      json["UserEdit"],
      json["DateEdit"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Cod_Usuario": codUsuario,
      "Nombre_Usuario": nombreUsuario,
      "Cod_Persona": codPersona,
      "Passwd": password,
      "Estado": estado,
      "EMail": email,
      "flagActDir": flagActDir,
      "UserNew": userNew,
      "DateNew": dateNew,
      "UserEdit": userEdit,
      "DateEdit": dateEdit,
    };
  }
}
