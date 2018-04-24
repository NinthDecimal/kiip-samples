@import Foundation;

@interface ObjCObjectFactory : NSObject

+ (id)create:(NSString *)className;

+ (id)create:(NSString *)className initializer:(SEL)initializer argument:(id)argument;

@end
