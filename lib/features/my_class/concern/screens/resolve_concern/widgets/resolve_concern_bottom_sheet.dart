import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../core/widgets/app_primary_button.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../core/widgets/app_dashed_upload_button.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../../../models/concern_model.dart';
import '../bloc/resolve_concern_bloc.dart';
import '../bloc/resolve_concern_event.dart';
import '../bloc/resolve_concern_state.dart';

class ResolveConcernBottomSheet extends StatelessWidget {
  final ConcernModel concern;

  const ResolveConcernBottomSheet({super.key, required this.concern});

  static Future<bool?> show(BuildContext context, ConcernModel concern) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ResolveConcernBottomSheet(concern: concern),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResolveConcernBloc(),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface100,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.scale(24)),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocListener<ResolveConcernBloc, ResolveConcernState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pop(context, true);
            }
            if (state.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.scale(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: context.scaleHeight(24)),
                const _SectionLabel('Update Status'),
                SizedBox(height: context.scaleHeight(12)),
                const _StatusSelection(),
                SizedBox(height: context.scaleHeight(24)),
                const _SectionLabel('Resolution Comment', isRequired: true),
                SizedBox(height: context.scaleHeight(12)),
                const _CommentField(),
                SizedBox(height: context.scaleHeight(24)),
                const _ProofImagesSection(),
                SizedBox(height: context.scaleHeight(32)),
                _SubmitButton(concernId: concern.id),
                SizedBox(height: context.scaleHeight(16)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Take Action',
          style: TextStyle(
            fontSize: context.scaleFont(20),
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}

class _StatusSelection extends StatelessWidget {
  const _StatusSelection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ResolveConcernBloc, ResolveConcernState, ConcernStatus>(
      selector: (state) => state.status,
      builder: (context, currentStatus) {
        return Row(
          children: [
            _StatusChip(
              label: 'In Process',
              isSelected: currentStatus == ConcernStatus.inProcess,
              onSelected: () {
                context.read<ResolveConcernBloc>().add(
                  const StatusChanged(ConcernStatus.inProcess),
                );
              },
              activeColor: const Color(0xFF1565C0),
            ),
            SizedBox(width: context.scale(12)),
            _StatusChip(
              label: 'Closed',
              isSelected: currentStatus == ConcernStatus.closed,
              onSelected: () {
                context.read<ResolveConcernBloc>().add(
                  const StatusChanged(ConcernStatus.closed),
                );
              },
              activeColor: const Color(0xFFC62828),
            ),
          ],
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;
  final Color activeColor;

  const _StatusChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(20),
          vertical: context.scale(10),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(context.scale(30)),
          border: Border.all(
            color: isSelected ? activeColor : context.colors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.scaleFont(14),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? activeColor : context.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CommentField extends StatelessWidget {
  const _CommentField();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Describe how you resolved this issue...',
      maxLines: 4,
      onChanged: (val) {
        context.read<ResolveConcernBloc>().add(CommentChanged(val));
      },
    );
  }
}

class _ProofImagesSection extends StatelessWidget {
  const _ProofImagesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocSelector<ResolveConcernBloc, ResolveConcernState, int>(
          selector: (state) => state.proofImages.length,
          builder: (context, count) {
            return _SectionLabel('Proof Images (Optional, $count/5)');
          },
        ),
        SizedBox(height: context.scaleHeight(12)),
        const _ImagePickerArea(),
      ],
    );
  }
}

class _ImagePickerArea extends StatelessWidget {
  const _ImagePickerArea();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ResolveConcernBloc, ResolveConcernState, List<XFile>>(
      selector: (state) => state.proofImages,
      builder: (context, images) {
        return Column(
          children: [
            if (images.length < 5)
              RepaintBoundary(
                child: AppDashedUploadButton(
                  icon: Icons.add_a_photo_outlined,
                  label: 'Add Proof',
                  onTap: () async {
                    final picker = ImagePicker();
                    final List<XFile> picked = await picker.pickMultiImage();
                    if (picked.isNotEmpty && context.mounted) {
                      context.read<ResolveConcernBloc>().add(
                        ImagesAdded(picked),
                      );
                    }
                  },
                ),
              ),
            if (images.isNotEmpty) ...[
              SizedBox(height: context.scaleHeight(16)),
              SizedBox(
                height: context.scaleHeight(80),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return _ImagePreviewItem(
                      image: images[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ImagePreviewItem extends StatelessWidget {
  final XFile image;
  final int index;

  const _ImagePreviewItem({required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: context.scale(12)),
      width: context.scale(80),
      height: context.scale(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.scale(12)),
        image: DecorationImage(
          image: FileImage(File(image.path)),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 2,
            right: 2,
            child: GestureDetector(
              onTap: () {
                context.read<ResolveConcernBloc>().add(ImageRemoved(index));
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String concernId;
  const _SubmitButton({required this.concernId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ResolveConcernBloc, ResolveConcernState, (bool, bool)>(
      selector: (state) => (state.isLoading, state.isFormValid),
      builder: (context, data) {
        final isLoading = data.$1;
        final isFormValid = data.$2;

        return AppPrimaryButton(
          onPressed: (isLoading || !isFormValid)
              ? null
              : () {
                  context.read<ResolveConcernBloc>().add(
                    SubmitResolution(concernId),
                  );
                },
          text: isLoading ? 'SUBMITTING...' : 'RESOLVE CONCERN',
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const _SectionLabel(this.text, {this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: context.scaleFont(14),
            fontWeight: FontWeight.w600,
            color: context.colors.textPrimary,
          ),
        ),
        if (isRequired)
          Text(
            '*',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
