//
//  ViewController.m
//  LCMediatorDemo
//
//  Created by MarisLin on 2018/3/9.
//  Copyright © 2018年 MarisLin. All rights reserved.
//

#import "ViewController.h"
#import "LCMediator+ModuleAAction.h"
#import "LCMediator.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"push detail view controller", @"show alert"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.row == 0) {  // push vc
        
        UIViewController *vc = [[LCMediator sharedLCMediator] lcm_ViewControllerForDetailWithParams:@{@"name" : @"jack"}];
        [self.navigationController pushViewController:vc animated:true];
    }
    
    if (indexPath.row == 1) {
        [[LCMediator sharedLCMediator] lcm_showAlertWithMessage:@"ll" cancelAction:nil confirmAction:^(NSDictionary *info) {
            // 做你想做的事
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
