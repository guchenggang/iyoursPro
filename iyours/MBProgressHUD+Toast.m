//
//  MBProgressHUD+Toast.m
//  PigPigLeague
//
//  Created by DLL on 14-7-4.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import "MBProgressHUD+Toast.h"
#import "DLLMaskWindow.h"

@implementation MBProgressHUD (Toast)

+ (MBProgressHUD *)toastAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text lastSecond:(NSTimeInterval)lastSecond;
{

    
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setYOffset:[UIScreen mainScreen].bounds.size.height/2 - 100];
    hud.userInteractionEnabled = NO;
    [hud setLabelText:text];
    [hud hide:YES afterDelay:lastSecond];
    return hud;
}

+ (MBProgressHUD *)toastText:(NSString *)text
{
    MBProgressHUD *result = [self toastAddedTo:[DLLMaskWindow defaultWindow] animated:YES text:text lastSecond:2];
    [[DLLMaskWindow defaultWindow] showWindow];
    return result;
}
@end
