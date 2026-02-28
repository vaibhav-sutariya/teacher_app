import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/show_snackbar.dart';

class AppImagePicker {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImage({
    required BuildContext context,
    required ImageSource source,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Optimize image size
      );

      return image?.path;
    } catch (e) {
      if (context.mounted) {
        showFlushbar(
          context: context,
          message: 'Failed to pick image: $e',
          isError: true,
        );
      }
      return null;
    }
  }

  Future<void> showImagePickerOption(
    BuildContext context, {
    required Function(String) onImageSelected,
  }) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final path = await pickImage(
                    context: context,
                    source: ImageSource.gallery,
                  );
                  if (path != null) {
                    onImageSelected(path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final path = await pickImage(
                    context: context,
                    source: ImageSource.camera,
                  );
                  if (path != null) {
                    onImageSelected(path);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
