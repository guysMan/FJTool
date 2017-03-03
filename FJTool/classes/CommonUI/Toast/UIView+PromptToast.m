//
//  UIView+PromptToast.m
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "UIView+PromptToast.h"
#import <objc/runtime.h>
#import <Toast/UIView+Toast.h>

#define Toast_Duration (2.0)
#define Position [NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.height / 4.0]
#define Title_Color [UIColor whiteColor]
#define Title_Font  [UIFont systemFontOfSize:16.0]
#define Message_Color [UIColor whiteColor]
#define Message_Font  [UIFont systemFontOfSize:14.0]

@implementation UIView (PromptToast)

- (void)setToast:(NSNumber*)toast {
    objc_setAssociatedObject(self, @"toasting", toast, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)toasting {
    return [(NSNumber*)objc_getAssociatedObject(self, @"toasting") boolValue];
}

// Toast[Title, Message]
- (void)toast:(NSString*)title message:(NSString*)message {
    [self toast:title message:message duration:Toast_Duration overWindow:NO];
}

// Toast[Title, Message, Duration]
- (void)toast:(NSString*)title message:(NSString*)message duration:(CGFloat)duration {
    [self toast:title message:message duration:duration overWindow:NO];
}

// Toast[Title, Message, OverWindow]
- (void)toast:(NSString*)title message:(NSString*)message overWindow:(BOOL)overWindow {
    [self toast:title message:message duration:Toast_Duration overWindow:overWindow];
}

// Toast[Title, Message, Duration, OverWindow]
- (void)toast:(NSString*)title message:(NSString*)message duration:(CGFloat)duration overWindow:(BOOL)overWindow {
    [self toast:title titleColor:Title_Color titleFont:Title_Font message:message messageColor:Message_Color messageFont:Message_Font positon:Position duration:duration overWindow:overWindow];
}

// Toast[Basic]
- (void)toast:(NSString *)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)titleFont message:(NSString *)message messageColor:(UIColor*)messageColor messageFont:(UIFont*)messageFont positon:(id)position duration:(CGFloat)duration overWindow:(BOOL)overWindow {
    
    if ( title.length == 0 && message.length == 0) {
        return;
    }
    
    if ([self toasting]) {
        return;
    }
    [self setToast:@YES];
    __weak typeof(self) wealSelf = self;
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.titleAlignment = NSTextAlignmentRight;
    style.titleColor = titleColor;
    style.titleFont = titleFont;
    style.titleNumberOfLines = 0;
    style.titleAlignment = NSTextAlignmentCenter;
    style.messageColor = messageColor;
    style.messageFont = messageFont;
    style.messageNumberOfLines = 0;
    style.messageAlignment = NSTextAlignmentCenter;
    style.cornerRadius = 3.0;
    
    id currentPostion;
    id rootView = overWindow ? [[UIApplication sharedApplication].delegate window] : self;
    if (position) {
        if ([position isKindOfClass:[NSNumber class]]) {
            
            UIView *toast = [self toastViewForMessage:message title:title image:nil style:style];
            [rootView showToast:toast duration:duration position:[NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [position floatValue])] completion:^(BOOL didTap) {
                [wealSelf setToast:@NO];
            }];
            return;
        } else {
            currentPostion = position;
        }
    } else {
        currentPostion = CSToastPositionTop;
        [rootView makeToast:message duration:duration position:currentPostion title:title image:nil style:style completion:^(BOOL didTap) {
            [wealSelf setToast:@NO];
        }];
    }
}

@end
