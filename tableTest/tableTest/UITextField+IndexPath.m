//
//  UITextField+IndexPath.m
//  tableTest
//
//  Created by 科pro on 2018/10/19.
//  Copyright © 2018年 palmble. All rights reserved.
//

#import "UITextField+IndexPath.h"
#import <objc/runtime.h>

@implementation UITextField (IndexPath)

static char indexPathKey;
- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &indexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
