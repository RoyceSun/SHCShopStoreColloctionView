//
//  TestViewController.m
//  TestCollectionView
//
//  Created by 孙海琛 on 2019/1/21.
//  Copyright © 2019年 孙海琛. All rights reserved.
//
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#import "TestViewController.h"
#import "MallView.h"

@interface TestViewController ()
@property (strong, nonatomic)MallView *mallView;
@end

@implementation TestViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self createUI];
}
- (void)createUI{
    [self.view addSubview:self.mallView];
}

- (MallView *)mallView
{
    if (!_mallView) {
        _mallView = [[MallView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _mallView;
}

@end
