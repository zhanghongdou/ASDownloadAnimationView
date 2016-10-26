//
//  ASDownLoadAnimationView.h
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDownLoadConst.h"
@protocol ASDownLoadAnimationViewDelegate <NSObject>
- (void)startAnimation;
- (void)pauseDownloadAnimation;
- (void)resumeDownloadAnimation;
@end
@interface ASDownLoadAnimationView : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, weak) id<ASDownLoadAnimationViewDelegate> delegate;
@property (nonatomic, assign) BOOL downloadSuccessful;
-(void)cancelDownload;
@end
