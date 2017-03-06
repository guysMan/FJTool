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
#import "PodHelper.h"

#define TEXT_FONT              [UIFont systemFontOfSize:14.0]
#define TEXT_COLOR             @"#FFFFFF"
#define SHEET_BG_COLOR         @"#333333"
#define IMG_CLOSE_NORMAL       [PodHelper getPodImage:@"toast_close_normal" class:[self class]]
#define IMG_CLOSE_HIGHLIGHTED  [PodHelper getPodImage:@"toast_close_active" class:[self class]]
#define STAY_DURATION          (2.0)

typedef enum {
    StateNone,
    StateAnimating,
    StateShown,
    StateHidden
} State;

@interface FJDropSheet()

@property (nonatomic, assign) CGFloat stayDuration;
@property (nonatomic, strong) UIFont  *textFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *sheetBackgroundColor;
@property (nonatomic, strong) UIImage *img_close_normal;
@property (nonatomic, strong) UIImage *img_close_highlighted;


@property (nonatomic, retain)   UIView     *sheetView;
@property (nonatomic, copy)     NSString   *message;
@property (nonatomic, retain)   UIButton   *cancelButton;
@property (nonatomic, retain)   UIWindow   *window;
@property (atomic, assign)      State state;
@property (nonatomic, copy)     void(^tapBlock)(void);
@property (nonatomic, copy)     void(^cancelBlock)(void);

@end

@implementation FJDropSheet

- (instancetype)initWithMessage:(NSString *)message {
    return [self initWithMessage:message tapBlock:nil cancelBlock:nil];
}

- (instancetype)initWithMessage:(NSString *)message tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock {
    return [self initWithMessage:message
                        textFont:TEXT_FONT
                       textColor:[UIColor colorWithHexString:TEXT_COLOR]
            sheetbackgroundColor:[UIColor colorWithHexString:SHEET_BG_COLOR]
                closeImageNormal:IMG_CLOSE_NORMAL
           closeImageHighlighted:IMG_CLOSE_HIGHLIGHTED
                    stayDuration:STAY_DURATION
                        tapBlock:tapBlock
                     cancelBlock:cancelBlock];
    
    
}

- (instancetype)initWithMessage:(NSString *)message textFont:(UIFont*)textFont textColor:(UIColor*)textColor sheetbackgroundColor:(UIColor*)sheetbackgroundColor closeImageNormal:(UIImage*)closeImageNormal closeImageHighlighted:(UIImage*)closeImageHighlighted stayDuration:(CGFloat)stayDuration tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock {
    
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
  
        self.message = message;
        self.textFont = textFont;
        self.textColor = textColor;
        self.sheetBackgroundColor = sheetbackgroundColor;
        self.img_close_normal = closeImageNormal;
        self.img_close_highlighted = closeImageHighlighted;
        self.stayDuration = stayDuration;
        self.tapBlock = tapBlock;
        self.cancelBlock = cancelBlock;
        
        [self generateSheetView];
        [self addSubview:self.sheetView];
        
    }
    return self;
}

// 生成UI
- (void)generateSheetView {
    
    if (!self.sheetView) {
        UILabel *sheetTitleLable = nil;
        if (self.message.length > 0) {
            sheetTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
            sheetTitleLable.font = self.textFont;
            sheetTitleLable.numberOfLines = 0;
            sheetTitleLable.text = self.message;
            
            sheetTitleLable.textAlignment = NSTextAlignmentCenter;
            sheetTitleLable.backgroundColor = [UIColor clearColor];
            sheetTitleLable.textColor = self.textColor;
        }
        
        UIButton *cancelButton = nil;
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(tapClose:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundImage:self.img_close_normal forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:self.img_close_highlighted forState:UIControlStateHighlighted];
        self.cancelButton = cancelButton;
        
        NSInteger width = [UIScreen mainScreen].bounds.size.width;
        UIView *sheetBgView = [[UIView alloc] initWithFrame:(CGRect){.origin = {0.f,0.f}, .size = {width, 64}}];
        sheetBgView.backgroundColor = self.sheetBackgroundColor;
        
        if (sheetTitleLable) {
            CGSize size = [self.message sizeWithAttributes:@{NSFontAttributeName : sheetTitleLable.font}];
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

// 消失UI
- (void)dismissDropSheet:(void(^)())finishBlock {
    if (self.state == StateShown) {
        self.state = StateHidden;
        __weak typeof(self) weakSelf = self;
        CGRect to = (CGRect){.origin = {0, -64}, .size = self.sheetView.bounds.size};
        self.state = StateAnimating;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.sheetView.frame = to;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.window = nil;
        }];
    }
}

// 关闭
- (void)tapClose:(id)sender {
    self.cancelBlock == nil ? : self.cancelBlock();
    [self dismissDropSheet:nil];
}

// 显示
- (void)showInView:(UIView *)view {
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 64);
    [self showRect:rect view:view animated:YES];
}

// 显示[basic]
- (void)showRect:(CGRect)rect view:(UIView *)view animated:(BOOL)animated {
    if (self.state == StateNone || self.state == StateHidden) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.windowLevel = UIWindowLevelAlert;
        [self.window addSubview:self];
        [self.window makeKeyAndVisible];
        
        CGRect from = (CGRect){.origin = {rect.origin.x,-64}, .size = self.sheetView.bounds.size};
        self.sheetView.frame = from;
        CGRect to = (CGRect){.origin = {0, 0}, .size = self.sheetView.bounds.size};
        self.state = StateAnimating;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.sheetView.frame = to;
        } completion:^(BOOL finished) {
            weakSelf.state = StateShown;
            if (weakSelf.stayDuration < 0.1) {
                weakSelf.stayDuration = self.stayDuration;
            }
            
            // 几秒后自动消失
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(weakSelf.stayDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissDropSheet:nil];
            });
        }];
    }
}

// touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    @synchronized (self) {
        // 只允许一次点击后回调 tap block
        if (self.tag == 0) {
            self.tag = -1;
            self.tapBlock == nil ? : self.tapBlock();
        }
        [self dismissDropSheet:nil];
    }
}

@end
