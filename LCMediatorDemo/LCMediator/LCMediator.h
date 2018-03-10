//
//  LCMediator.h
//  LCMediatorDemo
//
//  Created by MarisLin on 2018/3/9.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCSingleton.h"

@interface LCMediator : NSObject

LCSingletonH(LCMediator)

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end
