//
//  JsApiTest.m
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//

#import "JsApiTest.h"
#import <dsbridge/dsbridge.h>

@interface JsApiTest()
    
@end

@implementation JsApiTest


- (id) syn:(id) arg
{
    NSLog(@"%@",arg);
    return arg;
}

- (void) asyn: (id) arg :(JSCallback)completionHandler
{
    NSLog(@"%@",arg);
    completionHandler(arg,YES);
}

@end
