/// Leave type enum
enum LeaveType {
  sickLeave('SICK LEAVE(SL)'),
  social('SOCIAL(SL)'),
  otherLeave('OTHER LEAVE(OL)');

  final String label;
  const LeaveType(this.label);
}
