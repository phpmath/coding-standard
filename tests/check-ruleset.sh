#!/usr/bin/env sh
# Proves the ruleset works: valid code passes, every invalid fixture fails
# with the sniff it is meant to trigger. Run from the repository root.
set -u

PHPCS="vendor/bin/phpcs -s -q --standard=tests/phpcs.xml"
failures=0

pass() { echo "ok:   $1"; }
fail() { echo "FAIL: $1"; failures=$((failures + 1)); }

test_valid_fixture_passes() {
    # Arrange
    target="tests/fixtures/pass"

    # Act
    $PHPCS "$target" > /dev/null
    status=$?

    # Assert
    [ "$status" -eq 0 ] && pass "valid fixture passes" || fail "valid fixture passes"
}

# $1 fixture file, $2 expected sniff source fragment
test_invalid_fixture_reports() {
    # Arrange
    target="tests/fixtures/fail/$1"

    # Act
    output=$($PHPCS --report=full "$target")
    status=$?

    # Assert
    if [ "$status" -ne 0 ] && echo "$output" | grep -q "$2"; then
        pass "$1 reports $2"
    else
        fail "$1 reports $2"
    fi
}

test_no_em_dash_in_repository() {
    # Arrange
    dash=$(printf '\342\200\224')

    # Act
    hits=$(grep -rIl "$dash" --exclude-dir=vendor --exclude-dir=.git --exclude=composer.lock . || true)

    # Assert
    [ -z "$hits" ] && pass "no em dashes in repository" || fail "em dash found in: $hits"
}

test_valid_fixture_passes
test_invalid_fixture_reports MissingStrictTypes.php DeclareStrictTypes
test_invalid_fixture_reports MissingNativeTypes.php TypeHints
test_invalid_fixture_reports UnusedAndUnsortedImports.php UnusedUses
test_invalid_fixture_reports UnusedAndUnsortedImports.php AlphabeticallySortedUses
test_invalid_fixture_reports NonFinalClass.php RequireAbstractOrFinal
test_invalid_fixture_reports MutableClass.php ReadonlyClass
test_no_em_dash_in_repository

[ "$failures" -eq 0 ]
