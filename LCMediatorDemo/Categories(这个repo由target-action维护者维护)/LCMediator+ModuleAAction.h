//
//  LCMediator+ModuleAAction.h
//  LCMediatorDemo
//
//  Created by MarisLin on 2018/3/10.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "LCMediator.h"
#import <UIKit/UIKit.h>

@interface LCMediator (ModuleAAction)

-(UIViewController *)lcm_ViewControllerForDetailWithParams:(NSDictionary *)params;

-(void)lcm_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *))confirmAction;

@end
