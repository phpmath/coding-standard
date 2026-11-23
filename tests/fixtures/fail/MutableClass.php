<?php

declare(strict_types=1);

namespace Phpmath\Fixtures;

final class MutableClass
{
    public function __construct(private readonly int $value)
    {
    }

    public function value(): int
    {
        return $this->value;
    }
}
