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
#define Title_Color    [UIColor whiteColor]
#define Title_Font     [UIFont systemFontOfSize:16.0]
#define Message_Color  [UIColor whiteColor]
#define Message_Font   [UIFont systemFontOfSize:14.0]

@implementation UIView (PromptToast)

/*
- (void)setToast:(NSNumber*)toast {
    objc_setAssociatedObject(self, @"toasting", toast, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)toasting {
    return [(NSNumber*)objc_getAssociatedObject(self, @"toasting") boolValue];
}
*/

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
    [self toast:title titleColor:Title_Color titleFont:Title_Font titleAlignment:NSTextAlignmentCenter message:message messageColor:Message_Color messageFont:Message_Font messageAlignment:NSTextAlignmentCenter positon:CSToastPositionCenter duration:duration image:nil cornerRadius:3.0 queue:YES tapDismiss:YES overWindow:overWindow];
}

// Toast[Basic]
- (void)toast:(NSString *)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)titleFont titleAlignment:(NSTextAlignment)titleAlignment message:(NSString *)message messageColor:(UIColor*)messageColor messageFont:(UIFont*)messageFont messageAlignment:(NSTextAlignment)messageAlignment positon:(id)position duration:(CGFloat)duration image:(UIImage*)image cornerRadius:(CGFloat)cornerRadius queue:(BOOL)queue tapDismiss:(BOOL)tapDismiss overWindow:(BOOL)overWindow {
    
    if ( title.length == 0 && message.length == 0) {
        return;
    }
    
    id rootView = overWindow ? [[UIApplication sharedApplication].delegate window] : self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // create a new style
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        style.titleColor = titleColor;
        style.titleFont =  titleFont;
        style.titleNumberOfLines = 0;
        style.titleAlignment = titleAlignment;
        style.messageColor = messageColor;
        style.messageFont = messageFont;
        style.messageNumberOfLines = 0;
        style.messageAlignment = messageAlignment;
        style.cornerRadius = cornerRadius;
        
        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        [CSToastManager setSharedStyle:style];
        
    });
    
    // Shared Style
    CSToastStyle *style = [CSToastManager sharedStyle];
    
    // present the toast with the new style
    [rootView makeToast:message duration:duration position:position title:title image:image style:style completion:nil];
    
    // toggle "tap to dismiss" functionality
    [CSToastManager setTapToDismissEnabled:tapDismiss];
    
    // toggle queueing behavior
    [CSToastManager setQueueEnabled:queue];
}

@end
