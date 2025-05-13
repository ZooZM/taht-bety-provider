import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/category_card.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/custom_button.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/cubit/image_upload_cubit_cubit.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/data.dart';

class CreateProviderAccount extends StatefulWidget {
  const CreateProviderAccount({super.key});

  @override
  State<CreateProviderAccount> createState() => _CreateProviderAccountState();
}

class _CreateProviderAccountState extends State<CreateProviderAccount> {
  String? _selectedType;
  File? _frontImage;
  File? _backImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _uploadImage() async {
    try {
      final formData = FormData.fromMap({
        'file': _frontImage,
      });

      final response = await Dio().post(
        'https://example.com/upload',
        data: formData,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageUploadCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A4D6F),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Fill your information below or register\nwith your social account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF99A8C2),
                  ),
                ),
                const SizedBox(height: 16),

                // Service Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  value: _selectedType,
                  selectedItemBuilder: (BuildContext context) {
                    return Data.categoresNames.map<Widget>((String category) {
                      return Text(
                        category.split('-')[1],
                        style:
                            Styles.text14Light.copyWith(color: kPrimaryColor),
                        overflow: TextOverflow.ellipsis,
                      );
                    }).toList();
                  },
                  items: Data.categoresNames.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CategoriesCard(
                          title: category,
                          icon: Data.categores
                              .firstWhere((c) => c.name == category)
                              .icon,
                          isCheck: false,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your Type';
                    }
                    return null;
                  },
                  icon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                ),
                const SizedBox(height: 20),

                // ID Card Front Side
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID Card Front Side",
                      style: Styles.subtitle16Bold.copyWith(
                        color: ksecondryColor,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload_file,
                          color: ksecondryColor, size: 20),
                      onPressed: () => _pickImage(true),
                    ),
                  ],
                ),
                if (_frontImage != null)
                  Image.file(
                    _frontImage!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                BlocConsumer<ImageUploadCubit, ImageUploadState>(
                  listener: (context, state) {
                    if (state is ImageUploadedSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Front image uploaded!')),
                      );
                    } else if (state is ImageUploadError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.msg)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ImageUploading) {
                      return const CircularProgressIndicator();
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // ID Card Back Side
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID Card Back Side",
                      style: Styles.subtitle16Bold.copyWith(
                        color: ksecondryColor,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload_file,
                          color: ksecondryColor, size: 20),
                      onPressed: () => _pickImage(false),
                    ),
                  ],
                ),
                if (_backImage != null)
                  Image.file(
                    _backImage!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                BlocConsumer<ImageUploadCubit, ImageUploadState>(
                  listener: (context, state) {
                    if (state is ImageUploadedSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Back image uploaded!')),
                      );
                    } else if (state is ImageUploadError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.msg)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ImageUploading) {
                      return const CircularProgressIndicator();
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Create Account Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: CustomButton(
                    text: "Next",
                    onPressed: () {
                      if (_frontImage != null &&
                          _backImage != null &&
                          _selectedType != null) {
                        context
                            .read<ImageUploadCubit>()
                            .uploadImage(_frontImage!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please upload both images and choose a type'),
                          ),
                        );
                      }
                    },
                    isLoading: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
