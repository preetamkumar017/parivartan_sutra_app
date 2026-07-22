/// Matches `GET parent/children`
/// (`App\Modules\Api\Controllers\ParentController::children()`):
/// each row is the `students` table minus `user_id`, plus a derived
/// `has_login` bool.
class ChildModel {
  final int id;
  final String name;
  final String className;
  final String? dob;
  final bool hasLogin;

  const ChildModel({
    required this.id,
    required this.name,
    required this.className,
    this.dob,
    required this.hasLogin,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      className: json['class'] as String? ?? '',
      dob: json['dob'] as String?,
      hasLogin: json['has_login'] as bool? ?? false,
    );
  }
}
