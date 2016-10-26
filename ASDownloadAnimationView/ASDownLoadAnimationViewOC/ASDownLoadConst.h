//
//  ASDownLoadConst.h
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#ifndef ASDownLoadConst_h
#define ASDownLoadConst_h
#import <UIKit/UIKit.h>
#define ASArrowLineColor           [UIColor whiteColor]
#define ASArrowLineBaseCircleColor [UIColor colorWithWhite:1 alpha:0.5]
#define ASArrowLineBaseCircleWidth 3.0
#define ASArrowLineProgressColor   [UIColor whiteColor]
#define ASDownLoadTrackColor       [UIColor whiteColor]
static CGFloat const ASArrowLineBecomeStraightLengthScale  = 80.0 / 100.0;
static CGFloat const ASArrowLineWidth    = 3.0;
static CGFloat const ASArrowLineLengthScale = 65.0 / 100.0;
static CGFloat const ASArrowLineWidthScale = 38.0 / 100.0;
static CGFloat const ASArrowLineRedundantScale = 40.0 / 100.0;
static CGFloat const ASArrowLineProgressWidthScale = 60.0 / 100.0;
static CGFloat const ASArrowLineProgressHeight = 20.0;
static CGFloat const ASArrowLineProgressFontSize = 15.0;
static CGFloat const ASArrowLineHorizonAllowance = 21.0 / 100.0;
static CGFloat const ASArrowLineVerticalAllowance = 7.5 / 100;
static CGFloat const ASArrowLineTopPointAllowance = 65.0 / 2 / 100.0;
static CGFloat const ASYChanged = 32.5 / 40;
static CGFloat const ASWaveHeight = 3.0;
static CGFloat const ASSuccessfulStartPointX = 36.0 / 100.0;
static CGFloat const ASSuccessfulStartPointY = 51.0 / 100.0;
static CGFloat const ASSuccessfulMidPointX   = 48.0 / 100.0;
static CGFloat const ASSuccessfulMidPointY   = 64.0 / 100.0;
static CGFloat const ASSuccessfulEndPointX   = 68.0 / 100.0;
static CGFloat const ASSuccessfulEndPointY   = 38.0 / 100.0;

//continueBtn
static CGFloat const ASContinueBtnWidthScale = 60.0 / 100.0;
static CGFloat const ASContinueBtnHeightScale = 40.0 / 100.0;
/*
 *Animation attributes
 */
static  NSString *Attributes_Scale = @"transform.scale";

static  NSString *Attributes_ScaleX = @"transform.scale.x";

static  NSString *Attributes_ScaleY = @"transform.scale.y";

static  NSString *Attributes_RotationX = @"transform.rotation.x";

static  NSString *Attributes_RotationY = @"transform.rotation.y";

static  NSString *Attributes_RotationZ = @"transform.rotation.z";

static  NSString *Attributes_Radius = @"cornerRadius";

static  NSString *Attributes_bgColor = @"backgroundColor";

static  NSString *Attributes_Bounds = @"bounds";

static  NSString *Attributes_Position = @"position";

static  NSString *Attributes_PositionX = @"position.x";

static  NSString *Attributes_PositionY = @"position.y";

static  NSString *Attributes_Path = @"path";

static  NSString *Attributes_Contents = @"contents";

static  NSString *Attributes_Opacity = @"opacity";

static  NSString *Attributes_ContentW = @"contentsRect.size.width";
#endif /* ASDownLoadConst_h */
