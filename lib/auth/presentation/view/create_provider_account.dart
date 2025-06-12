import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/category_card.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/custom_button.dart';
import 'package:taht_bety_provider/auth/presentation/view_model/cubit/createprovider_cubit.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_fun.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
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
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
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

  Future<bool> _saveIdImageAndType() async {
    try {
      String base64 = await AppFun.imageToBase64(_frontImage!);
      String backBase64 = '';
      if (_backImage != null) {
        backBase64 = await AppFun.imageToBase64(_backImage!);
      }
      UserStorage.updateUserData(
        idFrontSide: base64,
        idBackSide: backBase64,
        type: _selectedType,
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image: $e')),
      );
      return false;
    }
  }

  bool needId() {
    if (_selectedType == null) {
      return false;
    } else {
      String type = _selectedType!.split('-')[0].toUpperCase();
      if (type == 'R' || type == 'HW') {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CreateproviderCubit, CreateproviderState>(
          listener: (context, state) async {
            if (state is CheckIdSuccess) {
              setState(() {
                _isLoading = false;
              });
              bool success = await _saveIdImageAndType();
              if (success) {
                context.push(AppRouter.kTakeSelfie);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to save ID images')),
                );
              }
            } else if (state is CheckIdFailure) {
              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is CheckIdLoading) {
              setState(() {
                _isLoading = true;
              });
            }
          },
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
                  "Please fill in your information below.",
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
                // const SizedBox(height: 20),
                if (_selectedType != null) buildIDWidgets(),
                // Create Account Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: CustomButton(
                    text: "Next",
                    onPressed: () async {
                      if (_selectedType == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select your Type'),
                          ),
                        );
                        return;
                      } else if (_frontImage == null || _backImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please upload both images'),
                          ),
                        );
                        return;
                      } else if (needId()) {
                        context.read<CreateproviderCubit>().checkID(
                              _frontImage!,
                              _backImage!,
                            );
                      } else {
                        await _saveIdImageAndType();
                        context.push(AppRouter.kMaps);
                      }
                    },
                    isLoading: _isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIDWidgets() {
    return Column(
      children: [
        // ID Card Front Side
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              needId()
                  ? "ID Card Front Side"
                  : "Please take a image for your work",
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
            fit: BoxFit.fill,
          ),

        // ID Card Back Side
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              needId() ? "ID Card Back Side" : "Please take a different image",
              style: Styles.subtitle16Bold.copyWith(
                color: ksecondryColor,
                fontSize: 14,
              ),
              softWrap: true,
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
      ],
    );
  }
}
