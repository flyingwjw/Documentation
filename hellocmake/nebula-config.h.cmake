#ifndef NUBULA_NEBULA_CONFIG_H_INCLUDED_
#define NUBULA_NEBULA_CONFIG_H_INCLUDED_

#if defined(WINDOWS) || defined(WIN32)
#  ifdef NEBULA_LIB_DLL
#    if defined(WIN32) && (!defined(__BORLANDC__) || (__BORLANDC__ >= 0x500))
#      ifdef NEBULA_INTERNAL
#        define NEBULA_EXTERN extern __declspec(dllexport)
#      else
#        define NEBULA_EXTERN extern __declspec(dllimport)
#      endif
#    endif
#  endif  /* NEBULA_LIB_DLL */
#endif

#ifndef NEBULA_EXTERN
#  define NEBULA_EXTERN extern
#endif
#ifndef NEBULA_EXPORT
#  define NEBULA_EXPORT
#endif
#ifndef NEBULA_EXPORTVA
#  define NEBULA_EXPORTVA
#endif

#endif