static timeval
operator - (timeval const &a, timeval const &b)
{
  timeval res;
  timersub (&a, &b, &res);
  return res;
}

static std::ostream &
operator << (std::ostream &os, timeval const &tv)
{
  return os << tv.tv_sec << '.' << std::setfill ('0') << std::setw (6) << tv.tv_usec;
}

struct timer
{
  timer (char const *phase, bool toplevel = false)
    : phase (phase)
    , start (gettimeofday ())
    , toplevel (!exists || toplevel)
  {
    if (!toplevel)
      exists = true;
  }

  ~timer ()
  {
    if (toplevel)
      {
#if TIMING
        std::cout << std::setfill (' ') << std::setw (10) << phase << ": " << gettimeofday () - start << " sec\n";
#endif
        exists = false;
      }
  }

private:
  static timeval gettimeofday ()
  {
    timeval tv;
    ::gettimeofday (&tv, NULL);
    return tv;
  }

  char const *const phase;
  timeval const start;
  bool const toplevel;
  static bool exists;
};

bool timer::exists;
