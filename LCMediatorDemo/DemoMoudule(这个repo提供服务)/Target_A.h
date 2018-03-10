//
//  Target_A.h
//  LCMediatorDemo
//
//  Created by MarisLin on 2018/3/10.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_A : NSObject

-(UIViewController *)Action_nativFetchDetailViewController:(NSDictionary *)params;

- (id)Action_showAlert:(NSDictionary *)params;

@end
