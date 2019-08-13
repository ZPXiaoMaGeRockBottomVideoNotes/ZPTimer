//
//  ZPProxy.h
//  定时器
//
//  Created by 赵鹏 on 2019/8/9.
//  Copyright © 2019 赵鹏. All rights reserved.
//

//本类是为了解决NSTimer对象调用"+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;"方法的时候NSTimer对象和视图控制器相互强引用所造成的问题而创建的。

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPProxy : NSObject

@property (nonatomic, weak) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
