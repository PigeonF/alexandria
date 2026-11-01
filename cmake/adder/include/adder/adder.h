#ifndef ADDER_ADDER_H
#define ADDER_ADDER_H

#if !defined(__has_attribute)
#  define __has_attribute(x) 0
#endif

#if !defined(ADDER_EXTERN)
#  if defined(__cplusplus)
#    define ADDER_EXTERN extern "C"
#  else
#    define ADDER_EXTERN extern
#  endif
#endif

#if !defined(ADDER_EXPORT)
#  if defined(_WIN32) || defined(_WIN64) || defined(__CYGWIN__)
#    if defined(ADDER_BUILD_SHARED_LIBRARY)
#      define ADDER_EXPORT __declspec(dllexport)
#    elif defined(ADDER_SHARED_LIBRARY)
#      define ADDER_EXPORT __declspec(dllimport)
#    else
#      define ADDER_EXPORT
#    endif
#  elif __has_attribute(visibility)
#    define ADDER_EXPORT __attribute__((visibility("default")))
#  else
#    define ADDER_EXPORT
#  endif
#endif

#if !defined(ADDER_API)
#  define ADDER_API ADDER_EXTERN ADDER_EXPORT
#endif

#endif // ADDER_ADDER_H
