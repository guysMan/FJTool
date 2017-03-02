//
//  PHAsset+Select.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (Select)

@property (nonatomic,assign)BOOL selected;
@property (nonatomic,strong)UIImage *thumbImage;

@end
