//
//  NSNumber+JSSkeleton.m
//  JSSkeleton
//
//  Created by jiasong on 2020/8/24.
//  Copyright © 2020 jiasong. All rights reserved.
//

#import "NSNumber+JSSkeleton.h"

@implementation NSNumber (JSSkeleton)

- (CGFloat)js_CGFloatValue {
#if CGFLOAT_IS_DOUBLE
    return self.doubleValue;
#else
    return self.floatValue;
#endif
}

@end
