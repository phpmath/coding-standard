<?php

declare(strict_types=1);

namespace Phpmath\Fixtures;

use InvalidArgumentException;

final readonly class Valid
{
    public function __construct(private int $value)
    {
    }

    public function add(int $other): self
    {
        if ($other < 0) {
            throw new InvalidArgumentException('Negative values are not allowed.');
        }

        return new self($this->value + $other);
    }

    public function value(): int
    {
        return $this->value;
    }
}
