import 'package:meta/meta.dart';
import 'package:test/test.dart';

/// Creates a group of tests.
///
/// A group's description (converted to a string) is included in the descriptions
/// of any tests or sub-groups it contains. [setUp] and [tearDown] are also scoped
/// to the containing group.
///
/// If [testOn] is passed, it's parsed as a [platform selector][]; the test will
/// only be run on matching platforms.
///
/// [platform selector]: https://github.com/dart-lang/test/tree/master/pkgs/test#platform-selectors
///
/// If [timeout] is passed, it's used to modify or replace the default timeout
/// of 30 seconds. Timeout modifications take precedence in suite-group-test
/// order, so [timeout] will also modify any timeouts set on the suite, and will
/// be modified by any timeouts set on individual tests.
///
/// If [skip] is a String or `true`, the group is skipped. If it's a String, it
/// should explain why the group is skipped; this reason will be printed instead
/// of running the group's tests.
///
/// If [tags] is passed, it declares user-defined tags that are applied to the
/// test. These tags can be used to select or skip the test on the command line,
/// or to do bulk test configuration. All tags should be declared in the
/// [package configuration file][configuring tags]. The parameter can be an
/// [Iterable] of tag names, or a [String] representing a single tag.
///
/// [configuring tags]: https://github.com/dart-lang/test/blob/master/pkgs/test/doc/configuration.md#configuring-tags
///
/// [onPlatform] allows groups to be configured on a platform-by-platform
/// basis. It's a map from strings that are parsed as [PlatformSelector]s to
/// annotation classes: [Timeout], [Skip], or lists of those. These
/// annotations apply only on the given platforms. For example:
///
///     group('potentially slow tests', () {
///       // ...
///     }, onPlatform: {
///       // These tests are especially slow on Windows.
///       'windows': Timeout.factor(2),
///       'browser': [
///         Skip('TODO: add browser support'),
///         // They'll be slow on browsers once it works on them.
///         Timeout.factor(2)
///       ]
///     });
///
/// If multiple platforms match, the annotations apply in order as through
/// they were in nested groups.
///
/// If the `solo` flag is `true`, only tests and groups marked as
/// "solo" will be be run. This only restricts tests *within this test
/// suite*—tests in other suites will run as normal. We recommend that users
/// avoid this flag if possible, and instead use the test runner flag `-n` to
/// filter tests by name.
@isTestGroup
void given(
  String description, {
  required dynamic Function() body,
  dynamic Function()? before,
  dynamic Function()? after,
  bool skip = false,
}) {
  final regExp = RegExp(r'^\[\w+]');
  final w = regExp.stringMatch(description);

  var desc = description;
  var beggining = 'Given ';

  if (w != null && w != '') {
    desc = description.replaceAll(w, '');
    beggining = w.replaceAll('[', '').replaceAll(']', '');
  }

  group(
    '$beggining$desc',
    () {
      setUp(() => before?.call());
      tearDown(() => after?.call());
      body();
    },
    skip: skip,
  );
}

/// Creates a group of tests.
///
/// A group's description (converted to a string) is included in the descriptions
/// of any tests or sub-groups it contains. [setUp] and [tearDown] are also scoped
/// to the containing group.
///
/// If [testOn] is passed, it's parsed as a [platform selector][]; the test will
/// only be run on matching platforms.
///
/// [platform selector]: https://github.com/dart-lang/test/tree/master/pkgs/test#platform-selectors
///
/// If [timeout] is passed, it's used to modify or replace the default timeout
/// of 30 seconds. Timeout modifications take precedence in suite-group-test
/// order, so [timeout] will also modify any timeouts set on the suite, and will
/// be modified by any timeouts set on individual tests.
///
/// If [skip] is a String or `true`, the group is skipped. If it's a String, it
/// should explain why the group is skipped; this reason will be printed instead
/// of running the group's tests.
///
/// If [tags] is passed, it declares user-defined tags that are applied to the
/// test. These tags can be used to select or skip the test on the command line,
/// or to do bulk test configuration. All tags should be declared in the
/// [package configuration file][configuring tags]. The parameter can be an
/// [Iterable] of tag names, or a [String] representing a single tag.
///
/// [configuring tags]: https://github.com/dart-lang/test/blob/master/pkgs/test/doc/configuration.md#configuring-tags
///
/// [onPlatform] allows groups to be configured on a platform-by-platform
/// basis. It's a map from strings that are parsed as [PlatformSelector]s to
/// annotation classes: [Timeout], [Skip], or lists of those. These
/// annotations apply only on the given platforms. For example:
///
///     group('potentially slow tests', () {
///       // ...
///     }, onPlatform: {
///       // These tests are especially slow on Windows.
///       'windows': Timeout.factor(2),
///       'browser': [
///         Skip('TODO: add browser support'),
///         // They'll be slow on browsers once it works on them.
///         Timeout.factor(2)
///       ]
///     });
///
/// If multiple platforms match, the annotations apply in order as through
/// they were in nested groups.
///
/// If the `solo` flag is `true`, only tests and groups marked as
/// "solo" will be be run. This only restricts tests *within this test
/// suite*—tests in other suites will run as normal. We recommend that users
/// avoid this flag if possible, and instead use the test runner flag `-n` to
/// filter tests by name.
@isTestGroup
void whenn(
  String description, {
  required dynamic Function() body,
  dynamic Function()? before,
  dynamic Function()? after,
  bool skip = false,
}) {
  final regExp = RegExp(r'^\[\w+]');
  final w = regExp.stringMatch(description);

  var desc = description;
  var beggining = 'When ';

  if (w != null && w != '') {
    desc = description.replaceAll(w, '');
    beggining = w.replaceAll('[', '').replaceAll(']', '');
  }

  group(
    '$beggining$desc',
    () {
      setUp(() => before?.call());
      tearDown(() => after?.call());
      body();
    },
    skip: skip,
  );
}

/// Creates a new test case with the given description (converted to a string)
/// and body.
///
/// The description will be added to the descriptions of any surrounding
/// [group]s. If [testOn] is passed, it's parsed as a [platform selector][]; the
/// test will only be run on matching platforms.
///
/// [platform selector]: https://github.com/dart-lang/test/tree/master/pkgs/test#platform-selectors
///
/// If [timeout] is passed, it's used to modify or replace the default timeout
/// of 30 seconds. Timeout modifications take precedence in suite-group-test
/// order, so [timeout] will also modify any timeouts set on the group or suite.
///
/// If [skip] is a String or `true`, the test is skipped. If it's a String, it
/// should explain why the test is skipped; this reason will be printed instead
/// of running the test.
///
/// If [tags] is passed, it declares user-defined tags that are applied to the
/// test. These tags can be used to select or skip the test on the command line,
/// or to do bulk test configuration. All tags should be declared in the
/// [package configuration file][configuring tags]. The parameter can be an
/// [Iterable] of tag names, or a [String] representing a single tag.
///
/// If [retry] is passed, the test will be retried the provided number of times
/// before being marked as a failure.
///
/// [configuring tags]: https://github.com/dart-lang/test/blob/master/pkgs/test/doc/configuration.md#configuring-tags
///
/// [onPlatform] allows tests to be configured on a platform-by-platform
/// basis. It's a map from strings that are parsed as [PlatformSelector]s to
/// annotation classes: [Timeout], [Skip], or lists of those. These
/// annotations apply only on the given platforms. For example:
///
///     test('potentially slow test', () {
///       // ...
///     }, onPlatform: {
///       // This test is especially slow on Windows.
///       'windows': Timeout.factor(2),
///       'browser': [
///         Skip('TODO: add browser support'),
///         // This will be slow on browsers once it works on them.
///         Timeout.factor(2)
///       ]
///     });
///
/// If multiple platforms match, the annotations apply in order as through
/// they were in nested groups.
///
/// If the `solo` flag is `true`, only tests and groups marked as
/// "solo" will be be run. This only restricts tests *within this test
/// suite*—tests in other suites will run as normal. We recommend that users
/// avoid this flag if possible and instead use the test runner flag `-n` to
/// filter tests by name.
@isTest
void then(
  String description,
  dynamic Function() body, {
  bool skip = false,
}) {
  test(
    'Then $description',
    body,
    skip: skip,
  );
}

void beforeAll(dynamic Function() body) {
  setUpAll(body);
}

void before(dynamic Function() body) {
  setUp(body);
}

void after(dynamic Function() body) {
  tearDown(body);
}

void afterAll(dynamic Function() body) {
  tearDownAll(body);
}
