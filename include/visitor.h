#pragma once

namespace nodes
{
  struct document;
  struct node_list;
  struct element;
  struct attribute;
  struct text;
}

struct visitor
{
  virtual void visit (nodes::document const *n) = 0;
  virtual void visit (nodes::node_list const *n) = 0;
  virtual void visit (nodes::element const *n) = 0;
  virtual void visit (nodes::attribute const *n) = 0;
  virtual void visit (nodes::text const *n) = 0;
};
