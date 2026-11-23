---
title: Customizing
intro: Exclude a sniff in your project without giving up the rest of the standard.
group: Guides
order: 30
---

## Excluding a sniff

Sometimes a rule does not fit one project. You can exclude it in your own `phpcs.xml.dist` by adding an `exclude` element inside the `phpmath` rule. Every other rule stays active.

A project that keeps long lines in its source, for example, can turn off the line length warning.

```xml
<?xml version="1.0"?>
<ruleset name="vendor/project">
    <description>The coding standards of vendor/project.</description>

    <arg name="basepath" value="."/>
    <arg name="extensions" value="php"/>
    <arg name="cache" value=".phpcs-cache"/>

    <file>src/</file>
    <file>tests/</file>

    <rule ref="phpmath">
        <exclude name="Generic.Files.LineLength.TooLong"/>
    </rule>
</ruleset>
```

Without the exclude, a line of more than 120 characters reports `Line exceeds 120 characters`. With it, the file passes.

## Finding the sniff name

The `name` of an exclude is the sniff source. Run `phpcs` with `-s` and read the name in brackets below each message.

```bash
vendor/bin/phpcs -s
```

```text
 11 | WARNING | Line exceeds 120 characters; contains 128 characters
    |         | (Generic.Files.LineLength.TooLong)
```

## How specific an exclude can be

A sniff source has up to four parts. The more parts you give, the less you turn off.

| Name | Excludes |
|---|---|
| `SlevomatCodingStandard` | The whole Slevomat standard. Avoid this. |
| `Generic.Files` | All sniffs in the `Files` category of the Generic standard. |
| `Generic.Files.LineLength` | All messages of one sniff. |
| `Generic.Files.LineLength.TooLong` | One message of one sniff. |

Prefer the most specific form, so the sniff keeps catching the other problems it detects.

> [!WARNING]
> Do not exclude the sniffs that carry the phpmath promises, such as `DeclareStrictTypes`, `RequireAbstractOrFinal` or `ReadonlyClass`, unless you have a strong reason. They are what makes the libraries look and behave alike.

## Excluding folders and files

To skip files instead of a rule, add an `exclude-pattern` to your ruleset. It takes a regular expression that is matched against the path.

```xml
<exclude-pattern>tests/fixtures/*</exclude-pattern>
```

## Ignoring a single place in code

To silence a rule for one line, use a `phpcs:ignore` comment with the sniff name. This keeps the exception visible in the code where it is needed.

```php
// phpcs:ignore Generic.Files.LineLength.TooLong
$message = 'A message that is longer than one hundred and twenty characters, which the standard normally does not allow.';
```
