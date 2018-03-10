//
//  LCMediator.m
//  LCMediatorDemo
//
//  Created by MarisLin on 2018/3/9.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "LCMediator.h"
#import <UIKit/UIKit.h>

@interface LCMediator()

@property(nonatomic,strong) NSMutableDictionary *cachedTarget;

@end

@implementation LCMediator
LCSingletonM(LCMediator)

-(id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget
{
    NSString *targetString = [NSString stringWithFormat:@"Target_%@",targetName];
    NSString *actionString = [NSString stringWithFormat:@"Action_%@:",actionName];
    
    Class targetClass;
    id target = self.cachedTarget[targetString];
    if (!target) {
        targetClass = NSClassFromString(targetString);
        target = [[targetClass alloc] init];
    }
    
    // 处理无响应请求
    // 若没有可以响应的target,可以直接return,或者固定一个target
    if (!target) {
        return nil;
    }
    shouldCacheTarget ? self.cachedTarget[targetString] = target : nil;

    // SEL 类似C,C++,中的函数指针
    SEL action = NSSelectorFromString(actionString);
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target params:params];
        
    }else {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action]) {
            return [self safePerformAction:action target:target params:params];
        }else{
            
            // 如果连notFound也找不到,就直接返回nil
            [self.cachedTarget removeObjectForKey:targetString];
            return nil;
        }
    }
}

#pragma mark - private methods

-(id)safePerformAction:(SEL)action target:(id)target params:(NSDictionary *)params
{
    // NSMethodSignature 方法签名
    // 苹果官方定义该类为对方法的参数、返回类似进行封装，协同NSInvocation实现消息转发。
    // 通过消息转发实现类似C++中的多重继承。
    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if (!methodSig) {
        return nil;
    }
    const char *retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    //忽略selector警告
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    
/**
    因为此时编译器不知道这个 selector 是什么, 也就不了解其方法签名及其返回值
    编译器不知道方法名，也就没有办法运用ARC的内存管理规则来判定返回值是不是应该释放。
    所以ARC采用了一种比较谨慎的方法，就是不添加释放操作，然而这么做有可能导致内存泄漏，因为方法在返回对象时可能已经将其保留了。
 */
}

-(void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    [self.cachedTarget removeObjectForKey:[NSString stringWithFormat:@"Target_%@",targetName]];
}

-(NSMutableDictionary *)cachedTarget
{
    if (!_cachedTarget) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end
