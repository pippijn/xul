// This is a simple class that lets us do easy (though not terribly efficient)
// trancoding of XMLCh data to local code page for display.
struct strx
{
  strx (XMLCh const *string)
    : local (XMLString::transcode (string))
  {
  }

  ~strx ()
  {
    XMLString::release (&local);
  }

  char *local;
};

static std::ostream &
operator << (std::ostream &target, strx const &x)
{
  target << x.local;
  return target;
}
