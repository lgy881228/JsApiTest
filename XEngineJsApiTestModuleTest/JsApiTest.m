//
//  JsApiTest.m
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//

#import "JsApiTest.h"
#import <dsBridge/dsbridge.h>

@interface JsApiTest(){
    NSTimer * timer ;
    void(^hanlder)(id value,BOOL isComplete);
    int value;
}
@end

@implementation JsApiTest
- (NSString *)presentDialog:(NSString *)msg {
    return [msg stringByAppendingString:@"调用了me"];
}

- (NSString *)presentoffLineController: (NSString *) msg {
    //      TEST native uicontroller over webviewcontroller
    return nil;
}

//- (NSString *)presentcontroller: (NSString *) msg {
//    //      TEST native uicontroller over webviewcontroller
//    UITabBarController* tab =   [[UITabBarController alloc] init];
//    NSMutableArray* viewControllers =[[NSMutableArray alloc]init];
//    for (int i =0; i<4; i++) {
//        UIViewController * vc=   [[UIViewController alloc]init];
//        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0];
//        vc.tabBarItem.title = [NSString stringWithFormat:@"bar title"];
//        [viewControllers addObject:vc];
//    }
//    
//    tab.viewControllers = viewControllers;
//    [self.vc presentViewController:tab animated:YES completion:nil];
//    return nil;
//}

- (NSString *)testSyn: (NSString *)msg {
    
    //        WARNING: UIview won't move with webview content
    //        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    //        view1.backgroundColor = [UIColor redColor];
    //        [self.vc.view addSubview:view1];//添加到self.view
    return [msg stringByAppendingString:@"[ syn call]"];
}

- (void) syncCalendar:(NSString *) msg :(JSCallback)completionHandler {
    completionHandler(@"testNoArgAsyn called [ syncCalendar call]",YES);
}


- (void) testAsyn:(NSString *) msg :(JSCallback) completionHandler
{
   dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.syncAndAsyncMix.serialQueue", NULL);
    dispatch_async(serialQueue, ^{
        [NSThread sleepForTimeInterval:3.000];
        completionHandler([msg stringByAppendingString:@"after 2 secs.  [ asyn call]"],YES);
    });
}

- (NSString *)testNoArgSyn:(NSDictionary *) args {
    return  @"testNoArgSyn called [ syn call]";
}

- ( void )testNoArgAsyn:(NSDictionary *) args :(JSCallback)completionHandler {
    completionHandler(@"testNoArgAsyn called [ asyn call]",YES);
}

- ( void )callProgress:(NSDictionary *) args :(JSCallback)completionHandler {
    value=10;
    hanlder=completionHandler;
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)onTimer:t {
    if(value!=-1) {
        hanlder([NSNumber numberWithInt:value--],NO);
    } else {
        hanlder(0,YES);
        [timer invalidate];
    }
}

/**
 * Note: This method is for Fly.js
 * In browser, Ajax requests are sent by browser, but Fly can
 * redirect requests to native, more about Fly see  https://github.com/wendux/fly
 * @param requestInfo passed by fly.js, more detail reference https://wendux.github.io/dist/#/doc/flyio-en/native
 */
- (void)onAjaxRequest:(NSDictionary *) requestInfo  :(JSCallback)completionHandler {
    NSLog(@"--------js返回的数据---------");
    NSLog(@"%@", requestInfo);
    NSLog(@"--------js返回的数据---------");
    
  
}

- (void)testAleart{
    NSLog(@"我是从js调用的方法 从oc里面显示");
}

- (NSString *)componentImageView:(NSString *)msg {
    
    return [msg stringByAppendingString:@"调用了componentImageView"];
}
- (NSString *)componentActionSheets:(NSString *)msg {
    
    return [msg stringByAppendingString:@"调用了componentActionSheets"];
}
- (NSString *)componentAlerts:(NSString *)msg {
    
    return [msg stringByAppendingString:@"调用了componentAlerts"];
}


- (id) syn:(id) arg
{
    return arg;
}

- (void) asyn: (id) arg :(JSCallback)completionHandler
{
    completionHandler(arg,YES);
}

@end
