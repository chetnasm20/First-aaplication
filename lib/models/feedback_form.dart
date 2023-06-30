import 'dart:convert';

import 'package:flutter/material.dart';

class UserFields{
  static final String id = 'id';
  static final String name = 'Name';
  static final String email = 'Email';
  static final String location = 'Location';
  static final String mobileno = 'Mobile Number';
  static final String qualification = 'Qualification';

  static List<String> getFields() => [id, name, email, location, mobileno, qualification];
}

class User{
  final int? id;
  final String name;
  final String email;
  final String mobileno;
  final String location;
  final String qualification;
  const User({
    this.id,
    required this.name,
    required this.email,
    required this.mobileno,
    required this.location,
    required this.qualification,
  });

  User copy({
    int? id,
    String? name,
    String? email,
    String? mobileno,
    String? location,
    String? qualification,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    mobileno: mobileno ?? this.mobileno,
    location: location ?? this.location,
    qualification: qualification ?? this.qualification,
  );

  static User fromJson(Map<String, dynamic>json) => User(
    id: jsonDecode(json[UserFields.id]),
    name: json[UserFields.name],
    mobileno: json[UserFields.mobileno],
    location: json[UserFields.location],
    email: json[UserFields.email],
    qualification: json[UserFields.qualification],
  );

  Map<String,dynamic>toJson()=>{
    UserFields.id: id,
    UserFields.name: name,
    UserFields.email: email,
    UserFields.mobileno: mobileno,
    UserFields.location: location,
    UserFields.qualification: qualification,
  };
}