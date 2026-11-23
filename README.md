# coding-standard

[![Latest Version on Packagist][ico-version]][link-packagist]
[![Software License][ico-license]](LICENSE)
[![CI][ico-ci]][link-ci]
[![Total Downloads][ico-downloads]][link-downloads]

The shared [PHP_CodeSniffer](https://github.com/PHPCSStandards/PHP_CodeSniffer) ruleset used by all phpmath libraries. It is built on the [Doctrine Coding Standard](https://github.com/doctrine/coding-standard) (PSR-12 based, plus Slevomat sniffs) with a few phpmath specific changes.

## Documentation

The full documentation is at https://phpmath.github.io/coding-standard/. Every change is listed in the [changelog](CHANGELOG.md) and every release on the [releases page](https://github.com/phpmath/coding-standard/releases).

## Install

```bash
composer require --dev phpmath/coding-standard
```

Composer asks whether to allow the `dealerdirect/phpcodesniffer-composer-installer` plugin, which registers the standard with PHP_CodeSniffer. Allow it in your `composer.json`:

```json
"config": {
    "allow-plugins": {
        "dealerdirect/phpcodesniffer-composer-installer": true
    }
}
```

## Requirements

- PHP 8.4 or newer
- `doctrine/coding-standard`

## Usage

Create a `phpcs.xml.dist` in your project and reference the `phpmath` standard:

```xml
<?xml version="1.0"?>
<ruleset name="my/library">
    <arg name="basepath" value="."/>
    <arg name="extensions" value="php"/>
    <arg name="cache" value=".phpcs-cache"/>

    <file>src/</file>
    <file>tests/</file>

    <rule ref="phpmath"/>
</ruleset>
```

Run `vendor/bin/phpcs` to check and `vendor/bin/phpcbf` to fix what can be fixed automatically. Individual sniffs can be disabled with `<exclude name="..."/>` inside the `<rule ref="phpmath">` element.

## What is enforced

* `declare(strict_types=1);` in every file (`SlevomatCodingStandard.TypeHints.DeclareStrictTypes`).
* Native parameter, return and property types (`ParameterTypeHint`, `ReturnTypeHint`, `PropertyTypeHint`).
* No unused imports and imports sorted alphabetically (`Namespaces.UnusedUses`, `Namespaces.AlphabeticallySortedUses`).
* Classes are `final` or `abstract` (`Classes.RequireAbstractOrFinal`).
* Classes that can be `readonly` are `readonly` (`Classes.ReadonlyClass`), supporting immutable value objects.
* Constructor property promotion, null coalescing and null safe operators, short nullable syntax (`?int`).
* Formatting: PSR-12 as extended by the Doctrine Coding Standard.

Everything else comes from the [Doctrine ruleset](https://github.com/doctrine/coding-standard). List all active sniffs with `vendor/bin/phpcs -e --standard=phpmath`.

## Development

The ruleset is tested against small fixtures: `tests/fixtures/pass` must produce no violations, and every file in `tests/fixtures/fail` must trigger the sniff it is named for. The same script rejects the em dash character anywhere in the repository.

```bash
composer install
composer test
```

## Contributing

All contributions are welcome. Open an issue or a pull request on GitHub. Please follow the coding standard and add tests.

## Security

If you discover a security issue, please create an issue in the issue tracker.

## Credits

- [Walter Tamboer](https://github.com/waltertamboer)
- [All contributors](https://github.com/phpmath/coding-standard/graphs/contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.

[ico-version]: https://img.shields.io/packagist/v/phpmath/coding-standard.svg?style=flat-square
[ico-license]: https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square
[ico-ci]: https://img.shields.io/github/actions/workflow/status/phpmath/coding-standard/ci.yml?branch=master&style=flat-square
[ico-downloads]: https://img.shields.io/packagist/dt/phpmath/coding-standard.svg?style=flat-square

[link-packagist]: https://packagist.org/packages/phpmath/coding-standard
[link-ci]: https://github.com/phpmath/coding-standard/actions/workflows/ci.yml
[link-downloads]: https://packagist.org/packages/phpmath/coding-standard/stats
