//
//  FJPhotoLibraryViewController.m
//  FJTool
//
//  Created by Jeff on 2017/3/1.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJPhotoLibraryViewController.h"
#import "Macro.h"
#import "MacroColor.h"
#import "NSObject+Block.h"
#import "SelectAlbumButton.h"
#import "PodHelper.h"

#define NavigationBar_BackgroundColor
#define Back_Image

@implementation FJPhotoLibraryUIConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewBackgroundColor = [UIColor blackColor];
        self.navigationBarHidden = NO;
        self.navigationBarTranslucent = NO;
        self.navigationBarTintColor = [UIColor whiteColor];
        self.statusBarHidden = YES;
        self.backImage = [UIImage imageNamed:@"nav_icon_back_grey"];
        if (self.backImage == nil) {
            // fix cocoapod
            self.backImage = [PodHelper getPodImage:@"nav_icon_back_grey" class:[self class]];
        }
        self.backSize = CGSizeMake(24.0, 24.0);
        self.nextText = @"下一步";
        self.nextFont = [UIFont systemFontOfSize:14.0];
        self.nextColor = [UIColor whiteColor];
        self.nextBackgroundColorNormal = COLOR_TEXT_ORANGE;
        self.nextBackgroundColorDisabled = COLOR_GRAY_CCCCCC;
        self.nextSize = CGSizeMake(56.0, 24.0);
        self.titleViewFont = [UIFont systemFontOfSize:18.0];
        self.titleViewColor = COLOR_GRAY_333333;
    }
    return self;
}

@end


@interface FJPhotoLibraryViewController ()
@property (nonatomic, strong)  FJPhotoLibraryUIConfig *uiconfig;

@end

@implementation FJPhotoLibraryViewController


- (void)setUiconfig:(FJPhotoLibraryUIConfig *)uiconfig {
    _uiconfig = uiconfig;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = _uiconfig.viewBackgroundColor;
    [self.navigationController setNavigationBarHidden:_uiconfig.navigationBarHidden];
    [self.navigationController.navigationBar setTranslucent:_uiconfig.navigationBarTranslucent];
    [self.navigationController.navigationBar setTintColor:_uiconfig.navigationBarTintColor];
    
    // Left Button
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _uiconfig.backSize.width, _uiconfig.backSize.height)];
    [backBtn setImage:_uiconfig.backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    // Navigation Title View
    SelectAlbumButton *selectAlbumButton = MF_LOAD_NIB(@"SelectAlbumButton");
    [selectAlbumButton updateUIConfig:_uiconfig.titleViewFont textColor:_uiconfig.titleViewColor];
    self.navigationItem.titleView = selectAlbumButton;
    
    // Right Button
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _uiconfig.nextSize.width, _uiconfig.nextSize.height)];
    [nextBtn setTitle:_uiconfig.nextText forState:UIControlStateNormal];
    [nextBtn setTitleColor:_uiconfig.nextColor forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:_uiconfig.nextBackgroundColorDisabled];
    [nextBtn.titleLabel setFont:_uiconfig.nextFont];
    
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
    __weak UIButton *weak_nextBtn = nextBtn;
    [nextBtn addNotification:NOTIFY_SELECTED_PICTURE notifyBlock:^{
        [weak_nextBtn setBackgroundColor:_uiconfig.nextBackgroundColorNormal];
    }];
    
    [nextBtn addNotification:NOTIFY_UNSELECTED_PICTURE notifyBlock:^{
        [weak_nextBtn setBackgroundColor:_uiconfig.nextBackgroundColorDisabled];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return _uiconfig.statusBarHidden;
}

- (void)back {
    if ([self.navigationController.viewControllers count] == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)next {
    
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
