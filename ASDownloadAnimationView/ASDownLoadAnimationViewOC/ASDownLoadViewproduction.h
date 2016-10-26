//
//  ASDownLoadViewproduction.h
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASDownLoadConst.h"
@interface ASDownLoadViewproduction : NSObject
@property (nonatomic, assign) CGFloat viewWidth;
/*
 *Draw the arrow line path
 */
@property (nonatomic, strong) UIBezierPath *arrowlineBezierPath;
/*
 *arrowLineAnimationPaths
 */
@property (nonatomic, strong) UIBezierPath *arrowLinemiddlePathOne;

@property (nonatomic, strong) UIBezierPath *arrowLinemiddlePathTwo;

@property (nonatomic, strong) UIBezierPath *arrowLinemiddleEndPath;
/*
 *Draw the arrow vertical line path
 */
@property (nonatomic, strong) UIBezierPath *arrowVerticalBezierPath;
/*
 *point Line Path
 */
@property (nonatomic, strong) UIBezierPath *pointLinePath;
/*
 *base circle line
 */
@property (nonatomic, strong) UIBezierPath *beaseCircleLinePath;
/*
 *Draw download track line
 */
-(UIBezierPath *)drawDownLoadTrackLineWith:(CGFloat)downloadProgress;
/*
 *vertical line become point animation
 */
-(CAKeyframeAnimation *)vertivalLineBecomePointWith:(NSArray *)values;
/*
 *bounce animation
 */
-(CASpringAnimation *)bounceAnimation;
/*
 *ArrowLine To StraightLine Animation
 */
-(CAKeyframeAnimation *)creatArrowLineToStraightLineAnimation:(NSArray *)values;
/*
 * progressLabel animation
 */
-(CASpringAnimation *)getProgressAnimationWith:(BOOL)isShow;
/*
 *wavingAnimation bezierth
 */
@property (nonatomic, strong) UIBezierPath *waveBezierPath;
- (UIBezierPath *)getWavePathWithOffset:(CGFloat)offset
                             WaveHeight:(CGFloat)height
                          WaveCurvature:(CGFloat)curvature;
/*
 *line To right Line Animation
 */
-(CAKeyframeAnimation *)lineToRightLineAnimationWithValues:(NSArray *)values;
/*
 *right line bezierPath
 */
@property (nonatomic, strong) UIBezierPath *rightLinePath;
/*
 *failed Label show animation
 */
@property (nonatomic, strong) CASpringAnimation *failedAnimation;
@end
