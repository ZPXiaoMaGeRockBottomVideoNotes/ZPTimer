//
//  ZPProxy1.h
//  定时器
//
//  Created by 赵鹏 on 2019/8/13.
//  Copyright © 2019 赵鹏. All rights reserved.
//

/**
 "NSProxy"类是专门用来解决其他类的代理行为和转发行为的，也就是当其他类只要调用NSProxy类或者它的子类的某个方法的时候，系统就会直接调用NSProxy类的"- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel"方法，然后接着调用NSProxy类的"- (void)forwardInvocation:(NSInvocation *)invocation"方法；
 "NSProxy"和"NSObject"类是同一个级别的，iOS中的其他类都会继承于"NSObject"类，但是"NSProxy"例外，它不继承于任何类。
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPProxy1 : NSProxy

@property (nonatomic, weak) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
