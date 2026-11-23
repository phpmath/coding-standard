---
title: Core concepts
intro: How the ruleset is built and what it asks of your code.
group: Getting started
order: 20
---

## A ruleset built from other standards

The `phpmath` standard does not define its own formatting rules from scratch. It starts from the [Doctrine Coding Standard](https://github.com/doctrine/coding-standard), which is itself built on PSR-12 and adds many Slevomat sniffs. phpmath then removes a few sniffs and adds a few of its own.

```text
PSR-12
  Doctrine Coding Standard (adds Slevomat, Squiz and Generic sniffs)
    phpmath (this standard)
```

Your project references only `phpmath`. The ruleset file lives in `src/phpmath/ruleset.xml` of this package.

## What phpmath changes

Compared with plain Doctrine, the phpmath ruleset makes three kinds of changes. The table lists them.

| Change | Sniff | Why |
|---|---|---|
| Removed | `Generic.Formatting.MultipleStatementAlignment` | Aligned assignments create noisy diffs. |
| Removed | `Generic.Formatting.SpaceAfterCast` | No space is needed after a cast such as `(int)`. |
| Removed | `Generic.Formatting.SpaceAfterNot` | No space is needed after `!`. |
| Relaxed | `Squiz.Commenting.FunctionComment.SpacingAfterParamType` | Doc comments do not need aligned parameter names. |
| Configured | `SlevomatCodingStandard.TypeHints.ReturnTypeHintSpacing` | No space before the colon: `fn(): int`. |
| Configured | `SlevomatCodingStandard.TypeHints.DNFTypeHintFormat` | Nullable types are written short: `?int`. |
| Added | `SlevomatCodingStandard.Classes.RequireAbstractOrFinal` | Classes are `final` or `abstract`. |
| Added | `SlevomatCodingStandard.Classes.ReadonlyClass` | Classes that can be `readonly` are `readonly`. |

## Promises the ruleset makes itself

Some rules, such as strict types and native type hints, already come from the Doctrine base. phpmath lists them again in its own ruleset. This way the promises of phpmath hold even if the Doctrine base changes later. These are `DeclareStrictTypes`, `ParameterTypeHint`, `ReturnTypeHint`, `PropertyTypeHint`, `UnusedUses` and `AlphabeticallySortedUses`.

## What it enforces in plain language

The rules fall into a few themes. The [rules reference](rules.md) lists every one of them.

- **Strict, typed code.** Every file starts with `declare(strict_types=1);`, and every parameter, return value and property has a native type.
- **Tidy imports.** Every `use` statement is used, and the statements are sorted alphabetically. Classes, functions and constants are imported instead of written with a leading backslash.
- **Immutable by design.** Classes are `final` or `abstract`, and a class that can be `readonly` must be `readonly`. This suits the value objects of the phpmath libraries.
- **Modern PHP.** Constructor property promotion, the null coalescing and null safe operators, short array syntax and short nullable types.
- **Consistent formatting.** PSR-12 as extended by Doctrine: spacing, braces, trailing commas in multiline calls and no Yoda comparisons.

## Errors, fixing and sniff names

Every violation has a sniff name such as `SlevomatCodingStandard.Classes.RequireAbstractOrFinal.ClassNeitherAbstractNorFinal`. The first two parts name the sniff, and the last part names the exact message. You can exclude a whole sniff or just one message. See [Customizing](customizing.md).

Most formatting rules are fixable. `phpcs` marks those violations with `[x]`, and `phpcbf` applies the fix. Type hint violations are not fixable, because the tool cannot know which type you mean.

> [!NOTE]
> List every active sniff with `vendor/bin/phpcs -e --standard=phpmath`.
