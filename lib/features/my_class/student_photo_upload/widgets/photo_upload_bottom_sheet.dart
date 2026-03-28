import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';

class PhotoUploadBottomSheet extends StatelessWidget {
  final String studentName;
  final String? photoUrl;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onView;

  const PhotoUploadBottomSheet({
    super.key,
    required this.studentName,
    this.photoUrl,
    required this.onCamera,
    required this.onGallery,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.scale(20)),
          topRight: Radius.circular(context.scale(20)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                Expanded(
                  child: Text(
                    studentName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.scaleFont(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: context.scale(48)),
              ],
            ),
            const Divider(),
            SizedBox(height: context.scaleHeight(16)),
            // Big Center Image
            Center(
              child: Container(
                width: context.scale(160),
                height: context.scale(160),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: photoUrl != null
                      ? DecorationImage(
                          image: NetworkImage(photoUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey.shade100,
                ),
                child: photoUrl == null
                    ? Icon(
                        Icons.person,
                        size: context.scale(80),
                        color: Colors.grey.shade400,
                      )
                    : null,
              ),
            ),
            SizedBox(height: context.scaleHeight(24)),
            _buildOption(
              context,
              icon: Icons.image_outlined,
              title: 'View Photo',
              onTap: onView,
            ),
            _buildOption(
              context,
              icon: Icons.camera_alt_outlined,
              title: 'Take Photo',
              onTap: onCamera,
            ),
            _buildOption(
              context,
              icon: Icons.photo_library_outlined,
              title: 'Choose From Gallery',
              onTap: onGallery,
            ),
            SizedBox(height: context.scaleHeight(10)),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(15)),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue.shade700, size: context.scale(24)),
            SizedBox(width: context.scale(15)),
            Text(
              title,
              style: TextStyle(
                fontSize: context.scaleFont(15),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showPhotoUploadBottomSheet({
  required BuildContext context,
  required String studentName,
  String? photoUrl,
  required VoidCallback onCamera,
  required VoidCallback onGallery,
  required VoidCallback onView,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => PhotoUploadBottomSheet(
      studentName: studentName,
      photoUrl: photoUrl,
      onCamera: onCamera,
      onGallery: onGallery,
      onView: onView,
    ),
  );
}
