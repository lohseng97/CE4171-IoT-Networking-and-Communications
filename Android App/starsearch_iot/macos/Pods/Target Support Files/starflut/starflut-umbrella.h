#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "starflut_plugin_common.h"

FOUNDATION_EXPORT double starflutVersionNumber;
FOUNDATION_EXPORT const unsigned char starflutVersionString[];

