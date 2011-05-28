dnl Copyright © 2011 Pippijn van Steenhoven
dnl See COPYING for licence information.

AC_PREREQ(2.61)
AC_INIT([Gozer], [0.1], [gozer@xinutec.org])
AC_CONFIG_AUX_DIR(autoconf)
AC_CONFIG_SRCDIR(config.h.in)
AC_CONFIG_MACRO_DIR(m4)
AC_CONFIG_HEADERS(config.h)

dnl automake
LT_INIT([disable-static])
AM_INIT_AUTOMAKE([silent-rules gnits parallel-tests color-tests])
AM_SILENT_RULES([yes])

# build tools
AC_LANG(C++)
AC_PROG_CXX
AC_PROG_LEX
AC_PROG_YACC

# libraries
AP_PKG_CHECK([libxml-2.0], 2.7.8)
AP_PKG_CHECK([libxslt], 1.1.26)
AP_PKG_CHECK([xerces-c], 3.1.1)

AC_CONFIG_FILES([Makefile src/compiler/gozerc])
AC_OUTPUT
