#pragma once

#include <tr1/memory>

#include "visitor.h"

struct xmlvisitor
  : visitor
{
  xmlvisitor ();
  ~xmlvisitor ();

  void visit (nodes::document const *n);
  void visit (nodes::node_list const *n);
  void visit (nodes::element const *n);
  void visit (nodes::attribute const *n);
  void visit (nodes::text const *n);

  std::tr1::shared_ptr<struct predicate> pred;
};
