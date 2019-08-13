//
//  ZPProxy1.m
//  定时器
//
//  Created by 赵鹏 on 2019/8/13.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ZPProxy1.h"

@implementation ZPProxy1

+ (instancetype)proxyWithTarget:(id)target
{
    ZPProxy1 *proxy = [ZPProxy1 alloc];  //因为NSProxy类没有init方法，所以在创建的时候不需要调用init方法。
    proxy.target = target;
    
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end
