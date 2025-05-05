#include <string>

#include "mystat/mystat.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("mystat") == exported.name() ? 0 : 1;
}
