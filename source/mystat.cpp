#include "mystat/mystat.hpp"
#include "helper_.hpp"

namespace
{

constexpr auto multiply_by_two_(int x) -> int
{
    return 2 * x;
}

}  // anonymous namespace


namespace mystat
{

auto double_and_add_one(int x) -> int
{
    const auto y = multiply_by_two_(x);
    const auto z = impl_mystat::add_one(y);

    return z;
}

}  // namespace mystat

