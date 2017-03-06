//
//  TestViewController.m
//  FJTool
//
//  Created by Jeff on 2017/3/6.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "TestViewController.h"
#import "FJProgressView.h"

@interface TestViewController ()

@property (nonatomic, weak) IBOutlet FJProgressView *fjprogressView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.4 blue:0.7 alpha:0.1]];
    
    [self.view addSubview:btn];
    
    
    [self.fjprogressView setProgress:0.88 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
