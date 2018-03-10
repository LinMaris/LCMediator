//
//  ModuleADetailController.m
//  LCMediatorDemo
//
//  Created by MarisLin on 2018/3/10.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "ModuleADetailController.h"

@interface ModuleADetailController ()

@end

@implementation ModuleADetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ModuleADetailController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"ModuleADetailController.params:%@",self.params);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
