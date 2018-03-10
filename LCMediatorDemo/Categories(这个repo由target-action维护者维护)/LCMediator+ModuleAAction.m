//
//  LCMediator+ModuleAAction.m
//  LCMediatorDemo
//
//  Created by MarisLin on 2018/3/10.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "LCMediator+ModuleAAction.h"

NSString *const kTargetA = @"A";
NSString *const kActionNativFetchDetailViewController = @"nativFetchDetailViewController";

NSString *const kActionShowAlert = @"showAlert";

@implementation LCMediator (ModuleAAction)

-(UIViewController *)lcm_ViewControllerForDetailWithParams:(NSDictionary *)params
{
    UIViewController *vc = [self performTarget:kTargetA action:kActionNativFetchDetailViewController params:params shouldCacheTarget:NO];
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }else{
        return [UIViewController new];
    }
}

-(void)lcm_showAlertWithMessage:(NSString *)message cancelAction:(void (^)(NSDictionary *))cancelAction confirmAction:(void (^)(NSDictionary *))confirmAction
{
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (cancelAction) {
        paramsToSend[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        paramsToSend[@"confirmAction"] = confirmAction;
    }
    
    [self performTarget:kTargetA
                 action:kActionShowAlert
                 params:paramsToSend
      shouldCacheTarget:NO];
}

@end
