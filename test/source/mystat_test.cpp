#include "mystat/mystat.hpp"

auto main() -> int
{
    return mystat::double_and_add_one(2) == 5 ? 0 : 1;
}
