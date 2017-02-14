//
//  ViewController.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "ViewController.h"
#import "FJTimer.h"

@interface ViewController ()

@property (nonatomic, strong) FJTimer *fjTimer;
@property (nonatomic, weak) IBOutlet UILabel *lb_countdonw;
@property (nonatomic, weak) IBOutlet UIButton *btn_start;
@property (nonatomic, weak) IBOutlet UIButton *btn_stop;
@property (nonatomic, weak) IBOutlet UIButton *btn_pause;
@property (nonatomic, weak) IBOutlet UIButton *btn_resume;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    // FJTimer
    FJTimer *timer = [[FJTimer alloc] initWithCoutdown:86460 interval:1 callback:^(int days, int hrs, int mins, int secs) {
        weakSelf.lb_countdonw.text = [NSString stringWithFormat:@"%d Days, %d Hours, %d minutes, %d seconds", days, hrs, mins, secs];
    }];
    
    self.fjTimer = timer;
    
    [self.btn_start addTarget:self action:@selector(tapStart) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_stop addTarget:self action:@selector(tapStop) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_pause addTarget:self action:@selector(tapPause) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_resume addTarget:self action:@selector(tapResume) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapStart {
    [self.fjTimer startTimer];
}

- (void)tapStop {
    [self.fjTimer endTimer];
}

- (void)tapPause {
    [self.fjTimer suspend];
}

- (void)tapResume {
    [self.fjTimer resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
