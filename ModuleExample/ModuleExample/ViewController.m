//
//  ViewController.m
//  ModuleExample
//
//  Created by edz on 2020/7/14.
//  Copyright © 2020 edz. All rights reserved.
//

#import "ViewController.h"
#import <dsBridge/dsbridge.h>
#import "JsApiTest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect bounds=self.view.bounds;
//    JsApiTest *jsonread = [[JsApiTest alloc] init];
//    [jsonread readJson];
       DWKWebView * dwebview=[[DWKWebView alloc] initWithFrame:CGRectMake(0, 25, bounds.size.width, bounds.size.height-25)];
       [self.view addSubview:dwebview];
       
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Module"ofType:@"json"]];

       NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
       
       NSLog(@"%@",dic);
    for (NSDictionary *obj in dic[@"Modules"]) {

        NSString *value = obj[@"value"];
        NSString *key = obj[@"key"];
        id obj = [[NSClassFromString(value) alloc] init];
        NSLog(@"%@",obj);
        [dwebview addJavascriptObject:obj namespace:key];
    }
       // register api object without namespace
//       JsApiTest  * js =   [[JsApiTest alloc] init];
//       [dwebview addJavascriptObject:js namespace:nil];
//       js.vc = self;
       
       // register api object without namespace
//       [dwebview addJavascriptObject:[[ JsApiTestSwift alloc] init] namespace:@"swift"];
       
       // register api object with namespace "echo"
//       [dwebview addJavascriptObject:[[JsEchoApi alloc] init] namespace:@"echo"];
       
       // open debug mode, Release mode should disable this.
       [dwebview setDebugMode:false];
       
       [dwebview customJavascriptDialogLabelTitles:@{@"alertTitle":@"Notification",@"alertBtn":@"OK"}];
       
       dwebview.navigationDelegate=self;
       
       // load test.html
       NSString *path = [[NSBundle mainBundle] bundlePath];
       NSURL *baseURL = [NSURL fileURLWithPath:path];
       NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test"
                                                             ofType:@"html"];
       NSString * htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                          encoding:NSUTF8StringEncoding
                                                             error:nil];
       //    NSString *htmlContent = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://your.url"] encoding:NSUTF8StringEncoding error:nil];
       
       
       [dwebview loadHTMLString:htmlContent baseURL:baseURL];
       //    [dwebview loadUrl:@"http://192.168.3.129:8088/"];
       
       // call javascript method
       [dwebview callHandler:@"addValue" arguments:@[@3,@4] completionHandler:^(NSNumber * value){
           NSLog(@"%@",value);
       }];
       
       [dwebview callHandler:@"append" arguments:@[@"I",@"love",@"you"] completionHandler:^(NSString * _Nullable value) {
           NSLog(@"call succeed, append string is: %@",value);
       }];
       
       // this invocation will be return 5 times
       [dwebview callHandler:@"startTimer" completionHandler:^(NSNumber * _Nullable value) {
           NSLog(@"Timer: %@",value);
       }];
       
       // namespace syn test
       [dwebview callHandler:@"syn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
           NSLog(@"Namespace syn.addValue(5,6): %@",value);
       }];
       
       [dwebview callHandler:@"syn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
           NSLog(@"Namespace syn.getInfo: %@",value);
       }];
       
       // namespace asyn test
       [dwebview callHandler:@"asyn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
           NSLog(@"Namespace asyn.addValue(5,6): %@",value);
       }];
       
       [dwebview callHandler:@"asyn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
           NSLog(@"Namespace asyn.getInfo: %@",value);
       }];
       
       // test if javascript method exists.
       [dwebview hasJavascriptMethod:@"addValue" methodExistCallback:^(bool exist) {
           NSLog(@"method 'addValue' exist : %d",exist);
       }];
       
       [dwebview hasJavascriptMethod:@"XX" methodExistCallback:^(bool exist) {
           NSLog(@"method 'XX' exist : %d",exist);
       }];
       
       [dwebview hasJavascriptMethod:@"asyn.addValue" methodExistCallback:^(bool exist) {
           NSLog(@"method 'asyn.addValue' exist : %d",exist);
       }];
       
       [dwebview hasJavascriptMethod:@"asyn.XX" methodExistCallback:^(bool exist) {
           NSLog(@"method 'asyn.XX' exist : %d",exist);
       }];
       
       // set javascript close listener
       [dwebview setJavascriptCloseWindowListener:^{
           NSLog(@"window.close called");
       } ];
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
//    [super dealloc];
}

@end
