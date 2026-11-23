---
title: Introduction
intro: The shared PHP_CodeSniffer ruleset that every phpmath library uses.
group: Getting started
order: 10
---

## Requirements

The ruleset runs on a current PHP version and pulls in everything else through Composer.

- PHP 8.4 or newer
- [Composer](https://getcomposer.org)

## Installation

Install the standard as a development dependency. It requires the Doctrine Coding Standard, which brings PHP_CodeSniffer and the Slevomat sniffs with it.

```bash
composer require --dev phpmath/coding-standard
```

Composer asks whether to allow the `dealerdirect/phpcodesniffer-composer-installer` plugin. Allow it, because it registers the `phpmath` standard with PHP_CodeSniffer. You can also allow it up front in your `composer.json`.

```json
{
    "config": {
        "allow-plugins": {
            "dealerdirect/phpcodesniffer-composer-installer": true
        }
    }
}
```

## Configuring a project

Create a `phpcs.xml.dist` in the root of your project. It lists the folders to check and uses the `phpmath` ruleset.

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

Add `.phpcs-cache` to your `.gitignore`, because it only speeds up local runs.

## Running the checks

`phpcs` reports every violation. `phpcbf` rewrites the files to fix what it can fix automatically.

```bash
vendor/bin/phpcs
vendor/bin/phpcbf
```

Add `-s` to `phpcs` to show the name of the sniff behind each message. You need that name to [exclude a sniff](customizing.md). A violation marked `[x]` in the report is fixable by `phpcbf`.

```bash
vendor/bin/phpcs -s
```

## Where to go next

Start with the core concepts, or jump straight to the topic you need.

<div class="cards"><a href="concepts.md"><strong>Core concepts</strong><span>How the ruleset is composed and what it enforces.</span></a><a href="customizing.md"><strong>Customizing</strong><span>Exclude a sniff in your own ruleset.</span></a><a href="ci.md"><strong>Continuous integration</strong><span>Run the checks in GitHub Actions.</span></a><a href="rules.md"><strong>Rules</strong><span>Every enforced rule with examples.</span></a></div>
