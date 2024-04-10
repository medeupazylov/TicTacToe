#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "krestik" asset catalog image resource.
static NSString * const ACImageNameKrestik AC_SWIFT_PRIVATE = @"krestik";

/// The "nolik" asset catalog image resource.
static NSString * const ACImageNameNolik AC_SWIFT_PRIVATE = @"nolik";

#undef AC_SWIFT_PRIVATE