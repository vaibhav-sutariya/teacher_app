// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i67;
import 'package:collection/collection.dart' as _i72;
import 'package:flutter/material.dart' as _i68;
import 'package:teachers_app/core/widgets/app_web_view_page.dart' as _i5;
import 'package:teachers_app/core/widgets/scroll_aware_bottom_bar_controller.dart'
    as _i73;
import 'package:teachers_app/features/auth/screens/forgot_password/ui/forgot_password_page.dart'
    as _i18;
import 'package:teachers_app/features/auth/screens/forgot_password/ui/new_password_page.dart'
    as _i33;
import 'package:teachers_app/features/auth/screens/forgot_password/ui/password_success_page.dart'
    as _i39;
import 'package:teachers_app/features/auth/screens/login/ui/login_page.dart'
    as _i29;
import 'package:teachers_app/features/auth/screens/password_login/ui/password_login_page.dart'
    as _i38;
import 'package:teachers_app/features/auth/screens/verification/ui/verification_page.dart'
    as _i62;
import 'package:teachers_app/features/dashboard/dashboard_page.dart' as _i15;
import 'package:teachers_app/features/home/home_page.dart' as _i24;
import 'package:teachers_app/features/my_class/achievement/achievement_page.dart'
    as _i2;
import 'package:teachers_app/features/my_class/assignment/assignment_page.dart'
    as _i6;
import 'package:teachers_app/features/my_class/attendance/attendance_page.dart'
    as _i8;
import 'package:teachers_app/features/my_class/attendance_entry/attendance_entry_page.dart'
    as _i7;
import 'package:teachers_app/features/my_class/birthday/birthday_page.dart'
    as _i9;
import 'package:teachers_app/features/my_class/calendar/calendar_page.dart'
    as _i10;
import 'package:teachers_app/features/my_class/class_test/class_test_page.dart'
    as _i11;
import 'package:teachers_app/features/my_class/classwork/classwork_page.dart'
    as _i12;
import 'package:teachers_app/features/my_class/concern/add_concern/add_concern_page.dart'
    as _i3;
import 'package:teachers_app/features/my_class/concern/concern_details/concern_details_page.dart'
    as _i13;
import 'package:teachers_app/features/my_class/concern/concern_page.dart'
    as _i14;
import 'package:teachers_app/features/my_class/concern/models/concern_model.dart'
    as _i69;
import 'package:teachers_app/features/my_class/employee_photo/employee_photo_page.dart'
    as _i16;
import 'package:teachers_app/features/my_class/exam_time_table/ui/exam_time_table_page.dart'
    as _i17;
import 'package:teachers_app/features/my_class/gallery/gallery_details_screen/gallery_detail_page.dart'
    as _i19;
import 'package:teachers_app/features/my_class/gallery/gallery_screen/gallery_page.dart'
    as _i21;
import 'package:teachers_app/features/my_class/gallery/gallery_screen/models/gallery_image_model.dart'
    as _i71;
import 'package:teachers_app/features/my_class/gallery/gallery_screen/models/gallery_model.dart'
    as _i70;
import 'package:teachers_app/features/my_class/gallery/viewer_screen/gallery_image_viewer_page.dart'
    as _i20;
import 'package:teachers_app/features/my_class/gate_pass/gate_pass_page.dart'
    as _i22;
import 'package:teachers_app/features/my_class/holiday_hw/holiday_hw_page.dart'
    as _i23;
import 'package:teachers_app/features/my_class/homework/add_homework/homework_entry_page.dart'
    as _i25;
import 'package:teachers_app/features/my_class/homework/homework/homework_page.dart'
    as _i26;
import 'package:teachers_app/features/my_class/leave/add_leave/add_leave_page.dart'
    as _i4;
import 'package:teachers_app/features/my_class/leave/leave_detail_screen/leave_detail_page.dart'
    as _i27;
import 'package:teachers_app/features/my_class/leave/leave_screen/leave_page.dart'
    as _i28;
import 'package:teachers_app/features/my_class/meal_menu/meal_menu_page.dart'
    as _i30;
import 'package:teachers_app/features/my_class/my_class_screen/my_class_page.dart'
    as _i31;
import 'package:teachers_app/features/my_class/new_admission/new_admission_page.dart'
    as _i32;
import 'package:teachers_app/features/my_class/paper/paper_page.dart' as _i36;
import 'package:teachers_app/features/my_class/parent_photo/parent_photo_page.dart'
    as _i37;
import 'package:teachers_app/features/my_class/ptm/ptm_page.dart' as _i42;
import 'package:teachers_app/features/my_class/remarks/remark_details_screen/remark_detail_page.dart'
    as _i43;
import 'package:teachers_app/features/my_class/remarks/remarks_screen/models/remark_model.dart'
    as _i74;
import 'package:teachers_app/features/my_class/remarks/remarks_screen/remarks_page.dart'
    as _i45;
import 'package:teachers_app/features/my_class/remarks_entry/bloc/remarks_entry_bloc.dart'
    as _i75;
import 'package:teachers_app/features/my_class/remarks_entry/remarks_entry_page.dart'
    as _i44;
import 'package:teachers_app/features/my_class/remarks_entry/remarks_student_selection_page.dart'
    as _i46;
import 'package:teachers_app/features/my_class/report_card/report_card_page.dart'
    as _i47;
import 'package:teachers_app/features/my_class/student_info/student_info_page.dart'
    as _i52;
import 'package:teachers_app/features/my_class/student_notice/student_notice_page.dart'
    as _i53;
import 'package:teachers_app/features/my_class/student_photo_upload/student_photo_upload_page.dart'
    as _i54;
import 'package:teachers_app/features/my_class/subject_wise_homework/add_homework/subject_wise_homework_entry_page.dart'
    as _i56;
import 'package:teachers_app/features/my_class/subject_wise_homework/classes/subject_wise_homework_page.dart'
    as _i57;
import 'package:teachers_app/features/my_class/subject_wise_homework/subjects/subject_wise_homework_subject_page.dart'
    as _i58;
import 'package:teachers_app/features/my_class/syllabus/syllabus_page.dart'
    as _i59;
import 'package:teachers_app/features/my_class/time_table/ui/time_table_page.dart'
    as _i60;
import 'package:teachers_app/features/my_class/transport_attendance/transport_attendance_page.dart'
    as _i61;
import 'package:teachers_app/features/my_class/videos/detail/video_detail_page.dart'
    as _i63;
import 'package:teachers_app/features/my_class/videos/videos_screen/models/video_item_model.dart'
    as _i77;
import 'package:teachers_app/features/my_class/videos/videos_screen/models/video_model.dart'
    as _i76;
import 'package:teachers_app/features/my_class/videos/videos_screen/videos_page.dart'
    as _i65;
import 'package:teachers_app/features/my_class/videos/viewer_screen/video_viewer_page.dart'
    as _i64;
import 'package:teachers_app/features/my_class/view_transport_attendance/view_transport_attendance_page.dart'
    as _i66;
import 'package:teachers_app/features/notifications/notification_page.dart'
    as _i34;
import 'package:teachers_app/features/onboarding/onboarding_page.dart' as _i35;
import 'package:teachers_app/features/pdf_viewer/pdf_viewer_page.dart' as _i40;
import 'package:teachers_app/features/profile/about_app/about_app_page.dart'
    as _i1;
import 'package:teachers_app/features/profile/profile_page/profile_page.dart'
    as _i41;
import 'package:teachers_app/features/profile/reset_password/reset_password_page.dart'
    as _i48;
import 'package:teachers_app/features/profile/student_profile/student_profile_page.dart'
    as _i55;
import 'package:teachers_app/features/school/school_page.dart' as _i49;
import 'package:teachers_app/features/service/service_page.dart' as _i50;
import 'package:teachers_app/features/splash/screens/ui/splash_screen.dart'
    as _i51;

/// generated route for
/// [_i1.AboutAppPage]
class AboutAppRoute extends _i67.PageRouteInfo<void> {
  const AboutAppRoute({List<_i67.PageRouteInfo>? children})
    : super(AboutAppRoute.name, initialChildren: children);

  static const String name = 'AboutAppRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutAppPage();
    },
  );
}

/// generated route for
/// [_i2.AchievementPage]
class AchievementRoute extends _i67.PageRouteInfo<void> {
  const AchievementRoute({List<_i67.PageRouteInfo>? children})
    : super(AchievementRoute.name, initialChildren: children);

  static const String name = 'AchievementRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i2.AchievementPage();
    },
  );
}

/// generated route for
/// [_i3.AddConcernPage]
class AddConcernRoute extends _i67.PageRouteInfo<void> {
  const AddConcernRoute({List<_i67.PageRouteInfo>? children})
    : super(AddConcernRoute.name, initialChildren: children);

  static const String name = 'AddConcernRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i3.AddConcernPage();
    },
  );
}

/// generated route for
/// [_i4.AddLeavePage]
class AddLeaveRoute extends _i67.PageRouteInfo<void> {
  const AddLeaveRoute({List<_i67.PageRouteInfo>? children})
    : super(AddLeaveRoute.name, initialChildren: children);

  static const String name = 'AddLeaveRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i4.AddLeavePage();
    },
  );
}

/// generated route for
/// [_i5.AppWebViewPage]
class AppWebViewRoute extends _i67.PageRouteInfo<AppWebViewRouteArgs> {
  AppWebViewRoute({
    _i68.Key? key,
    required String url,
    required String title,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         AppWebViewRoute.name,
         args: AppWebViewRouteArgs(key: key, url: url, title: title),
         initialChildren: children,
       );

  static const String name = 'AppWebViewRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppWebViewRouteArgs>();
      return _i5.AppWebViewPage(
        key: args.key,
        url: args.url,
        title: args.title,
      );
    },
  );
}

class AppWebViewRouteArgs {
  const AppWebViewRouteArgs({this.key, required this.url, required this.title});

  final _i68.Key? key;

  final String url;

  final String title;

  @override
  String toString() {
    return 'AppWebViewRouteArgs{key: $key, url: $url, title: $title}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppWebViewRouteArgs) return false;
    return key == other.key && url == other.url && title == other.title;
  }

  @override
  int get hashCode => key.hashCode ^ url.hashCode ^ title.hashCode;
}

/// generated route for
/// [_i6.AssignmentPage]
class AssignmentRoute extends _i67.PageRouteInfo<void> {
  const AssignmentRoute({List<_i67.PageRouteInfo>? children})
    : super(AssignmentRoute.name, initialChildren: children);

  static const String name = 'AssignmentRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i6.AssignmentPage();
    },
  );
}

/// generated route for
/// [_i7.AttendanceEntryPage]
class AttendanceEntryRoute
    extends _i67.PageRouteInfo<AttendanceEntryRouteArgs> {
  AttendanceEntryRoute({
    _i68.Key? key,
    required String className,
    required DateTime date,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         AttendanceEntryRoute.name,
         args: AttendanceEntryRouteArgs(
           key: key,
           className: className,
           date: date,
         ),
         initialChildren: children,
       );

  static const String name = 'AttendanceEntryRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AttendanceEntryRouteArgs>();
      return _i7.AttendanceEntryPage(
        key: args.key,
        className: args.className,
        date: args.date,
      );
    },
  );
}

class AttendanceEntryRouteArgs {
  const AttendanceEntryRouteArgs({
    this.key,
    required this.className,
    required this.date,
  });

  final _i68.Key? key;

  final String className;

  final DateTime date;

  @override
  String toString() {
    return 'AttendanceEntryRouteArgs{key: $key, className: $className, date: $date}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AttendanceEntryRouteArgs) return false;
    return key == other.key &&
        className == other.className &&
        date == other.date;
  }

  @override
  int get hashCode => key.hashCode ^ className.hashCode ^ date.hashCode;
}

/// generated route for
/// [_i8.AttendancePage]
class AttendanceRoute extends _i67.PageRouteInfo<void> {
  const AttendanceRoute({List<_i67.PageRouteInfo>? children})
    : super(AttendanceRoute.name, initialChildren: children);

  static const String name = 'AttendanceRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i8.AttendancePage();
    },
  );
}

/// generated route for
/// [_i9.BirthdayPage]
class BirthdayRoute extends _i67.PageRouteInfo<void> {
  const BirthdayRoute({List<_i67.PageRouteInfo>? children})
    : super(BirthdayRoute.name, initialChildren: children);

  static const String name = 'BirthdayRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i9.BirthdayPage();
    },
  );
}

/// generated route for
/// [_i10.CalendarPage]
class CalendarRoute extends _i67.PageRouteInfo<void> {
  const CalendarRoute({List<_i67.PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i10.CalendarPage();
    },
  );
}

/// generated route for
/// [_i11.ClassTestPage]
class ClassTestRoute extends _i67.PageRouteInfo<void> {
  const ClassTestRoute({List<_i67.PageRouteInfo>? children})
    : super(ClassTestRoute.name, initialChildren: children);

  static const String name = 'ClassTestRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i11.ClassTestPage();
    },
  );
}

/// generated route for
/// [_i12.ClassworkPage]
class ClassworkRoute extends _i67.PageRouteInfo<void> {
  const ClassworkRoute({List<_i67.PageRouteInfo>? children})
    : super(ClassworkRoute.name, initialChildren: children);

  static const String name = 'ClassworkRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i12.ClassworkPage();
    },
  );
}

/// generated route for
/// [_i13.ConcernDetailsPage]
class ConcernDetailsRoute extends _i67.PageRouteInfo<ConcernDetailsRouteArgs> {
  ConcernDetailsRoute({
    _i68.Key? key,
    required _i69.ConcernModel concern,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         ConcernDetailsRoute.name,
         args: ConcernDetailsRouteArgs(key: key, concern: concern),
         initialChildren: children,
       );

  static const String name = 'ConcernDetailsRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConcernDetailsRouteArgs>();
      return _i13.ConcernDetailsPage(key: args.key, concern: args.concern);
    },
  );
}

class ConcernDetailsRouteArgs {
  const ConcernDetailsRouteArgs({this.key, required this.concern});

  final _i68.Key? key;

  final _i69.ConcernModel concern;

  @override
  String toString() {
    return 'ConcernDetailsRouteArgs{key: $key, concern: $concern}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ConcernDetailsRouteArgs) return false;
    return key == other.key && concern == other.concern;
  }

  @override
  int get hashCode => key.hashCode ^ concern.hashCode;
}

/// generated route for
/// [_i14.ConcernPage]
class ConcernRoute extends _i67.PageRouteInfo<void> {
  const ConcernRoute({List<_i67.PageRouteInfo>? children})
    : super(ConcernRoute.name, initialChildren: children);

  static const String name = 'ConcernRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i14.ConcernPage();
    },
  );
}

/// generated route for
/// [_i15.DashboardPage]
class DashboardRoute extends _i67.PageRouteInfo<void> {
  const DashboardRoute({List<_i67.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i15.DashboardPage();
    },
  );
}

/// generated route for
/// [_i16.EmployeePhotoPage]
class EmployeePhotoRoute extends _i67.PageRouteInfo<void> {
  const EmployeePhotoRoute({List<_i67.PageRouteInfo>? children})
    : super(EmployeePhotoRoute.name, initialChildren: children);

  static const String name = 'EmployeePhotoRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i16.EmployeePhotoPage();
    },
  );
}

/// generated route for
/// [_i17.ExamTimeTablePage]
class ExamTimeTableRoute extends _i67.PageRouteInfo<void> {
  const ExamTimeTableRoute({List<_i67.PageRouteInfo>? children})
    : super(ExamTimeTableRoute.name, initialChildren: children);

  static const String name = 'ExamTimeTableRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return _i67.WrappedRoute(child: const _i17.ExamTimeTablePage());
    },
  );
}

/// generated route for
/// [_i18.ForgotPasswordPage]
class ForgotPasswordRoute extends _i67.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i67.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i18.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i19.GalleryDetailPage]
class GalleryDetailRoute extends _i67.PageRouteInfo<GalleryDetailRouteArgs> {
  GalleryDetailRoute({
    _i68.Key? key,
    required _i70.GalleryModel gallery,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         GalleryDetailRoute.name,
         args: GalleryDetailRouteArgs(key: key, gallery: gallery),
         initialChildren: children,
       );

  static const String name = 'GalleryDetailRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GalleryDetailRouteArgs>();
      return _i19.GalleryDetailPage(key: args.key, gallery: args.gallery);
    },
  );
}

class GalleryDetailRouteArgs {
  const GalleryDetailRouteArgs({this.key, required this.gallery});

  final _i68.Key? key;

  final _i70.GalleryModel gallery;

  @override
  String toString() {
    return 'GalleryDetailRouteArgs{key: $key, gallery: $gallery}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GalleryDetailRouteArgs) return false;
    return key == other.key && gallery == other.gallery;
  }

  @override
  int get hashCode => key.hashCode ^ gallery.hashCode;
}

/// generated route for
/// [_i20.GalleryImageViewerPage]
class GalleryImageViewerRoute
    extends _i67.PageRouteInfo<GalleryImageViewerRouteArgs> {
  GalleryImageViewerRoute({
    _i68.Key? key,
    required String galleryId,
    required int initialIndex,
    List<_i71.GalleryImageModel>? images,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         GalleryImageViewerRoute.name,
         args: GalleryImageViewerRouteArgs(
           key: key,
           galleryId: galleryId,
           initialIndex: initialIndex,
           images: images,
         ),
         initialChildren: children,
       );

  static const String name = 'GalleryImageViewerRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GalleryImageViewerRouteArgs>();
      return _i20.GalleryImageViewerPage(
        key: args.key,
        galleryId: args.galleryId,
        initialIndex: args.initialIndex,
        images: args.images,
      );
    },
  );
}

class GalleryImageViewerRouteArgs {
  const GalleryImageViewerRouteArgs({
    this.key,
    required this.galleryId,
    required this.initialIndex,
    this.images,
  });

  final _i68.Key? key;

  final String galleryId;

  final int initialIndex;

  final List<_i71.GalleryImageModel>? images;

  @override
  String toString() {
    return 'GalleryImageViewerRouteArgs{key: $key, galleryId: $galleryId, initialIndex: $initialIndex, images: $images}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GalleryImageViewerRouteArgs) return false;
    return key == other.key &&
        galleryId == other.galleryId &&
        initialIndex == other.initialIndex &&
        const _i72.ListEquality<_i71.GalleryImageModel>().equals(
          images,
          other.images,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      galleryId.hashCode ^
      initialIndex.hashCode ^
      const _i72.ListEquality<_i71.GalleryImageModel>().hash(images);
}

/// generated route for
/// [_i21.GalleryPage]
class GalleryRoute extends _i67.PageRouteInfo<void> {
  const GalleryRoute({List<_i67.PageRouteInfo>? children})
    : super(GalleryRoute.name, initialChildren: children);

  static const String name = 'GalleryRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i21.GalleryPage();
    },
  );
}

/// generated route for
/// [_i22.GatePassPage]
class GatePassRoute extends _i67.PageRouteInfo<void> {
  const GatePassRoute({List<_i67.PageRouteInfo>? children})
    : super(GatePassRoute.name, initialChildren: children);

  static const String name = 'GatePassRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i22.GatePassPage();
    },
  );
}

/// generated route for
/// [_i23.HolidayHwPage]
class HolidayHwRoute extends _i67.PageRouteInfo<void> {
  const HolidayHwRoute({List<_i67.PageRouteInfo>? children})
    : super(HolidayHwRoute.name, initialChildren: children);

  static const String name = 'HolidayHwRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i23.HolidayHwPage();
    },
  );
}

/// generated route for
/// [_i24.HomePage]
class HomeRoute extends _i67.PageRouteInfo<void> {
  const HomeRoute({List<_i67.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i24.HomePage();
    },
  );
}

/// generated route for
/// [_i25.HomeworkEntryPage]
class HomeworkEntryRoute extends _i67.PageRouteInfo<HomeworkEntryRouteArgs> {
  HomeworkEntryRoute({
    _i68.Key? key,
    required String className,
    required DateTime selectedDate,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         HomeworkEntryRoute.name,
         args: HomeworkEntryRouteArgs(
           key: key,
           className: className,
           selectedDate: selectedDate,
         ),
         initialChildren: children,
       );

  static const String name = 'HomeworkEntryRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeworkEntryRouteArgs>();
      return _i25.HomeworkEntryPage(
        key: args.key,
        className: args.className,
        selectedDate: args.selectedDate,
      );
    },
  );
}

class HomeworkEntryRouteArgs {
  const HomeworkEntryRouteArgs({
    this.key,
    required this.className,
    required this.selectedDate,
  });

  final _i68.Key? key;

  final String className;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'HomeworkEntryRouteArgs{key: $key, className: $className, selectedDate: $selectedDate}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeworkEntryRouteArgs) return false;
    return key == other.key &&
        className == other.className &&
        selectedDate == other.selectedDate;
  }

  @override
  int get hashCode => key.hashCode ^ className.hashCode ^ selectedDate.hashCode;
}

/// generated route for
/// [_i26.HomeworkPage]
class HomeworkRoute extends _i67.PageRouteInfo<void> {
  const HomeworkRoute({List<_i67.PageRouteInfo>? children})
    : super(HomeworkRoute.name, initialChildren: children);

  static const String name = 'HomeworkRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i26.HomeworkPage();
    },
  );
}

/// generated route for
/// [_i27.LeaveDetailPage]
class LeaveDetailRoute extends _i67.PageRouteInfo<LeaveDetailRouteArgs> {
  LeaveDetailRoute({
    _i68.Key? key,
    String? leaveId,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         LeaveDetailRoute.name,
         args: LeaveDetailRouteArgs(key: key, leaveId: leaveId),
         rawPathParams: {'id': leaveId},
         initialChildren: children,
       );

  static const String name = 'LeaveDetailRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<LeaveDetailRouteArgs>(
        orElse: () => LeaveDetailRouteArgs(leaveId: pathParams.optString('id')),
      );
      return _i27.LeaveDetailPage(key: args.key, leaveId: args.leaveId);
    },
  );
}

class LeaveDetailRouteArgs {
  const LeaveDetailRouteArgs({this.key, this.leaveId});

  final _i68.Key? key;

  final String? leaveId;

  @override
  String toString() {
    return 'LeaveDetailRouteArgs{key: $key, leaveId: $leaveId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LeaveDetailRouteArgs) return false;
    return key == other.key && leaveId == other.leaveId;
  }

  @override
  int get hashCode => key.hashCode ^ leaveId.hashCode;
}

/// generated route for
/// [_i28.LeavePage]
class LeaveRoute extends _i67.PageRouteInfo<void> {
  const LeaveRoute({List<_i67.PageRouteInfo>? children})
    : super(LeaveRoute.name, initialChildren: children);

  static const String name = 'LeaveRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i28.LeavePage();
    },
  );
}

/// generated route for
/// [_i29.LoginPage]
class LoginRoute extends _i67.PageRouteInfo<void> {
  const LoginRoute({List<_i67.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i29.LoginPage();
    },
  );
}

/// generated route for
/// [_i30.MealMenuPage]
class MealMenuRoute extends _i67.PageRouteInfo<void> {
  const MealMenuRoute({List<_i67.PageRouteInfo>? children})
    : super(MealMenuRoute.name, initialChildren: children);

  static const String name = 'MealMenuRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i30.MealMenuPage();
    },
  );
}

/// generated route for
/// [_i31.MyClassPage]
class MyClassRoute extends _i67.PageRouteInfo<MyClassRouteArgs> {
  MyClassRoute({
    _i68.Key? key,
    _i73.ScrollAwareBottomBarController? bottomBarController,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         MyClassRoute.name,
         args: MyClassRouteArgs(
           key: key,
           bottomBarController: bottomBarController,
         ),
         initialChildren: children,
       );

  static const String name = 'MyClassRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyClassRouteArgs>(
        orElse: () => const MyClassRouteArgs(),
      );
      return _i31.MyClassPage(
        key: args.key,
        bottomBarController: args.bottomBarController,
      );
    },
  );
}

class MyClassRouteArgs {
  const MyClassRouteArgs({this.key, this.bottomBarController});

  final _i68.Key? key;

  final _i73.ScrollAwareBottomBarController? bottomBarController;

  @override
  String toString() {
    return 'MyClassRouteArgs{key: $key, bottomBarController: $bottomBarController}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MyClassRouteArgs) return false;
    return key == other.key && bottomBarController == other.bottomBarController;
  }

  @override
  int get hashCode => key.hashCode ^ bottomBarController.hashCode;
}

/// generated route for
/// [_i32.NewAdmissionPage]
class NewAdmissionRoute extends _i67.PageRouteInfo<void> {
  const NewAdmissionRoute({List<_i67.PageRouteInfo>? children})
    : super(NewAdmissionRoute.name, initialChildren: children);

  static const String name = 'NewAdmissionRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i32.NewAdmissionPage();
    },
  );
}

/// generated route for
/// [_i33.NewPasswordPage]
class NewPasswordRoute extends _i67.PageRouteInfo<void> {
  const NewPasswordRoute({List<_i67.PageRouteInfo>? children})
    : super(NewPasswordRoute.name, initialChildren: children);

  static const String name = 'NewPasswordRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i33.NewPasswordPage();
    },
  );
}

/// generated route for
/// [_i34.NotificationPage]
class NotificationRoute extends _i67.PageRouteInfo<void> {
  const NotificationRoute({List<_i67.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i34.NotificationPage();
    },
  );
}

/// generated route for
/// [_i35.OnboardingPage]
class OnboardingRoute extends _i67.PageRouteInfo<void> {
  const OnboardingRoute({List<_i67.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i35.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i36.PaperPage]
class PaperRoute extends _i67.PageRouteInfo<void> {
  const PaperRoute({List<_i67.PageRouteInfo>? children})
    : super(PaperRoute.name, initialChildren: children);

  static const String name = 'PaperRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i36.PaperPage();
    },
  );
}

/// generated route for
/// [_i37.ParentPhotoPage]
class ParentPhotoRoute extends _i67.PageRouteInfo<void> {
  const ParentPhotoRoute({List<_i67.PageRouteInfo>? children})
    : super(ParentPhotoRoute.name, initialChildren: children);

  static const String name = 'ParentPhotoRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i37.ParentPhotoPage();
    },
  );
}

/// generated route for
/// [_i38.PasswordLoginPage]
class PasswordLoginRoute extends _i67.PageRouteInfo<PasswordLoginRouteArgs> {
  PasswordLoginRoute({
    _i68.Key? key,
    required String email,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         PasswordLoginRoute.name,
         args: PasswordLoginRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'PasswordLoginRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PasswordLoginRouteArgs>();
      return _i38.PasswordLoginPage(key: args.key, email: args.email);
    },
  );
}

class PasswordLoginRouteArgs {
  const PasswordLoginRouteArgs({this.key, required this.email});

  final _i68.Key? key;

  final String email;

  @override
  String toString() {
    return 'PasswordLoginRouteArgs{key: $key, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PasswordLoginRouteArgs) return false;
    return key == other.key && email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode;
}

/// generated route for
/// [_i39.PasswordSuccessPage]
class PasswordSuccessRoute extends _i67.PageRouteInfo<void> {
  const PasswordSuccessRoute({List<_i67.PageRouteInfo>? children})
    : super(PasswordSuccessRoute.name, initialChildren: children);

  static const String name = 'PasswordSuccessRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i39.PasswordSuccessPage();
    },
  );
}

/// generated route for
/// [_i40.PdfViewerPage]
class PdfViewerRoute extends _i67.PageRouteInfo<PdfViewerRouteArgs> {
  PdfViewerRoute({
    _i68.Key? key,
    required String pdfUrl,
    required String title,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         PdfViewerRoute.name,
         args: PdfViewerRouteArgs(key: key, pdfUrl: pdfUrl, title: title),
         initialChildren: children,
       );

  static const String name = 'PdfViewerRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PdfViewerRouteArgs>();
      return _i40.PdfViewerPage(
        key: args.key,
        pdfUrl: args.pdfUrl,
        title: args.title,
      );
    },
  );
}

class PdfViewerRouteArgs {
  const PdfViewerRouteArgs({
    this.key,
    required this.pdfUrl,
    required this.title,
  });

  final _i68.Key? key;

  final String pdfUrl;

  final String title;

  @override
  String toString() {
    return 'PdfViewerRouteArgs{key: $key, pdfUrl: $pdfUrl, title: $title}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PdfViewerRouteArgs) return false;
    return key == other.key && pdfUrl == other.pdfUrl && title == other.title;
  }

  @override
  int get hashCode => key.hashCode ^ pdfUrl.hashCode ^ title.hashCode;
}

/// generated route for
/// [_i41.ProfilePage]
class ProfileRoute extends _i67.PageRouteInfo<void> {
  const ProfileRoute({List<_i67.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i41.ProfilePage();
    },
  );
}

/// generated route for
/// [_i42.PtmPage]
class PtmRoute extends _i67.PageRouteInfo<void> {
  const PtmRoute({List<_i67.PageRouteInfo>? children})
    : super(PtmRoute.name, initialChildren: children);

  static const String name = 'PtmRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i42.PtmPage();
    },
  );
}

/// generated route for
/// [_i43.RemarkDetailPage]
class RemarkDetailRoute extends _i67.PageRouteInfo<RemarkDetailRouteArgs> {
  RemarkDetailRoute({
    _i68.Key? key,
    required _i74.RemarkModel remark,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         RemarkDetailRoute.name,
         args: RemarkDetailRouteArgs(key: key, remark: remark),
         initialChildren: children,
       );

  static const String name = 'RemarkDetailRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RemarkDetailRouteArgs>();
      return _i43.RemarkDetailPage(key: args.key, remark: args.remark);
    },
  );
}

class RemarkDetailRouteArgs {
  const RemarkDetailRouteArgs({this.key, required this.remark});

  final _i68.Key? key;

  final _i74.RemarkModel remark;

  @override
  String toString() {
    return 'RemarkDetailRouteArgs{key: $key, remark: $remark}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RemarkDetailRouteArgs) return false;
    return key == other.key && remark == other.remark;
  }

  @override
  int get hashCode => key.hashCode ^ remark.hashCode;
}

/// generated route for
/// [_i44.RemarksEntryPage]
class RemarksEntryRoute extends _i67.PageRouteInfo<void> {
  const RemarksEntryRoute({List<_i67.PageRouteInfo>? children})
    : super(RemarksEntryRoute.name, initialChildren: children);

  static const String name = 'RemarksEntryRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i44.RemarksEntryPage();
    },
  );
}

/// generated route for
/// [_i45.RemarksPage]
class RemarksRoute extends _i67.PageRouteInfo<void> {
  const RemarksRoute({List<_i67.PageRouteInfo>? children})
    : super(RemarksRoute.name, initialChildren: children);

  static const String name = 'RemarksRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i45.RemarksPage();
    },
  );
}

/// generated route for
/// [_i46.RemarksStudentSelectionPage]
class RemarksStudentSelectionRoute
    extends _i67.PageRouteInfo<RemarksStudentSelectionRouteArgs> {
  RemarksStudentSelectionRoute({
    _i68.Key? key,
    required String remarkCategory,
    required String remarkName,
    required _i75.RemarksEntryBloc remarksEntryBloc,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         RemarksStudentSelectionRoute.name,
         args: RemarksStudentSelectionRouteArgs(
           key: key,
           remarkCategory: remarkCategory,
           remarkName: remarkName,
           remarksEntryBloc: remarksEntryBloc,
         ),
         initialChildren: children,
       );

  static const String name = 'RemarksStudentSelectionRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RemarksStudentSelectionRouteArgs>();
      return _i46.RemarksStudentSelectionPage(
        key: args.key,
        remarkCategory: args.remarkCategory,
        remarkName: args.remarkName,
        remarksEntryBloc: args.remarksEntryBloc,
      );
    },
  );
}

class RemarksStudentSelectionRouteArgs {
  const RemarksStudentSelectionRouteArgs({
    this.key,
    required this.remarkCategory,
    required this.remarkName,
    required this.remarksEntryBloc,
  });

  final _i68.Key? key;

  final String remarkCategory;

  final String remarkName;

  final _i75.RemarksEntryBloc remarksEntryBloc;

  @override
  String toString() {
    return 'RemarksStudentSelectionRouteArgs{key: $key, remarkCategory: $remarkCategory, remarkName: $remarkName, remarksEntryBloc: $remarksEntryBloc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RemarksStudentSelectionRouteArgs) return false;
    return key == other.key &&
        remarkCategory == other.remarkCategory &&
        remarkName == other.remarkName &&
        remarksEntryBloc == other.remarksEntryBloc;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      remarkCategory.hashCode ^
      remarkName.hashCode ^
      remarksEntryBloc.hashCode;
}

/// generated route for
/// [_i47.ReportCardPage]
class ReportCardRoute extends _i67.PageRouteInfo<void> {
  const ReportCardRoute({List<_i67.PageRouteInfo>? children})
    : super(ReportCardRoute.name, initialChildren: children);

  static const String name = 'ReportCardRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i47.ReportCardPage();
    },
  );
}

/// generated route for
/// [_i48.ResetPasswordPage]
class ResetPasswordRoute extends _i67.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i67.PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i48.ResetPasswordPage();
    },
  );
}

/// generated route for
/// [_i49.SchoolPage]
class SchoolRoute extends _i67.PageRouteInfo<void> {
  const SchoolRoute({List<_i67.PageRouteInfo>? children})
    : super(SchoolRoute.name, initialChildren: children);

  static const String name = 'SchoolRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i49.SchoolPage();
    },
  );
}

/// generated route for
/// [_i50.ServicePage]
class ServiceRoute extends _i67.PageRouteInfo<void> {
  const ServiceRoute({List<_i67.PageRouteInfo>? children})
    : super(ServiceRoute.name, initialChildren: children);

  static const String name = 'ServiceRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i50.ServicePage();
    },
  );
}

/// generated route for
/// [_i51.SplashPage]
class SplashRoute extends _i67.PageRouteInfo<void> {
  const SplashRoute({List<_i67.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return _i67.WrappedRoute(child: const _i51.SplashPage());
    },
  );
}

/// generated route for
/// [_i52.StudentInfoPage]
class StudentInfoRoute extends _i67.PageRouteInfo<void> {
  const StudentInfoRoute({List<_i67.PageRouteInfo>? children})
    : super(StudentInfoRoute.name, initialChildren: children);

  static const String name = 'StudentInfoRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i52.StudentInfoPage();
    },
  );
}

/// generated route for
/// [_i53.StudentNoticePage]
class StudentNoticeRoute extends _i67.PageRouteInfo<void> {
  const StudentNoticeRoute({List<_i67.PageRouteInfo>? children})
    : super(StudentNoticeRoute.name, initialChildren: children);

  static const String name = 'StudentNoticeRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i53.StudentNoticePage();
    },
  );
}

/// generated route for
/// [_i54.StudentPhotoUploadPage]
class StudentPhotoUploadRoute extends _i67.PageRouteInfo<void> {
  const StudentPhotoUploadRoute({List<_i67.PageRouteInfo>? children})
    : super(StudentPhotoUploadRoute.name, initialChildren: children);

  static const String name = 'StudentPhotoUploadRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i54.StudentPhotoUploadPage();
    },
  );
}

/// generated route for
/// [_i55.StudentProfilePage]
class StudentProfileRoute extends _i67.PageRouteInfo<void> {
  const StudentProfileRoute({List<_i67.PageRouteInfo>? children})
    : super(StudentProfileRoute.name, initialChildren: children);

  static const String name = 'StudentProfileRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i55.StudentProfilePage();
    },
  );
}

/// generated route for
/// [_i56.SubjectWiseHomeworkEntryPage]
class SubjectWiseHomeworkEntryRoute
    extends _i67.PageRouteInfo<SubjectWiseHomeworkEntryRouteArgs> {
  SubjectWiseHomeworkEntryRoute({
    _i68.Key? key,
    required String className,
    required DateTime selectedDate,
    required String subjectName,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         SubjectWiseHomeworkEntryRoute.name,
         args: SubjectWiseHomeworkEntryRouteArgs(
           key: key,
           className: className,
           selectedDate: selectedDate,
           subjectName: subjectName,
         ),
         initialChildren: children,
       );

  static const String name = 'SubjectWiseHomeworkEntryRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubjectWiseHomeworkEntryRouteArgs>();
      return _i56.SubjectWiseHomeworkEntryPage(
        key: args.key,
        className: args.className,
        selectedDate: args.selectedDate,
        subjectName: args.subjectName,
      );
    },
  );
}

class SubjectWiseHomeworkEntryRouteArgs {
  const SubjectWiseHomeworkEntryRouteArgs({
    this.key,
    required this.className,
    required this.selectedDate,
    required this.subjectName,
  });

  final _i68.Key? key;

  final String className;

  final DateTime selectedDate;

  final String subjectName;

  @override
  String toString() {
    return 'SubjectWiseHomeworkEntryRouteArgs{key: $key, className: $className, selectedDate: $selectedDate, subjectName: $subjectName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SubjectWiseHomeworkEntryRouteArgs) return false;
    return key == other.key &&
        className == other.className &&
        selectedDate == other.selectedDate &&
        subjectName == other.subjectName;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      className.hashCode ^
      selectedDate.hashCode ^
      subjectName.hashCode;
}

/// generated route for
/// [_i57.SubjectWiseHomeworkPage]
class SubjectWiseHomeworkRoute extends _i67.PageRouteInfo<void> {
  const SubjectWiseHomeworkRoute({List<_i67.PageRouteInfo>? children})
    : super(SubjectWiseHomeworkRoute.name, initialChildren: children);

  static const String name = 'SubjectWiseHomeworkRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i57.SubjectWiseHomeworkPage();
    },
  );
}

/// generated route for
/// [_i58.SubjectWiseHomeworkSubjectPage]
class SubjectWiseHomeworkSubjectRoute
    extends _i67.PageRouteInfo<SubjectWiseHomeworkSubjectRouteArgs> {
  SubjectWiseHomeworkSubjectRoute({
    _i68.Key? key,
    required String className,
    required DateTime selectedDate,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         SubjectWiseHomeworkSubjectRoute.name,
         args: SubjectWiseHomeworkSubjectRouteArgs(
           key: key,
           className: className,
           selectedDate: selectedDate,
         ),
         initialChildren: children,
       );

  static const String name = 'SubjectWiseHomeworkSubjectRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubjectWiseHomeworkSubjectRouteArgs>();
      return _i58.SubjectWiseHomeworkSubjectPage(
        key: args.key,
        className: args.className,
        selectedDate: args.selectedDate,
      );
    },
  );
}

class SubjectWiseHomeworkSubjectRouteArgs {
  const SubjectWiseHomeworkSubjectRouteArgs({
    this.key,
    required this.className,
    required this.selectedDate,
  });

  final _i68.Key? key;

  final String className;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'SubjectWiseHomeworkSubjectRouteArgs{key: $key, className: $className, selectedDate: $selectedDate}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SubjectWiseHomeworkSubjectRouteArgs) return false;
    return key == other.key &&
        className == other.className &&
        selectedDate == other.selectedDate;
  }

  @override
  int get hashCode => key.hashCode ^ className.hashCode ^ selectedDate.hashCode;
}

/// generated route for
/// [_i59.SyllabusPage]
class SyllabusRoute extends _i67.PageRouteInfo<void> {
  const SyllabusRoute({List<_i67.PageRouteInfo>? children})
    : super(SyllabusRoute.name, initialChildren: children);

  static const String name = 'SyllabusRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i59.SyllabusPage();
    },
  );
}

/// generated route for
/// [_i60.TimeTablePage]
class TimeTableRoute extends _i67.PageRouteInfo<void> {
  const TimeTableRoute({List<_i67.PageRouteInfo>? children})
    : super(TimeTableRoute.name, initialChildren: children);

  static const String name = 'TimeTableRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return _i67.WrappedRoute(child: const _i60.TimeTablePage());
    },
  );
}

/// generated route for
/// [_i61.TransportAttendancePage]
class TransportAttendanceRoute extends _i67.PageRouteInfo<void> {
  const TransportAttendanceRoute({List<_i67.PageRouteInfo>? children})
    : super(TransportAttendanceRoute.name, initialChildren: children);

  static const String name = 'TransportAttendanceRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i61.TransportAttendancePage();
    },
  );
}

/// generated route for
/// [_i62.VerificationPage]
class VerificationRoute extends _i67.PageRouteInfo<void> {
  const VerificationRoute({List<_i67.PageRouteInfo>? children})
    : super(VerificationRoute.name, initialChildren: children);

  static const String name = 'VerificationRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i62.VerificationPage();
    },
  );
}

/// generated route for
/// [_i63.VideoDetailPage]
class VideoDetailRoute extends _i67.PageRouteInfo<VideoDetailRouteArgs> {
  VideoDetailRoute({
    _i68.Key? key,
    required _i76.VideoModel video,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         VideoDetailRoute.name,
         args: VideoDetailRouteArgs(key: key, video: video),
         initialChildren: children,
       );

  static const String name = 'VideoDetailRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoDetailRouteArgs>();
      return _i63.VideoDetailPage(key: args.key, video: args.video);
    },
  );
}

class VideoDetailRouteArgs {
  const VideoDetailRouteArgs({this.key, required this.video});

  final _i68.Key? key;

  final _i76.VideoModel video;

  @override
  String toString() {
    return 'VideoDetailRouteArgs{key: $key, video: $video}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoDetailRouteArgs) return false;
    return key == other.key && video == other.video;
  }

  @override
  int get hashCode => key.hashCode ^ video.hashCode;
}

/// generated route for
/// [_i64.VideoViewerPage]
class VideoViewerRoute extends _i67.PageRouteInfo<VideoViewerRouteArgs> {
  VideoViewerRoute({
    _i68.Key? key,
    required String videoAlbumId,
    required int initialIndex,
    List<_i77.VideoItemModel>? videos,
    List<_i67.PageRouteInfo>? children,
  }) : super(
         VideoViewerRoute.name,
         args: VideoViewerRouteArgs(
           key: key,
           videoAlbumId: videoAlbumId,
           initialIndex: initialIndex,
           videos: videos,
         ),
         initialChildren: children,
       );

  static const String name = 'VideoViewerRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoViewerRouteArgs>();
      return _i64.VideoViewerPage(
        key: args.key,
        videoAlbumId: args.videoAlbumId,
        initialIndex: args.initialIndex,
        videos: args.videos,
      );
    },
  );
}

class VideoViewerRouteArgs {
  const VideoViewerRouteArgs({
    this.key,
    required this.videoAlbumId,
    required this.initialIndex,
    this.videos,
  });

  final _i68.Key? key;

  final String videoAlbumId;

  final int initialIndex;

  final List<_i77.VideoItemModel>? videos;

  @override
  String toString() {
    return 'VideoViewerRouteArgs{key: $key, videoAlbumId: $videoAlbumId, initialIndex: $initialIndex, videos: $videos}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoViewerRouteArgs) return false;
    return key == other.key &&
        videoAlbumId == other.videoAlbumId &&
        initialIndex == other.initialIndex &&
        const _i72.ListEquality<_i77.VideoItemModel>().equals(
          videos,
          other.videos,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      videoAlbumId.hashCode ^
      initialIndex.hashCode ^
      const _i72.ListEquality<_i77.VideoItemModel>().hash(videos);
}

/// generated route for
/// [_i65.VideosPage]
class VideosRoute extends _i67.PageRouteInfo<void> {
  const VideosRoute({List<_i67.PageRouteInfo>? children})
    : super(VideosRoute.name, initialChildren: children);

  static const String name = 'VideosRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i65.VideosPage();
    },
  );
}

/// generated route for
/// [_i66.ViewTransportAttendancePage]
class ViewTransportAttendanceRoute extends _i67.PageRouteInfo<void> {
  const ViewTransportAttendanceRoute({List<_i67.PageRouteInfo>? children})
    : super(ViewTransportAttendanceRoute.name, initialChildren: children);

  static const String name = 'ViewTransportAttendanceRoute';

  static _i67.PageInfo page = _i67.PageInfo(
    name,
    builder: (data) {
      return const _i66.ViewTransportAttendancePage();
    },
  );
}
