//
//  ModalWindow.h
//  PigPigLeague
//
//  Created by DLL on 14-6-25.
//  Copyright (c) 2014年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLMaskWindow : UIWindow {
    BOOL _isShowModalView;
    UIView *_modalView;
    void (^_hideFinish)(void);
    void (^_showFinish)(void);
    void (^_onTouchBegan)(void);
}



+ (instancetype)defaultWindow;

+ (instancetype)defaultWindowAsBottom;

- (void)showWindow;

- (void)showModalView:(UIView *)view animated:(BOOL)animated finish:(void (^)(void))finish onTouchBegan:(void (^)(void))onTouchBegan;

- (void)hideModalViewAnimated:(BOOL)animated finish:(void (^)(void))finish;

@end
