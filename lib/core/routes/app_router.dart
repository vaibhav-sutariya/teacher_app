import 'package:auto_route/auto_route.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';

import 'auth_guard.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({required this.authGuard});
  final AuthGuard authGuard;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: VerificationRoute.page),
    AutoRoute(page: PasswordLoginRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: NewPasswordRoute.page),
    AutoRoute(page: PasswordSuccessRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(
      page: DashboardRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SchoolRoute.page),
        AutoRoute(page: MyClassRoute.page),
        AutoRoute(page: ServiceRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: AttendanceRoute.page),
    AutoRoute(page: AttendanceEntryRoute.page),
    AutoRoute(page: HomeworkRoute.page),
    AutoRoute(page: ClassworkRoute.page),
    AutoRoute(page: GalleryRoute.page),
    AutoRoute(page: GalleryDetailRoute.page),
    AutoRoute(page: GalleryImageViewerRoute.page),
    AutoRoute(page: VideosRoute.page),
    AutoRoute(page: VideoDetailRoute.page),
    AutoRoute(page: VideoViewerRoute.page),
    AutoRoute(page: RemarksRoute.page),
    AutoRoute(page: RemarksEntryRoute.page),
    AutoRoute(page: RemarksStudentSelectionRoute.page),
    AutoRoute(page: RemarkDetailRoute.page),
    AutoRoute(page: LeaveRoute.page),
    AutoRoute(page: AddLeaveRoute.page),
    AutoRoute(page: LeaveDetailRoute.page),
    AutoRoute(page: MealMenuRoute.page),
    AutoRoute(page: TimeTableRoute.page),
    AutoRoute(page: SyllabusRoute.page),
    AutoRoute(page: AssignmentRoute.page),
    AutoRoute(page: HolidayHwRoute.page),
    AutoRoute(page: PdfViewerRoute.page),
    AutoRoute(page: AppWebViewRoute.page),
    AutoRoute(page: ExamTimeTableRoute.page),
    AutoRoute(page: PaperRoute.page),
    AutoRoute(page: ClassTestRoute.page),
    AutoRoute(page: ConcernRoute.page),
    AutoRoute(page: AddConcernRoute.page),
    AutoRoute(page: ConcernDetailsRoute.page),
    AutoRoute(page: GatePassRoute.page),
    AutoRoute(page: StudentProfileRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: AboutAppRoute.page),
    AutoRoute(page: NotificationRoute.page),
    AutoRoute(page: PtmRoute.page),
    AutoRoute(page: AchievementRoute.page),
    AutoRoute(page: ReportCardRoute.page),
    AutoRoute(page: ParentPhotoRoute.page),
    AutoRoute(page: EmployeePhotoRoute.page),
    AutoRoute(page: StudentPhotoUploadRoute.page),
    AutoRoute(page: NewAdmissionRoute.page),
    AutoRoute(page: BirthdayRoute.page),
    AutoRoute(page: CalendarRoute.page),
    AutoRoute(page: StudentInfoRoute.page),
    AutoRoute(page: ViewTransportAttendanceRoute.page),
    AutoRoute(page: TransportAttendanceRoute.page),
    AutoRoute(page: StudentNoticeRoute.page),
  ];
}
