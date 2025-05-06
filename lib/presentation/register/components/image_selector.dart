import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scribe/core/colors/app_colors.dart';
import 'package:scribe/presentation/register/cubit/image_picker_cubit.dart';

class ImageSelector extends StatelessWidget {
  final ImagePickerCubit cubit;
  const ImageSelector({required this.cubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, String>(
      builder: (BuildContext context, String state) {
        return Stack(
          children: [
            state.isEmpty ? Container(
              height: 160, width: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffD9D9D9)
              ),
            ) : Container(
              height: 160, width: 160,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: Image.file(
                  File(state),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  cubit.selectImage();
                },
                child: Container(
                  height: 52, width: 52,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                    shape: BoxShape.circle
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.white, size: 24)),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
