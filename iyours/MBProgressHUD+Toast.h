//
//  MBProgressHUD+Toast.h
//  PigPigLeague
//
//  Created by DLL on 14-7-4.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Toast)


+ (MBProgressHUD *)toastAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text lastSecond:(NSTimeInterval)lastSecond;


+ (MBProgressHUD *)toastText:(NSString *)text;

@end
