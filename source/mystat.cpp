#include <string>

#include "mystat/mystat.hpp"

exported_class::exported_class()
    : m_name {"mystat"}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
