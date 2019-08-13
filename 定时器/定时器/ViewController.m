//
//  ViewController.m
//  定时器
//
//  Created by 赵鹏 on 2019/8/6.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ViewController.h"
#import "ZPProxy.h"
#import "ZPProxy1.h"

@interface ViewController ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self timerTest];
    
//    [self timerTest1];
    
//    [self linkTest];
}

/**
 以这种方式创建的定时器对象，系统已经把它自动地放到当前的RunLoop中了，所以就不需要手动再放到当前的RunLoop中了；
 以这种方式创建定时器对象的话，一般在创建方法中把target后面的参数写为self，即本视图控制器；
 以这种方式创建定时器对象有一个弊端就是创建出来的定时器对象是本视图控制器的一个属性，所以本视图控制器会用一个强指针指着这个NSTimer对象，而NSTimer对象里面又有一个target，这个target会用一个强指针指着本视图控制器，所以这就造成了NSTimer对象和本视图控制器相互用强指针指着的情况了，这样的话就会使本视图控制器在想要释放的时候无法被释放掉。要想解决这个问题，就需要构造一个代理类，让NSTimer对象里面的target用强指针指着这个代理类，然后在代理类中也设置一个target，让这个target用弱指针指着本视图控制器，所以现在的情况就是，NSTimer对象里面的target用强指针指着代理类，代理类里面的target用弱指针指着本视图控制器，本视图控制器里面的timer属性用强指针指着那个NSTimer对象，这样的话本视图控制器就没有被强指针指着了，所以在它想要释放的时候就能够被释放掉了；
 除了利用ZPProxy类来做代理行为，还可以使用ZPProxy1类来做代理行为，只需把下面方法中的"ZPProxy"改为"ZPProxy1"即可；
 在本项目中相比"ZPProxy"类，更建议使用"ZPProxy1"类，因为ZPProxy1比ZPProxy类省去了在系统中查找相关方法的几个步骤，更高效。
 */
- (void)timerTest
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[ZPProxy proxyWithTarget:self] selector:@selector(timerRun) userInfo:nil repeats:YES];
}

/**
 以如下的这种方式创建的定时器对象不同于上面方法中的创建定时器对象的方式。以如下的这种方式创建NSTimer对象，最后的情况就是，因为NSTimer对象是本视图控制器的一个属性，所以本视图控制器会用一个强指针指着这个NSTimer对象，而NSTimer对象里面又有一个block，因为在block外面已经把本视图控制器设为了__weak，所以NSTimer对象里面的block会用一个弱指针指着本视图控制器，在这种情况下，本视图控制器没有被强指针指着，所以在需要释放的时候能够被释放掉。
 */
- (void)timerTest1
{
    __weak typeof (self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerRun];
    }];
}

- (void)timerRun
{
    NSLog(@"%s", __func__);
}

/**
 用这种方式创建的CADisplayLink对象和在"timerTest"方法中创建的NSTimer对象一样，也会面临着CADisplayLink对象和本视图控制器相互用强指针指着，本视图控制器不能被释放掉的情况。想要解决这个问题也是用和"timerTest"方法中一样的方式去解决。
 */
- (void)linkTest
{
    //调用频率和屏幕的刷帧频率一致，每秒会调用60次；
    self.link = [CADisplayLink displayLinkWithTarget:[ZPProxy proxyWithTarget:self] selector:@selector(linkRun)];
    
    //必须要添加到当前的RunLoop中link才能开始工作了。
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)linkRun
{
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    [self.timer invalidate];
    
//    [self.link invalidate];
}

@end
