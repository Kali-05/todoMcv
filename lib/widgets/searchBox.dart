import 'package:flutter/material.dart';

Widget searchBox() {
    return Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  prefixIconConstraints: BoxConstraints (
                    minWidth: 25,
                    maxHeight: 20,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
                
                ),
              );
  }