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

import 'bloc/add_video_bloc.dart';
import 'bloc/add_video_event.dart';
import 'bloc/add_video_state.dart';

@RoutePage()
class AddVideoPage extends StatelessWidget {
  const AddVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddVideoBloc(),
      child: const _AddVideoContent(),
    );
  }
}

class _AddVideoContent extends StatelessWidget {
  const _AddVideoContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Add Videos'),
      body: BlocListener<AddVideoBloc, AddVideoState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Video album created successfully!'),
              ),
            );
            context.router.maybePopTop();
          }
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(20),
            vertical: context.scaleHeight(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel('Album Title', isRequired: true),
              SizedBox(height: context.scaleHeight(12)),
              const _TitleField(),
              SizedBox(height: context.scaleHeight(24)),
              BlocSelector<AddVideoBloc, AddVideoState, int>(
                selector: (state) => state.videos.length,
                builder: (context, count) {
                  return _SectionLabel(
                    'Select Videos ($count/10)',
                    isRequired: true,
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(12)),
              const _VideoPickerSection(),
              SizedBox(height: context.scaleHeight(24)),
              const _SelectedVideosList(),
              SizedBox(height: context.scaleHeight(40)),
              const _SubmitButton(),
            ],
          ),
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
      hintText: 'Enter video album title',
      onChanged: (val) {
        context.read<AddVideoBloc>().add(TitleChanged(val));
      },
    );
  }
}

class _VideoPickerSection extends StatelessWidget {
  const _VideoPickerSection();

  @override
  Widget build(BuildContext context) {
    return AppDashedUploadButton(
      icon: Icons.video_call_outlined,
      label: 'Upload Videos',
      onTap: () async {
        final picker = ImagePicker();
        final XFile? video = await picker.pickVideo(
          source: ImageSource.gallery,
        );
        if (video != null && context.mounted) {
          context.read<AddVideoBloc>().add(VideosSelected([video]));
        }
      },
    );
  }
}

class _SelectedVideosList extends StatelessWidget {
  const _SelectedVideosList();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddVideoBloc, AddVideoState, List<XFile>>(
      selector: (state) => state.videos,
      builder: (context, videos) {
        if (videos.isEmpty) return const SizedBox.shrink();

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: context.scaleHeight(12)),
          itemBuilder: (context, index) {
            return _VideoItem(video: videos[index], index: index);
          },
        );
      },
    );
  }
}

class _VideoItem extends StatelessWidget {
  final XFile video;
  final int index;

  const _VideoItem({required this.video, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          Icon(Icons.movie_outlined, color: context.colors.primary),
          SizedBox(width: context.scale(12)),
          Expanded(
            child: Text(
              video.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                color: context.colors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<AddVideoBloc>().add(VideoRemoved(index));
            },
            icon: Icon(Icons.close, color: Colors.red, size: context.scale(20)),
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVideoBloc, AddVideoState>(
      builder: (context, state) {
        return AppPrimaryButton(
          onPressed: (state.isLoading || !state.isFormValid)
              ? null
              : () {
                  context.read<AddVideoBloc>().add(SubmitVideo());
                },
          text: state.isLoading ? 'UPLOADING...' : 'SAVE VIDEOS',
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
