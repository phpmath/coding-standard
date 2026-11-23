<?php

declare(strict_types=1);

namespace Phpmath\Fixtures;

use Stringable;
use Countable;
use ArrayAccess;

final readonly class UnusedAndUnsortedImports implements Stringable, Countable
{
    public function __toString(): string
    {
        return '';
    }

    public function count(): int
    {
        return 0;
    }
}
