//
//  ASDownLoadViewproduction.m
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASDownLoadViewproduction.h"
@interface ASDownLoadViewproduction ()
{
    /*
     *arrow Line of Left Start pointX
     */
    CGFloat _arrowLineLSPointX;
    /*
     *arrow Line of Left Start pointY
     */
    CGFloat _arrowLineLSPointY;
    /*
     *arrow Line of middle pointX
     */
    CGFloat _arrowLineMSPointX;
    /*
     *arrow Line of middle pointY
     */
    CGFloat _arrowLineMSPointY;
    /*
     *arrow Line of right pointX
     */
    CGFloat _arrowLineRSPointX;
    /*
     *arrow Line of right pointY
     */
    CGFloat _arrowLineRSPointY;
    /*
     *arrow vertical Line of start pointY
     */
    CGFloat _arrowVLineSPointY;
    /*
     *arrow Become Straight length
     */
    CGFloat _straightLength;
    /*
     *Horizon Allowance
     */
    CGFloat _hAllowance;
    /*
     *Vertical Allowance
     */
    CGFloat _vAllowance;
    /*
     *Top Point Allowance
     */
    CGFloat _topPointAllowance;
    
}
@end
@implementation ASDownLoadViewproduction
-(instancetype)init
{
    if (self = [super init]) {
        [self setDefaultsAttribute];
    }
    return self;
}

//MARK: ----- setDefaultAttribute
-(void)setDefaultsAttribute
{
    
}

-(void)setViewWidth:(CGFloat)viewWidth
{
    _viewWidth = viewWidth;
    //Vertical line length
    CGFloat vLineLength = self.viewWidth * ASArrowLineLengthScale;
    //line Width
    CGFloat lineWidth = self.viewWidth * ASArrowLineWidthScale;
    //Redundant length
    CGFloat redundantLength = self.viewWidth * ASArrowLineRedundantScale;
    _arrowLineLSPointX = (self.viewWidth - lineWidth) / 2;
    _arrowLineLSPointY = (self.viewWidth - vLineLength) / 2 + redundantLength;
    _arrowLineMSPointX = self.viewWidth / 2;
    _arrowLineMSPointY = (self.viewWidth - vLineLength) / 2 + vLineLength;
    _arrowLineRSPointX = _arrowLineLSPointX + lineWidth;
    _arrowLineRSPointY = _arrowLineLSPointY;
    _arrowVLineSPointY = (self.viewWidth - vLineLength) / 2;
    _straightLength = self.viewWidth * ASArrowLineBecomeStraightLengthScale;
    _hAllowance = ASArrowLineHorizonAllowance * self.viewWidth;
    _vAllowance = ASArrowLineVerticalAllowance * self.viewWidth;
    _topPointAllowance = ASArrowLineTopPointAllowance * self.viewWidth;
}

//MARK: ------ Draw the arrow path
-(UIBezierPath *)arrowlineBezierPath
{
    _arrowlineBezierPath = [UIBezierPath bezierPath];
    [_arrowlineBezierPath moveToPoint:CGPointMake(_arrowLineLSPointX, _arrowLineLSPointY)];
    [_arrowlineBezierPath addLineToPoint:CGPointMake(_arrowLineMSPointX, _arrowLineMSPointY)];
    [_arrowlineBezierPath addLineToPoint:CGPointMake(_arrowLineRSPointX, _arrowLineRSPointY)];
    return _arrowlineBezierPath;
}

//MARK: ------ Draw arrowLinemiddlePathOne
-(UIBezierPath *)arrowLinemiddlePathOne
{
    CGFloat lineWidth = self.viewWidth * ASArrowLineWidthScale;
    _arrowLinemiddlePathOne = [UIBezierPath bezierPath];
    [_arrowlineBezierPath moveToPoint:CGPointMake(_arrowLineLSPointX - _hAllowance * 1/4, _arrowLineLSPointY - ASYChanged * _hAllowance * 1/4)];
    [_arrowlineBezierPath addLineToPoint:CGPointMake(self.viewWidth / 2, _arrowLineMSPointY - lineWidth * 1 / 4)];
    [_arrowlineBezierPath addLineToPoint:CGPointMake(_arrowLineRSPointX + _hAllowance * 1 / 4, _arrowLineRSPointY - _hAllowance * 1 / 4 * ASYChanged)];
    return _arrowLinemiddlePathOne;
}
//MARK: ------ Draw arrowLinemiddlePathTwo
-(UIBezierPath *)arrowLinemiddlePathTwo
{
    CGFloat lineWidth = self.viewWidth * ASArrowLineWidthScale;
    _arrowLinemiddlePathTwo = [UIBezierPath bezierPath];
    [_arrowLinemiddlePathTwo moveToPoint:CGPointMake(_arrowLineLSPointX - _hAllowance * 2/4, _arrowLineLSPointY - ASYChanged * _hAllowance * 2/4)];
    [_arrowLinemiddlePathTwo addLineToPoint:CGPointMake(self.viewWidth / 2, _arrowLineMSPointY - lineWidth * 2 / 4)];
    [_arrowLinemiddlePathTwo addLineToPoint:CGPointMake(_arrowLineRSPointX + _hAllowance * 2 / 4, _arrowLineRSPointY - _hAllowance * 2 / 4 * ASYChanged)];
    return _arrowLinemiddlePathTwo;
}
//MARK: ------ Draw arrowLinemiddleEndPath
-(UIBezierPath *)arrowLinemiddleEndPath
{
    _arrowLinemiddleEndPath = [UIBezierPath bezierPath];
    [_arrowLinemiddleEndPath moveToPoint:CGPointMake((self.viewWidth - _straightLength) / 2, self.viewWidth / 2)];
    [_arrowLinemiddleEndPath addLineToPoint:CGPointMake(self.viewWidth / 2, self.viewWidth / 2)];
    [_arrowLinemiddleEndPath addLineToPoint:CGPointMake((self.viewWidth - _straightLength) / 2 + _straightLength, self.viewWidth / 2)];
    return _arrowLinemiddleEndPath;
}
//MARK: ------- Draw the arrow Vertical path
-(UIBezierPath *)arrowVerticalBezierPath
{
    _arrowVerticalBezierPath = [UIBezierPath bezierPath];
    [_arrowVerticalBezierPath moveToPoint:CGPointMake(_arrowLineMSPointX, _arrowVLineSPointY)];
    [_arrowVerticalBezierPath addLineToPoint:CGPointMake(_arrowLineMSPointX, _arrowLineMSPointY)];
    return _arrowVerticalBezierPath;
}

//MARK: ---- pointLinePath
-(UIBezierPath *)pointLinePath
{
    CGFloat vLineLength = self.viewWidth * ASArrowLineLengthScale;
    _pointLinePath = [UIBezierPath bezierPath];
    [_pointLinePath moveToPoint:CGPointMake( self.viewWidth / 2, (self.viewWidth - vLineLength) / 2 + vLineLength / 2)];
    [_pointLinePath addLineToPoint:CGPointMake( self.viewWidth / 2, (self.viewWidth - vLineLength) / 2 + vLineLength / 2)];
    return _pointLinePath;
}

//MARK: ----- Bease Circle Line Path
-(UIBezierPath *)beaseCircleLinePath
{
    _beaseCircleLinePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1, 1, self.viewWidth - 1, self.viewWidth - 1)];
    return _beaseCircleLinePath;
}
//MARK: ----- Draw download track line
-(UIBezierPath *)drawDownLoadTrackLineWith:(CGFloat)downloadProgress
{
    UIBezierPath *downloadTrack = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.viewWidth / 2, self.viewWidth / 2) radius:self.viewWidth / 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * downloadProgress - M_PI_2 clockwise:YES];
    return downloadTrack;
}

//MARK: ----- vertical line become point animation and then in the play
-(CAKeyframeAnimation *)vertivalLineBecomePointWith:(NSArray *)values
{
    CAKeyframeAnimation *lineToPointAnimation = [CAKeyframeAnimation animationWithKeyPath:Attributes_Path];
    lineToPointAnimation.values = values;
    //The first frame of the time is set to 0 (initial state)
    lineToPointAnimation.keyTimes = @[@0,@.15];
    lineToPointAnimation.beginTime = 0;
    return lineToPointAnimation;
}

//MARK: -------- bounceAnimation IOS9.0
-(CASpringAnimation *)bounceAnimation
{
    CASpringAnimation *bounceAnimation = [CASpringAnimation animationWithKeyPath:Attributes_PositionY];
    bounceAnimation.toValue = @1;
    bounceAnimation.mass = 1;
    bounceAnimation.damping = 10;
    //after line to point animation finished
    bounceAnimation.beginTime = 0.5;
    bounceAnimation.initialVelocity = 0;
    bounceAnimation.removedOnCompletion = NO;
    bounceAnimation.fillMode = kCAFillModeForwards;
    return bounceAnimation;
}

//MARL: ----- ArrowLine To StraightLine Animation
-(CAKeyframeAnimation *)creatArrowLineToStraightLineAnimation:(NSArray *)values
{
    CAKeyframeAnimation *lineToPointAnimation = [CAKeyframeAnimation animationWithKeyPath:Attributes_Path];
    lineToPointAnimation.values = values;
    lineToPointAnimation.keyTimes = @[@.15,@.3];
    lineToPointAnimation.repeatCount = 1;
    lineToPointAnimation.duration = 2;
    lineToPointAnimation.removedOnCompletion = NO;
    lineToPointAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return lineToPointAnimation;
}

//MARK: ----- progressLabel animation
-(CASpringAnimation *)getProgressAnimationWith:(BOOL)isShow
{
    CASpringAnimation *progressAnimation = [CASpringAnimation animationWithKeyPath:Attributes_Scale];
    progressAnimation.fromValue = isShow==YES?@0:@1;
    progressAnimation.toValue     = isShow==YES?@1:@0;
    progressAnimation.mass = 1;
    progressAnimation.stiffness = 50;
    progressAnimation.damping = 10;
    progressAnimation.initialVelocity = 0;
    progressAnimation.duration = 1.5;
    return progressAnimation;
}

//MARK: ------- wave animation
- (UIBezierPath *)getWavePathWithOffset:(CGFloat)offset
                             WaveHeight:(CGFloat)height
                          WaveCurvature:(CGFloat)curvature{
    self.waveBezierPath = [UIBezierPath bezierPath];
    [self.waveBezierPath moveToPoint:CGPointMake((self.viewWidth - self.viewWidth * ASArrowLineBecomeStraightLengthScale) / 2, self.viewWidth / 2)];
    CGFloat y = 0;
    for (CGFloat x = (self.viewWidth - self.viewWidth * ASArrowLineBecomeStraightLengthScale) / 2; x <= (self.viewWidth - self.viewWidth * ASArrowLineBecomeStraightLengthScale) / 2 + self.viewWidth * ASArrowLineBecomeStraightLengthScale ; x++) {
        y = height * sinf(curvature * x + offset )+self.viewWidth/2;
        [self.waveBezierPath addLineToPoint:CGPointMake(x, y)];
    }
    return self.waveBezierPath;
}


//MARK: ------  line To right Line Animation
-(CAKeyframeAnimation *)lineToRightLineAnimationWithValues:(NSArray *)values
{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:Attributes_Path];
    keyAnimation.values = values;
    keyAnimation.duration = 0.3;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.beginTime = 0;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return keyAnimation;
}

//MARK: ------ rightLine Path
-(UIBezierPath *)rightLinePath
{
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath moveToPoint:CGPointMake(self.viewWidth * ASSuccessfulStartPointX, self.viewWidth * ASSuccessfulStartPointY)];
    [rightPath addLineToPoint:CGPointMake(self.viewWidth * ASSuccessfulMidPointX, self.viewWidth * ASSuccessfulMidPointY)];
    [rightPath addLineToPoint:CGPointMake(self.viewWidth * ASSuccessfulEndPointX, self.viewWidth * ASSuccessfulEndPointY)];
    return rightPath;
}

-(CASpringAnimation *)failedAnimation
{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:Attributes_Scale];
    animation.fromValue = @0.3;
    animation.toValue   = @1;
    animation.mass = 1;
    animation.stiffness = 50;
    animation.damping = 10;
    animation.initialVelocity = 0;
    animation.duration = 1.5;
    return animation;
}

@end








