/// shout out to Randal Schwartz for this code
/// https://gist.github.com/RandalSchwartz/930adcd578887afe93ac0926847353cc
library;

extension DateTimeSmartCopyWith on DateTime {
  /// Update the DateTime with the given fields,
  /// using mutate mappers for selected fields.
  ///
  /// If a field is not mentioned, and it is smaller than
  /// any field mentioned, a field-specific default value is used.
  ///
  /// If a field is not mentioned, but is not smaller than
  /// any field mentioned, it is passed though from the original,
  /// subject to any over-/under-flows from smaller fields as with
  /// the standard DateTime constructor.
  ///
  /// Mutate mappers conform to:
  /// ```
  ///   int Function (int)
  /// ```
  ///
  /// The mapper is called with the current value of the field,
  /// and is expected to return the new value.
  ///
  /// For example, to get "the beginning of the next day", you use:
  /// ```
  ///   aDateTime.smartCopyWith(day: (d) => d + 1)
  /// ```
  ///
  /// Because `day` is specified, the year and month are copied,
  /// but hour, minute, second (and so on) are set to zero.
  ///
  /// For convenience, an integer may also be specified directly:
  /// ```
  ///   aDateTime.smartCopyWith(day: 1)
  /// ```
  /// Because of the overflow rules, "the beginning of the next day"
  /// (as in the earlier example) can also be written as:
  /// ```
  ///   aDateTime.smartCopyWith(hour: 24)
  /// ```
  ///
  /// As an edge case, if no fields are specified,
  /// the first day of the referenced year is returned.
  ///
  /// `isUtc` is preserved from the original DateTime,
  /// which can impact some overflow situations,
  /// including what it means to "set the time to midnight".
  DateTime smartCopyWith({
    dynamic year,
    dynamic month,
    dynamic day,
    dynamic hour,
    dynamic minute,
    dynamic second,
    dynamic millisecond,
    dynamic microsecond,
    bool? isUtc,
  }) {
    var seen = false;
    int fix(dynamic newValue, int prevValue, [int defaultValue = 0]) {
      int asSeen(int value) {
        seen = true;
        return value;
      }

      return switch (newValue) {
        null when seen => prevValue,
        final int n => asSeen(n),
        null => defaultValue,
        final dynamic Function(int) m => asSeen(m(prevValue) as int),
        final v => throw ArgumentError('$v'),
      };
    }

    return Function.apply(
      (isUtc ?? this.isUtc) ? DateTime.utc : DateTime.new,
      [
        ...[
          fix(microsecond, this.microsecond),
          fix(millisecond, this.millisecond),
          fix(second, this.second),
          fix(minute, this.minute),
          fix(hour, this.hour),
          fix(day, this.day, 1), // mimic standard constructor
          fix(month, this.month, 1), // mimic standard constructor
          fix(year, this.year, this.year), // year is required
        ].reversed,
      ],
    ) as DateTime;
  }
}
