import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  final String id;
  final String name;
  final String role;
  final String? profileImageUrl;
  final String email;

  const AccountModel({
    required this.id,
    required this.name,
    required this.role,
    this.profileImageUrl,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, role, profileImageUrl, email];

  // Dummy data representing logged in accounts on the device
  static List<AccountModel> getMockAccounts() {
    return const [
      AccountModel(
        id: 'user_1',
        name: 'Alex Johnson',
        role: 'Student',
        profileImageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
        email: 'alex.j@example.com',
      ),
      AccountModel(
        id: 'user_2',
        name: 'Sarah Johnson',
        role: 'Student',
        profileImageUrl: 'https://i.pravatar.cc/150?u=b042581f4e29026024d',
        email: 'sarah.student@example.com',
      ),
      AccountModel(
        id: 'user_3',
        name: 'Michael Davis',
        role: 'Student',
        profileImageUrl: 'https://i.pravatar.cc/150?u=c042581f4e29026024d',
        email: 'mdavis.student@example.com',
      ),
    ];
  }
}
