import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_dashed_upload_button.dart';
import 'package:teachers_app/core/widgets/app_primary_button.dart';
import 'package:teachers_app/core/widgets/app_text_field.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../bloc/add_gallery_bloc.dart';
import '../bloc/add_gallery_event.dart';
import '../bloc/add_gallery_state.dart';

@RoutePage()
class AddGalleryPage extends StatelessWidget {
  const AddGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddGalleryBloc(),
      child: const _AddGalleryContent(),
    );
  }
}

class _AddGalleryContent extends StatelessWidget {
  const _AddGalleryContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Add Gallery Images'),
      body: BlocListener<AddGalleryBloc, AddGalleryState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gallery created successfully!')),
            );
            context.router.maybePopTop();
          }
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        child: CustomScrollView(
          cacheExtent: 1000,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(20),
                vertical: context.scaleHeight(20),
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _SectionLabel('Album Title', isRequired: true),
                  SizedBox(height: context.scaleHeight(12)),
                  const _TitleField(),
                  SizedBox(height: context.scaleHeight(24)),
                  const _ImageCountLabel(),
                  SizedBox(height: context.scaleHeight(12)),
                  const _ImagePickerSection(),
                  SizedBox(height: context.scaleHeight(24)),
                ]),
              ),
            ),
            const _SelectedImagesGrid(),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(20),
                vertical: context.scaleHeight(40),
              ),
              sliver: const SliverToBoxAdapter(child: _SubmitButton()),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Enter album title',
      onChanged: (val) {
        context.read<AddGalleryBloc>().add(TitleChanged(val));
      },
    );
  }
}

class _ImageCountLabel extends StatelessWidget {
  const _ImageCountLabel();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddGalleryBloc, AddGalleryState, int>(
      selector: (state) => state.images.length,
      builder: (context, count) {
        return _SectionLabel(
          'Select Images (Count: $count / Max: 40)',
          isRequired: true,
        );
      },
    );
  }
}

class _ImagePickerSection extends StatelessWidget {
  const _ImagePickerSection();

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(child: _ImagePickerButton());
  }
}

class _ImagePickerButton extends StatelessWidget {
  const _ImagePickerButton();

  @override
  Widget build(BuildContext context) {
    return AppDashedUploadButton(
      icon: Icons.add_photo_alternate_outlined,
      label: 'Upload Photos',
      onTap: () async {
        final picker = ImagePicker();
        final List<XFile> images = await picker.pickMultiImage();
        if (images.isNotEmpty && context.mounted) {
          context.read<AddGalleryBloc>().add(ImagesSelected(images));
        }
      },
    );
  }
}

class _SelectedImagesGrid extends StatelessWidget {
  const _SelectedImagesGrid();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddGalleryBloc, AddGalleryState, List<XFile>>(
      selector: (state) => state.images,
      builder: (context, images) {
        if (images.isEmpty)
          return const SliverToBoxAdapter(child: SizedBox.shrink());

        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: context.scale(20)),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: context.scale(12),
              mainAxisSpacing: context.scaleHeight(12),
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return RepaintBoundary(
                child: _ImageItem(image: images[index], index: index),
              );
            }, childCount: images.length),
          ),
        );
      },
    );
  }
}

class _ImageItem extends StatelessWidget {
  final XFile image;
  final int index;

  const _ImageItem({required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(context.scale(12)),
          child: Image.file(
            File(image.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              context.read<AddGalleryBloc>().add(ImageRemoved(index));
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: context.scale(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddGalleryBloc, AddGalleryState, (bool, bool)>(
      selector: (state) => (state.isLoading, state.isFormValid),
      builder: (context, data) {
        final isLoading = data.$1;
        final isFormValid = data.$2;
        return AppPrimaryButton(
          onPressed: (isLoading || !isFormValid)
              ? null
              : () {
                  context.read<AddGalleryBloc>().add(SubmitGallery());
                },
          text: isLoading ? 'UPLOADING...' : 'SAVE GALLERY',
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
