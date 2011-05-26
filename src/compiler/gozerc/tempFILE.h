struct tempFILE
{
  tempFILE (std::string const &file)
    : fh (fopen (file.c_str (), "w"))
  {
    if (!fh)
      die ("could not open " + file + " for writing: " + strerror (errno));
  }

  ~tempFILE ()
  {
    if (fh)
      fclose (fh);
  }

  operator FILE * () { return fh; }

private:
  FILE *const fh;
};
