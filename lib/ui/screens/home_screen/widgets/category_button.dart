import 'package:book/blocs/file_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryButtons extends StatelessWidget {
  const CategoryButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryButton("All", true),
          _buildCategoryButton("Romance", false),
          _buildCategoryButton("Sci-Fi", false),
          _buildCategoryButton("Fantasy", false),
          _buildCategoryButton("Classics", false),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor:
              isSelected ? const Color(0xff404066) : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {},
        child: Text(label),
      ),
    );
  }
}
