import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../http/API.dart';
import '../../../../model/amenities.dart';
import '../../../../model/propertities.dart';
import 'add_room_cubit.dart';

class AddRoomPage extends StatelessWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRoomCubit(context.read<API>())..loadAmenities(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Thêm chỗ ở mới',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<AddRoomCubit, AddRoomState>(
          listener: (context, state) {
            if (state is PropertySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.message),
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            } else if (state is PropertyError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: AddRoomForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class AddRoomForm extends StatelessWidget {
  const AddRoomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AddRoomFormContent();
  }
}

class _AddRoomFormContent extends StatelessWidget {
  _AddRoomFormContent({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _addressController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _areaController = TextEditingController();
  final _depositController = TextEditingController();
  final _typeRestroomController = TextEditingController();
  final _propertyTypeController = TextEditingController();
  final _selectedAmenities = <AllAmenity>[];
  final _images = <File>[];
  final _imagePicker = ImagePicker();
  String _selectedTypeRestroom = 'shared';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh
          SectionTitle(title: 'Hình ảnh chỗ ở'),
          ImagePickerSection(
            images: _images,
            onPickImages: () => _pickImages(context),
          ),

          const SizedBox(height: 24),

          // Thông tin cơ bản
          const SectionTitle(title: 'Thông tin cơ bản'),

          CustomTextFormField(
            controller: _titleController,
            labelText: 'Tên chỗ ở',
            icon: Icons.home,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên chỗ ở';
              }
              return null;
            },
          ),

          CustomTextFormField(
            controller: _descriptionController,
            labelText: 'Mô tả',
            icon: Icons.description,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập mô tả';
              }
              return null;
            },
          ),

          CustomTextFormField(
            controller: _priceController,
            labelText: 'Giá / tháng (VND)',
            icon: Icons.monetization_on,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập giá phòng';
              }
              return null;
            },
          ),

          const SizedBox(height: 24),
          const SectionTitle(title: 'Địa chỉ'),
          CustomTextFormField(
            controller: _addressController,
            labelText: 'Địa chỉ đầy đủ',
            icon: Icons.location_on,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập địa chỉ';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          const SectionTitle(title: 'Thông tin phòng'),

          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _bedroomsController,
                  labelText: 'Phòng ngủ',
                  icon: Icons.bed,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nhập số phòng ngủ';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFormField(
                  controller: _bathroomsController,
                  labelText: 'Số người tối đa',
                  icon: Icons.bathtub,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nhập số người';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),





            ],
          ),

          const SectionTitle(title: 'Loại phòng vệ sinh'),
             BlocBuilder<AddRoomCubit, AddRoomState>(
              builder: (context, state) {
                String currentValue = 'shared';
                if (state is AmenitiesLoadSuccess) {
                  currentValue = state.restroomType;
                }
                return DropdownButtonFormField<String>(
                  value: currentValue,
                  items: const [
                    DropdownMenuItem(
                      value: 'shared',
                      child: Text('Chung'),
                    ),
                    DropdownMenuItem(
                      value: 'private',
                      child: Text('Riêng'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context.read<AddRoomCubit>().setRestroomType(value);
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.wc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF5A5F),
                        width: 2,
                      ),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: Color(0xFFFF5A5F),
                    ),
                    labelText: 'Phòng vệ sinh',
                  ),
                );
              },
            ),
          const SizedBox(height: 24),
          const SectionTitle(title: 'Loại phòng'),
          BlocBuilder<AddRoomCubit, AddRoomState>(
            builder: (context, state) {
              String currentValue = 'apartment';
              if (state is AmenitiesLoadSuccess) {
                currentValue = state.propertyType;
              }
              return DropdownButtonFormField<String>(
                value: currentValue,
                items: const [
                  DropdownMenuItem(
                    value: 'apartment',
                    child: Text('Chung cư'),
                  ),
                  DropdownMenuItem(
                    value: 'house',
                    child: Text('Phòng trọ'),
                  ),
                  DropdownMenuItem(
                    value: 'studio',
                    child: Text('Căn hộ Studio'),
                  ),
                  DropdownMenuItem(
                    value: 'dorm',
                    child: Text('Ký túc xá'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<AddRoomCubit>().setPropertyType(value);
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.apartment),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF5A5F),
                      width: 2,
                    ),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Color(0xFFFF5A5F),
                  ),
                  labelText: 'Loại phòng',
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          // Tiện ích
          const SectionTitle(title: 'Tiện ích'),
          BlocBuilder<AddRoomCubit, AddRoomState>(
            builder: (context, state) {
              if (state is PropertyLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AmenitiesLoadSuccess) {
                return AmenitiesSelector(
                  availableAmenities: state.availableAmenities,
                  selectedAmenities: state.selectedAmenities,
                  onSelected: (amenity, selected) {
                    context.read<AddRoomCubit>().toggleAmenity(amenity);
                  },
                );
              } else if (state is PropertyError) {
                return Column(
                  children: [
                    Text(
                      'Không thể tải danh sách tiện ích: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AddRoomCubit>().loadAmenities();
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Đang tải danh sách tiện ích...'),
                );
              }
            },
          ),

          const SizedBox(height: 32),

          // Nút lưu
          BlocBuilder<AddRoomCubit, AddRoomState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: state is PropertyLoading
                      ? null
                      : () => _submitForm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: state is PropertyLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Đăng chỗ ở mới',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _pickImages(BuildContext context) async {
    final pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      for (var file in pickedFiles) {
        _images.add(File(file.path));
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã chọn ${pickedFiles.length} ảnh'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn ít nhất 1 hình ảnh'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final state = context.read<AddRoomCubit>().state;
      if (state is AmenitiesLoadSuccess && state.selectedAmenities.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn ít nhất 1 tiện ích'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final property = Property(
        title: _titleController.text,
        description: _descriptionController.text,
        location: _addressController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        bedrooms: int.tryParse(_bedroomsController.text) ?? 0,
        bathrooms: int.tryParse(_bathroomsController.text) ?? 0,
        area: double.tryParse(_areaController.text) ?? 0.0,
        deposit: double.tryParse(_depositController.text) ?? 0.0,
        typeRestroom: _selectedTypeRestroom,
        propertyType: _propertyTypeController.text.isEmpty ? 'apartment' : _propertyTypeController.text,
      );
      context.read<AddRoomCubit>().addRoom(
        property,
        _images,
        state is AmenitiesLoadSuccess ? state.selectedAmenities : [],
      );
    }
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFFFF5A5F),
              width: 2,
            ),
          ),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFFFF5A5F),
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class ImagePickerSection extends StatelessWidget {
  final List<File> images;
  final VoidCallback onPickImages;

  const ImagePickerSection({
    Key? key,
    required this.images,
    required this.onPickImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (images.isEmpty)
          InkWell(
            onTap: onPickImages,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Thêm hình ảnh',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.85,
                  enlargeCenterPage: true,
                ),
                items: images.map((file) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(file),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                images.remove(file);
                                // Force a rebuild by calling setState on the nearest StatefulWidget
                                // This is a limitation when using stateless widgets - you may need a callback
                                // to a parent stateful widget or use a state management solution
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: TextButton.icon(
                  onPressed: onPickImages,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Thêm hình ảnh'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFFF5A5F),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class AmenitiesSelector extends StatelessWidget {
  final List<AllAmenity> availableAmenities;
  final List<AllAmenity> selectedAmenities;
  final Function(AllAmenity, bool) onSelected;

  const AmenitiesSelector({
    Key? key,
    required this.availableAmenities,
    required this.selectedAmenities,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: availableAmenities.map((amenity) {
        final isSelected = selectedAmenities.any((a) => a.id == amenity.id);
        return FilterChip(
          label: Text(amenity.nameAmenities),
          selected: isSelected,
          onSelected: (selected) => onSelected(amenity, selected),
          avatar: Icon(_getIconData(amenity.iconAmenities)),
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFFFFECED),
          checkmarkColor: const Color(0xFFFF5A5F),
          side: BorderSide(
            color: isSelected ? const Color(0xFFFF5A5F) : Colors.grey.shade300,
          ),
          labelStyle: TextStyle(
            color: isSelected ? const Color(0xFFFF5A5F) : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'wifi':
        return Icons.wifi;
      case 'pool':
        return Icons.pool;
      case 'local_laundry_service':
        return Icons.local_laundry_service;
      case 'kitchen':
        return Icons.kitchen;
      case 'tv':
        return Icons.tv;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'local_parking':
        return Icons.local_parking;
      case 'elevator':
        return Icons.elevator;
      case 'microwave':
        return Icons.microwave;
      case 'balcony':
        return Icons.balcony;
      case 'bathtub':
        return Icons.bathtub;
      case 'air-conditioning-ind':
        return Icons.ac_unit;
      case 'bath':
        return Icons.bathtub;
      default:
        return Icons.star;
    }
  }
}
