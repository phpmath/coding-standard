---
title: Upgrading from 1.x
intro: This version requires PHP 8.4, makes the phpmath promises explicit and adds rules for final and readonly classes.
group: Reference
order: 90
---

## Summary of changes

This version is a breaking release, because it adds rules that existing code may not satisfy. These are the changes that affect your project.

- PHP 8.4 or newer is required. Version 1.x allowed PHP 8.2.
- New: every class must be `final` or `abstract` (`SlevomatCodingStandard.Classes.RequireAbstractOrFinal`).
- New: a class that can be `readonly` must be `readonly` (`SlevomatCodingStandard.Classes.ReadonlyClass`).
- Explicit: strict types, native parameter, return and property types, unused imports and sorted imports are now listed in the phpmath ruleset itself.
- The base standard is Doctrine Coding Standard 14. Version 1.x used version 13.
- Changed: exception names keep the `Exception` suffix. The suffix message of `SuperfluousExceptionNaming` is turned off, so libraries no longer need their own exclude.
- The deprecated `UnionTypeHintFormat` sniff is replaced by `DNFTypeHintFormat`, with the same `?int` short nullable setting.

> [!NOTE]
> The strict types, native types and import rules were already part of the Doctrine base in 1.x, so most code that passed 1.x already follows them. What 2.0 changes is that phpmath declares them itself, so they keep applying if the Doctrine base changes. The two rules that are truly new are final or abstract classes and readonly classes.

## Step by step

Follow these steps to move an existing project from 1.x.

### 1. Update the requirement

Require the new major version and make sure your project runs on PHP 8.4 or newer.

```bash
composer require --dev phpmath/coding-standard
```

Composer also upgrades `doctrine/coding-standard` to version 14, because it is a dependency of the standard.

### 2. Let phpcbf fix what it can

The two new rules are fixable. Run `phpcbf` first, and it adds `final` to your classes and moves `readonly` from properties to the class.

```bash
vendor/bin/phpcbf
```

### 3. Review the remaining violations

Run `phpcs` and fix what is left. Most of it is covered by the three cases below.

```bash
vendor/bin/phpcs -s
```

#### Classes that are not final

Make the class `final`. If the class is meant as a base class, make it `abstract` instead. If you need neither, [exclude the sniff](customizing.md) in your own ruleset.

```php
// before
class Money

// after
final class Money
```

#### Classes that can be readonly

When every property is `readonly`, move the keyword to the class. A `readonly` class makes all its properties `readonly`, so the keyword on each property is dropped.

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

> [!WARNING]
> Mocking frameworks cannot extend a `final` class. If your tests mock a class that is now `final`, mock its interface instead, or use a real instance, which is easy for immutable value objects.

#### Missing native types

The type hint sniffs are not fixable. Add a native type to every parameter, return value and property that the report lists.

```php
// before
public function add($value)

// after
public function add(int $value): int
```

### 4. Exclude what does not fit

If a rule does not suit your project, exclude that one sniff in `phpcs.xml.dist`. See [Customizing](customizing.md). You no longer need to exclude the exception suffix rule yourself, because the standard allows names such as `InvalidValueException`. Remove that exclude from your ruleset if you have one.

```xml
<rule ref="phpmath">
    <exclude name="Generic.Files.LineLength.TooLong"/>
</rule>
```
