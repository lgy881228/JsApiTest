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

- (void)readJson
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Module"ofType:@"json"]];

    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@",dic);
}

- (id) syn:(id) arg
{
    NSLog(@"%@",arg);
    return arg;
}

- (void) asyn: (id) arg :(JSCallback)completionHandler
{
    NSLog(@"%@",arg);
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Module"ofType:@"json"]];

    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@",dic);
    
    
    completionHandler(arg,YES);
}

@end
