static void
tidy (std::string const &file)
{
  timer const T (__func__);
  TidyDoc tdoc = tidyCreate ();

  int rc = -1;
  bool ok = true;
  
  if (ok) ok = tidyOptSetBool (tdoc, TidyXmlTags, yes);
  if (ok) ok = tidyOptSetInt  (tdoc, TidyIndentContent, TidyAutoState);

  if (ok) rc = 0;
  
  if (rc >= 0) rc = tidyParseFile (tdoc, file.c_str ());// Parse the input
  if (rc >= 0) rc = tidyCleanAndRepair (tdoc);          // Tidy it up!
  if (rc >= 0) rc = tidySaveFile (tdoc, file.c_str ()); // Write cleaned up markup back

  if (tidyErrorCount (tdoc) || tidyWarningCount (tdoc) || tidyAccessWarningCount (tdoc))
    tidyErrorSummary (tdoc);

  tidyRelease (tdoc);

#if PROGRESS
  std::cout << '.' << std::flush;
#endif
}
