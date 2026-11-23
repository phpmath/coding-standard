---
title: Continuous integration
intro: Run the coding standard on every push and pull request with GitHub Actions.
group: Guides
order: 40
---

## Why run it in CI

The coding standard only helps when every change passes it. Running `phpcs` in a GitHub Actions workflow fails a pull request that breaks a rule, so style discussions do not reach the review.

## A workflow

This is the workflow of the `phpmath/fraction` library. It runs the tests on three PHP versions, and the `phpcs` step is the coding standard check. The other steps belong to that library and you can drop them.

```yaml
name: CI

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        php: [ '8.4', '8.5', '8.6' ]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Set up PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: ${{ matrix.php }}
          tools: composer

      - name: Install Composer dependencies
        run: composer update --no-interaction --prefer-dist

      - name: Run PHPCS
        run: vendor/bin/phpcs
```

`vendor/bin/phpcs` exits with a non-zero status when it finds a violation, which fails the job. It reads your `phpcs.xml.dist`, so the workflow needs no extra options.

## A script for local use

Put the same command in a Composer script, so contributors run exactly what CI runs.

```json
{
    "scripts": {
        "check-style": "vendor/bin/phpcs",
        "fix-style": "vendor/bin/phpcbf"
    }
}
```

```bash
composer check-style
```

## Choosing PHP versions

The standard needs PHP 8.4 or newer, so test your library on 8.4 and up. If you only want to run the style check once, move the `phpcs` step into its own job with a single PHP version. The result does not depend on the PHP version for normal code.

> [!NOTE]
> The workflow installs dependencies with `composer update`. That is intended for libraries, which are tested against the newest versions their constraints allow. Applications should use `composer install` with a lock file.
