---
title: Rules
intro: Every rule the phpmath standard enforces, grouped by topic, with examples for the important ones.
group: Reference
order: 50
---

## How to read this page

The standard enables 189 sniffs. The sections below group them by topic, and each table gives the sniff name and a one line explanation. Names are written without the `SlevomatCodingStandard.` prefix where the group says so. The first sections are the rules phpmath lists itself, followed by the ones inherited from Doctrine and PSR-12.

> [!NOTE]
> This page is a guide, not a full catalogue of messages. List all active sniffs with `vendor/bin/phpcs -e --standard=phpmath`, and see the [Slevomat documentation](https://github.com/slevomat/coding-standard) for the exact behavior of each sniff.

## Rules phpmath declares itself

These sniffs are listed in the phpmath ruleset, so they stay active even if the Doctrine base changes. All names start with `SlevomatCodingStandard.`.

| Sniff | Explanation |
|---|---|
| `TypeHints.DeclareStrictTypes` | Every file starts with `declare(strict_types=1);`, with one blank line before and after it and no spaces around the equals sign. |
| `TypeHints.ParameterTypeHint` | Every parameter has a native type. |
| `TypeHints.ReturnTypeHint` | Every function and method has a native return type. |
| `TypeHints.PropertyTypeHint` | Every property has a native type. |
| `Namespaces.UnusedUses` | Imports that are never used are removed. |
| `Namespaces.AlphabeticallySortedUses` | Imports are sorted alphabetically. |
| `Classes.RequireAbstractOrFinal` | Every class is declared `abstract` or `final`. |
| `Classes.ReadonlyClass` | A class that can be `readonly` is declared `readonly`. |
| `TypeHints.ReturnTypeHintSpacing` | No space before the colon of a return type: `(): int`. |
| `TypeHints.DNFTypeHintFormat` | Nullable types use the short form `?int`. |

### Strict types

The sniff `DeclareStrictTypes` makes sure that PHP never silently converts a value to another type. `phpcbf` adds the missing declaration.

```php
// before
<?php

namespace Phpmath\Example;

// after
<?php

declare(strict_types=1);

namespace Phpmath\Example;
```

The message is `Missing declare(strict_types=1).`

### Native types

The three type hint sniffs reject code that has no native type on a parameter, return value or property. They are not fixable, because the tool cannot guess your type.

```php
// before
public function add($value)
{
    return $value;
}

// after
public function add(int $value): int
{
    return $value;
}
```

The message is `Method ... does not have parameter type hint nor @param annotation for its parameter $value.` Write the native type itself. A `@param` or `@return` annotation does not replace it.

### Imports

The import sniffs keep the `use` block clean. `phpcbf` removes unused imports and sorts the rest.

```php
// before
use Stringable;
use Countable;
use ArrayAccess;

final readonly class Example implements Stringable, Countable

// after
use Countable;
use Stringable;

final readonly class Example implements Stringable, Countable
```

The messages are `Type ArrayAccess is not used in this file.` and `Use statements should be sorted alphabetically.`

### Final or abstract classes

A class is either `final` or `abstract`. This stops accidental inheritance and keeps extension points explicit. `phpcbf` adds `final`.

```php
// before
class Money

// after
final class Money
```

The message is `All classes should be declared using either the "abstract" or "final" keyword.`

### Readonly classes

When every property of a class is `readonly`, the class itself must be `readonly`. This fits immutable value objects. `phpcbf` moves the keyword to the class.

```php
// before
final class Money
{
    public function __construct(private readonly int $amount)
    {
    }
}

// after
final readonly class Money
{
    public function __construct(private int $amount)
    {
    }
}
```

The message is `Class Money can be marked as readonly.`

## Modern PHP

These sniffs from the Doctrine base ask for current language features. All names start with `SlevomatCodingStandard.`.

| Sniff | Explanation |
|---|---|
| `Classes.RequireConstructorPropertyPromotion` | Properties assigned from constructor parameters use property promotion. |
| `ControlStructures.RequireNullCoalesceOperator` | Use `??` instead of `isset() ? :`. |
| `ControlStructures.RequireNullCoalesceEqualOperator` | Use `??=` instead of assigning with `??`. |
| `ControlStructures.RequireNullSafeObjectOperator` | Use `?->` instead of a null check before a method call. |
| `Classes.ModernClassNameReference` | Use `::class` instead of `get_class()` and similar. |
| `TypeHints.NullableTypeForNullDefaultValue` | A parameter with a `null` default has a nullable type. |
| `TypeHints.NullTypeHintOnLastPosition` | In a union type, `null` comes last. |
| `TypeHints.LongTypeHints` | Use `int` and `bool`, not `integer` and `boolean`. |
| `TypeHints.ClassConstantTypeHint` | Class constants have a native type. |
| `Generic.Arrays.DisallowLongArraySyntax` | Use `[]`, not `array()`. |
| `PHP.ShortList` | Use `[$a, $b] = ...`, not `list()`. |

### Constructor promotion

A property that is only copied from a constructor parameter must be promoted. `phpcbf` rewrites it.

```php
// before
private int $amount;

public function __construct(int $amount)
{
    $this->amount = $amount;
}

// after
public function __construct(private int $amount)
{
}
```

The message is `Required promotion of property $amount.`

### Null coalescing

A ternary that only checks `isset()` is written with `??`. `phpcbf` rewrites it.

```php
// before
$amount = isset($this->amount) ? $this->amount : 0;

// after
$amount = $this->amount ?? 0;
```

The message is `Use null coalesce operator instead of ternary operator.`

## Imports and names

Beyond sorting and unused imports, the standard wants every name imported once and written short. All names start with `SlevomatCodingStandard.`.

| Sniff | Explanation |
|---|---|
| `Namespaces.ReferenceUsedNamesOnly` | Classes, functions and constants are imported, not written with a leading backslash. |
| `Namespaces.UseDoesNotStartWithBackslash` | An import does not begin with a backslash. |
| `Namespaces.DisallowGroupUse` | No grouped imports such as `use A\{B, C}`. |
| `Namespaces.MultipleUsesPerLine` | One import per line. |
| `Namespaces.UseFromSameNamespace` | No import of a class that lives in the current namespace. |
| `Namespaces.UselessAlias` | No alias that equals the imported name. |
| `Namespaces.UseSpacing` | One blank line around the block of imports. |
| `Namespaces.NamespaceSpacing` | One blank line before and after the namespace statement. |
| `Classes.SuperfluousAbstractClassNaming` | No `Abstract` prefix on abstract classes. |
| `Classes.SuperfluousInterfaceNaming` | No `Interface` suffix on interfaces. |
| `Classes.SuperfluousTraitNaming` | No `Trait` suffix on traits. |
| `Classes.SuperfluousExceptionNaming` | Turned off for the `Exception` suffix: exceptions keep names such as `InvalidValueException`. |

### Global functions and classes

Global functions are imported with `use function`, and global classes with `use`. A call such as `strlen()` without an import is a violation.

```php
// before
return strlen($value);

// after
use function strlen;

return strlen($value);
```

The message is `Function strlen() should not be referenced via a fallback global name, but via a use statement.`

## Control flow

These sniffs keep conditions simple and easy to read. All names start with `SlevomatCodingStandard.`.

| Sniff | Explanation |
|---|---|
| `ControlStructures.DisallowYodaComparison` | Write `$a === null`, not `null === $a`. |
| `ControlStructures.EarlyExit` | Return early instead of nesting an `else`. |
| `ControlStructures.AssignmentInCondition` | No assignments inside a condition. |
| `ControlStructures.UselessIfConditionWithReturn` | No `if ($a) { return true; } return false;`. |
| `ControlStructures.UselessTernaryOperator` | No ternary that only returns `true` or `false`. |
| `ControlStructures.BlockControlStructureSpacing` | A blank line before and after a block such as `if`. |
| `ControlStructures.JumpStatementsSpacing` | A blank line before `return`, `throw` and similar statements. |
| `Variables.UselessVariable` | No variable that is assigned and returned straight away. |
| `Variables.DuplicateAssignmentToVariable` | No variable assigned twice in a row. |
| `Exceptions.ReferenceThrowableOnly` | Catch `Throwable` instead of `Exception`. |
| `Exceptions.DeadCatch` | No catch block that can never be reached. |
| `Exceptions.RequireNonCapturingCatch` | Leave out the variable when you do not use it. |
| `Operators.DisallowEqualOperators` | Use `===` and `!==`, not `==` and `!=`. |
| `Operators.RequireCombinedAssignmentOperator` | Use `+=` instead of `$a = $a + 1`. |

### Yoda comparisons

The constant goes on the right side of a comparison. `phpcbf` swaps the sides.

```php
// before
if (null === $this->amount) {

// after
if ($this->amount === null) {
```

The message is `Yoda comparisons are disallowed.`

## Functions and arrays

These sniffs set the shape of declarations and calls, including trailing commas. All names start with `SlevomatCodingStandard.` unless a full name is given.

| Sniff | Explanation |
|---|---|
| `Functions.RequireTrailingCommaInCall` | A multiline call ends with a trailing comma. |
| `Functions.RequireTrailingCommaInDeclaration` | A multiline declaration ends with a trailing comma. |
| `Functions.RequireTrailingCommaInClosureUse` | A multiline closure `use` ends with a trailing comma. |
| `Functions.StaticClosure` | A closure that does not use `$this` is `static`. |
| `Functions.ArrowFunctionDeclaration` | Consistent spacing in `fn` arrow functions. |
| `Arrays.TrailingArrayComma` | A multiline array ends with a trailing comma. |
| `Arrays.SingleLineArrayWhitespace` | No stray spaces in single line arrays. |
| `Generic.Arrays.ArrayIndent` | Array elements are indented with four spaces. |
| `Generic.Functions.FunctionCallArgumentSpacing` | One space after each comma in a call. |

## Classes

These sniffs describe the layout of a class body. All names start with `SlevomatCodingStandard.Classes.`.

| Sniff | Explanation |
|---|---|
| `ClassConstantVisibility` | Constants declare their visibility. |
| `DisallowMultiConstantDefinition` | One constant per statement. |
| `ConstantSpacing` | A blank line between constants. |
| `PropertyDeclaration` | Properties declare a visibility and a type in the expected form. |
| `PropertySpacing` | A blank line between properties. |
| `EmptyLinesAroundClassBraces` | No blank line after the opening or before the closing brace of a class. |
| `EnumCaseSpacing` | Consistent blank lines between enum cases. |
| `BackedEnumTypeSpacing` | No space before the colon of a backed enum type. |
| `TraitUseDeclaration` | One trait per `use` statement. |
| `TraitUseSpacing` | A blank line around trait `use` statements. |
| `ParentCallSpacing` | A blank line around a `parent::` call. |
| `DisallowLateStaticBindingForConstants` | Use `self::` for constants, not `static::`. |
| `DisallowStringExpressionPropertyFetch` | No `$this->{'name'}` property access. |

## Comments

These sniffs keep doc comments short and useful. The full names are given.

| Sniff | Explanation |
|---|---|
| `Squiz.Commenting.FunctionComment` | A function doc comment is complete and correct. The `SpacingAfterParamType` message is turned off. |
| `Squiz.Commenting.DocCommentAlignment` | The asterisks of a doc comment line up. |
| `SlevomatCodingStandard.Commenting.UselessFunctionDocComment` | No doc comment that only repeats the native types. |
| `SlevomatCodingStandard.Commenting.UselessInheritDocComment` | No `{@inheritDoc}` only comment. |
| `SlevomatCodingStandard.Commenting.EmptyComment` | No empty comments. |
| `SlevomatCodingStandard.Commenting.DocCommentSpacing` | Consistent blank lines inside doc comments. |
| `SlevomatCodingStandard.Commenting.RequireOneLineDocComment` | A short doc comment fits on one line. |
| `SlevomatCodingStandard.Commenting.ForbiddenAnnotations` | No `@api`, `@author`, `@category`, `@copyright`, `@created`, `@license`, `@package`, `@since`, `@subpackage` or `@version` annotations. |
| `PEAR.Commenting.InlineComment` | Use `//`, not `#`, for comments. |

## Formatting from PSR-12

PSR-12 is the base of the standard. It covers the layout of files, classes, methods and control structures. Doctrine keeps most of PSR-12 and drops a few sniffs that Slevomat replaces.

| Area | Sniffs |
|---|---|
| Files | `PSR12.Files.OpenTag`, `PSR12.Files.DeclareStatement`, `PSR12.Files.ImportStatement`, `PSR2.Files.EndFileNewline`, `PSR2.Files.ClosingTag`, `Generic.Files.LineEndings`, `Generic.Files.ByteOrderMark` |
| Classes | `PSR1.Classes.ClassDeclaration`, `PSR2.Classes.ClassDeclaration`, `PSR12.Classes.ClassInstantiation`, `PSR12.Classes.ClosingBrace` |
| Methods | `PSR1.Methods.CamelCapsMethodName`, `PSR2.Methods.MethodDeclaration`, `PSR2.Methods.FunctionCallSignature`, `PSR2.Methods.FunctionClosingBrace` |
| Control structures | `PSR2.ControlStructures.ElseIfDeclaration`, `PSR2.ControlStructures.SwitchDeclaration`, `PSR12.ControlStructures.BooleanOperatorPlacement`, `Squiz.ControlStructures.ControlSignature` |
| Whitespace | `Generic.WhiteSpace.DisallowTabIndent`, `Generic.WhiteSpace.ScopeIndent`, `PSR12.Operators.OperatorSpacing`, `Squiz.WhiteSpace.CastSpacing` |
| Side effects | `PSR1.Files.SideEffects`: a file declares symbols or runs code, not both. |
| Line length | `Generic.Files.LineLength`: lines should stay within the PSR-12 soft limit of 120 characters (reported as a warning). |

## Rules turned off

The phpmath ruleset removes three formatting sniffs from the Doctrine base. These do not apply to phpmath code.

| Sniff | Effect of removing it |
|---|---|
| `Generic.Formatting.MultipleStatementAlignment` | Assignments are not aligned on the equals sign. |
| `Generic.Formatting.SpaceAfterCast` | `(int)$value` has no required space after the cast. |
| `Generic.Formatting.SpaceAfterNot` | `!$value` has no required space after the not operator. |
