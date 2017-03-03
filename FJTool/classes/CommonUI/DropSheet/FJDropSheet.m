//
//  FJDropSheet.m
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJDropSheet.h"
#import "UIColor+Hex.h"
#import "UIView+Layer.h"

#define TEXT_FONT  [UIFont systemFontOfSize:14.0]
#define TEXT_COLOR @"#FFFFFF"
#define BG_COLOR   @"#333333"

#define STAY_DURATION_NON_WEAK  (2.0)
#define STAY_DURATION_WEAK      (1.0)
#define IMG_NORMAL           [UIImage imageNamed:@"toast_close_normal"]
#define IMG_HIGHLIGHTED      [UIImage imageNamed:@"toast_close_active"]

typedef enum {
    DropTipSheetStateNone,
    DropTipSheetStateAnimating,
    DropTipSheetStateShown,
    DropTipSheetStateHiden
} DropTipSheetState;

@interface FJDropSheet()

@property (nonatomic, retain)   UIView     *sheetView;
@property (nonatomic, retain)   UILabel    *lbSheetTitle;
@property (nonatomic, copy)     NSString   *actionTitle;
@property (nonatomic, retain)   UIButton   *cancelButton;
@property (nonatomic, retain)   UIWindow   *window;
@property (nonatomic, retain)   NSTimer    *tipTimer;
@property (atomic, assign)      DropTipSheetState state;
@property (nonatomic, assign)   BOOL hasExecuteTapBlock;

@end

@implementation FJDropSheet

- (void)generateSheetView {
    
    if (!self.sheetView) {
        UILabel *sheetTitleLable = nil;
        if (self.actionTitle.length > 0) {
            sheetTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
            sheetTitleLable.font = TEXT_FONT;
            sheetTitleLable.numberOfLines = 0;
            sheetTitleLable.text = self.actionTitle;
            
            sheetTitleLable.textAlignment = NSTextAlignmentCenter;
            sheetTitleLable.backgroundColor = [UIColor clearColor];
            sheetTitleLable.textColor = [UIColor colorWithHexString:TEXT_COLOR];
        }
        
        UIButton *cancelButton = nil;
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitle:@"" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithWhite:138.f/255 alpha:1.f] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        
        [cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"toast_close_normal"]
                                forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"toast_close_active"]
                                forState:UIControlStateHighlighted];
        self.cancelButton = cancelButton;
        
        NSInteger width = [UIScreen mainScreen].bounds.size.width;
        UIView *sheetBgView = [[UIView alloc] initWithFrame:(CGRect){.origin = {0.f,0.f}, .size = {width, 64}}];
        sheetBgView.backgroundColor = [UIColor colorWithHexString:BG_COLOR];
        
        if (sheetTitleLable) {
            CGSize size = [self.actionTitle sizeWithAttributes:@{NSFontAttributeName : sheetTitleLable.font}];
            sheetTitleLable.frame = CGRectMake((width-size.width)/2, 30, size.width, 34.0f);
            [sheetTitleLable sizeToFit];
            sheetTitleLable.textAlignment = NSTextAlignmentCenter;
            [sheetBgView addSubview:sheetTitleLable];
        }
        
        if (cancelButton) {
            cancelButton.frame = (CGRect){.origin = {width-30, 30}, .size = CGSizeMake(20, 20)};
            [sheetBgView addSubview:cancelButton];
        }
        sheetBgView.frame = (CGRect){.origin = {0.f,0.f}, .size = {width, 64}};
        
        self.sheetView = sheetBgView;
    }
}


- (id)initWithTitle:(NSString *)title delegate:(id<FJDropSheetDelegate>)delegate{
    
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.actionTitle = title;
        self.delegate = delegate;
        self.hasExecuteTapBlock = NO;
        [self generateSheetView];
        [self addSubview:self.sheetView];
    }
    return self;
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
    if (self.state == DropTipSheetStateNone || self.state == DropTipSheetStateHiden) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.windowLevel = UIWindowLevelAlert;
        [self.window addSubview:self];
        [self.window makeKeyAndVisible];
        
        CGRect from = (CGRect){.origin = {rect.origin.x,-64}, .size = self.sheetView.bounds.size};
        self.sheetView.frame = from;
        CGRect to = (CGRect){.origin = {0, 0}, .size = self.sheetView.bounds.size};
        self.state = DropTipSheetStateAnimating;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.sheetView.frame = to;
        } completion:^(BOOL finished) {
            weakSelf.state = DropTipSheetStateShown;
            if (weakSelf.stay_duration < 0.1) {
                weakSelf.stay_duration = STAY_DURATION_NON_WEAK;
            }
            self.tipTimer = [NSTimer scheduledTimerWithTimeInterval:weakSelf.stay_duration
                                                             target:self
                                                           selector:@selector(onTick:)
                                                           userInfo:nil
                                                            repeats:NO];
        }];
    }
}

-(void)onTick:(NSTimer *)timer {
    //do smth
    [self dismissDropTipSheet:^{
        
    }];
}

- (void)dismissDropTipSheet:(void(^)())finishBlock {
    if (self.state == DropTipSheetStateShown) {
        self.tipTimer = nil;
        self.state = DropTipSheetStateHiden;
        __weak typeof(self) weakSelf = self;
        CGRect to = (CGRect){.origin = {0, -64}, .size = self.sheetView.bounds.size};
        self.state = DropTipSheetStateAnimating;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.sheetView.frame = to;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.window = nil;
        }];
    }
}


- (void)buttonAction:(id)sender {
    
    if ([sender isEqual:self.cancelButton]) {
        [self dismissDropTipSheet:^{
            
        }];
    }else{
        [self dismissDropTipSheet:^{
            
        }];
    }
}


- (void)showInView:(UIView *)view {
    CGRect rt;
    rt = CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width , 64);
    [self showFromRect:rt inView:view animated:YES];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [self dismissDropTipSheet:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    @synchronized (self) {
        if (self.hasExecuteTapBlock == NO) {
            self.hasExecuteTapBlock = YES;
            if (self.tapBlock) {
                self.tapBlock();
            }
        }
        [self dismissDropTipSheet:nil];
    }
}

@end
