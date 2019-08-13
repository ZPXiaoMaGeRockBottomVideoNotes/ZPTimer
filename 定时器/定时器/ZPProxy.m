//
//  ZPProxy.m
//  定时器
//
//  Created by 赵鹏 on 2019/8/9.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ZPProxy.h"

@implementation ZPProxy

+ (instancetype)proxyWithTarget:(id)target
{
    ZPProxy *proxy = [[ZPProxy alloc] init];
    proxy.target = target;
    
    return proxy;
}

/**
 在ViewController类中当系统调用"timerTest"方法，然后在这个方法中调用"+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;"方法的时候会报“消息找不到”错误，如果想避免这个错误，就要在本类中撰写如下的”消息转发“阶段的相关方法，因为当消息找不到的时候，系统就会自动的来到消息转发阶段，然后就会调用如下的方法。
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}

@end
