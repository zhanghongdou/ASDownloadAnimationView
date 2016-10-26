//
//  ASDownLoadAnimationView.m
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASDownLoadAnimationView.h"
#import "ASDownLoadViewproduction.h"
@interface ASDownLoadAnimationView ()<CAAnimationDelegate>
{
    /*
     *Whether identifier is already start the download
     */
    BOOL _isDownLoading;
    /*
     *arrow line of Vertical Line
     */
    CAShapeLayer *_arrowVerticalLine;
    /*
     *base circle line
     */
    CAShapeLayer *_baseCircleLine;
    /*
     *have downloaded track
     */
    CAShapeLayer *_downloadtrackLine;
    /*
     *Path to the factory
     */
    ASDownLoadViewproduction *_pathProduction;
    /*
     *show progress label
     */
    UILabel *_progressLabel;
    /*
     *Wavy lines timer
     */
    NSTimer *_wavyTimer;
    /*
     *Whether to suspend about The current state
     */
    BOOL _isSuspend;
}
/*
 * Arrow lines
 */
@property (nonatomic, strong) CAShapeLayer *arrowLine;
/*
 *Continue to download button
 */
@property (nonatomic, strong) UIButton *continueBtn;
/*
 *Download failed prompt
 */
@property (nonatomic, strong) UIButton *failedBtn;
@property (nonatomic, assign) CGFloat waveSpeed;
@property (nonatomic, assign) CGFloat waveCurvature;
@property (nonatomic, assign) CGFloat offset;
@end


@implementation ASDownLoadAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.waveSpeed = 1.0;
        self.waveCurvature = .25;
        self.userInteractionEnabled = YES;
        [self setDefaultAttributeValues];
        [self addTapGesture];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.waveSpeed = 1.0;
        self.waveCurvature = .25;
        self.userInteractionEnabled = YES;
        [self setDefaultAttributeValues];
        [self addTapGesture];
    }
    return self;
}

-(UIButton *)continueBtn
{
    if (!_continueBtn) {
        _continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _continueBtn.backgroundColor = [UIColor clearColor];
        [_continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_continueBtn setTitle:@"continue" forState:UIControlStateNormal];
        _continueBtn.frame = CGRectMake((self.bounds.size.width - ASContinueBtnWidthScale * self.bounds.size.width) / 2, CGRectGetHeight(self.bounds) / 2 - ASContinueBtnHeightScale * self.bounds.size.width / 2, ASContinueBtnWidthScale * self.bounds.size.width, ASContinueBtnHeightScale * self.bounds.size.width);
        _continueBtn.hidden = YES;
        _continueBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _continueBtn.layer.cornerRadius = 4.0;
        _continueBtn.layer.borderWidth = 1;
        _continueBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_continueBtn addTarget:self action:@selector(continueToDownload:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_continueBtn];
    }
    return _continueBtn;
}

//MARK: ------ continue to download
-(void)continueToDownload:(UIButton *)sender
{
    if (self.delegate) {
        [self.delegate resumeDownloadAnimation];
    }
    sender.hidden = YES;
    _progressLabel.hidden = NO;
    self.arrowLine.hidden = NO;
    _isSuspend = NO;
}

-(UIButton *)failedBtn
{
    if (!_failedBtn) {
        _failedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _failedBtn.backgroundColor = [UIColor clearColor];
        [_failedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_failedBtn setTitle:@"failed" forState:UIControlStateNormal];
        _failedBtn.frame = CGRectMake((self.bounds.size.width - ASContinueBtnWidthScale * self.bounds.size.width) / 2, CGRectGetHeight(self.bounds) / 2 - ASContinueBtnHeightScale * self.bounds.size.width / 2, ASContinueBtnWidthScale * self.bounds.size.width, ASContinueBtnHeightScale * self.bounds.size.width);
        _failedBtn.hidden = YES;
        _failedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _failedBtn.layer.cornerRadius = 4.0;
        _failedBtn.layer.borderWidth = 1;
        _failedBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_failedBtn addTarget:self action:@selector(tryToDownloadAgain:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_failedBtn];
    }
    return _failedBtn;
}

-(void)tryToDownloadAgain:(UIButton *)sender
{
    sender.hidden = YES;
    self.arrowLine.hidden = NO;
    _arrowVerticalLine.hidden = NO;
    self.userInteractionEnabled = YES;
    [self startDownloadAnimation];
}

//MARK: ----- Set the default attribute values
-(void)setDefaultAttributeValues
{
    self.backgroundColor = [UIColor whiteColor];
    _pathProduction = [[ASDownLoadViewproduction alloc]init];
    _pathProduction.viewWidth = CGRectGetWidth(self.frame);
    [self creatArrowLine];
    [self creatArrowVertivalLine];
    [self creatBaseCircleLine];
    [self creatProgressLabel];
    [self creatProgressTrackPath];
}

-(CAShapeLayer *)arrowLine
{
    if (!_arrowLine) {
        _arrowLine = [CAShapeLayer layer];
        _arrowLine.frame = self.bounds;
        _arrowLine.strokeColor = ASArrowLineColor.CGColor;
        _arrowLine.lineCap = kCALineCapRound;
        _arrowLine.lineWidth = ASArrowLineWidth;
        _arrowLine.lineJoin = kCALineJoinRound;
        _arrowLine.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_arrowLine];
    }
    return _arrowLine;
}

-(void)creatArrowLine
{
    self.arrowLine.path = _pathProduction.arrowlineBezierPath.CGPath;
}

-(void)creatArrowVertivalLine
{
    _arrowVerticalLine = [CAShapeLayer layer];
    _arrowVerticalLine.frame = self.bounds;
    _arrowVerticalLine.strokeColor = ASArrowLineColor.CGColor;
    _arrowVerticalLine.lineCap = kCALineCapRound;
    _arrowVerticalLine.lineWidth = ASArrowLineWidth;
    _arrowVerticalLine.fillColor = [UIColor clearColor].CGColor;
    _arrowVerticalLine.lineJoin = kCALineJoinRound;
    _arrowVerticalLine.path = _pathProduction.arrowVerticalBezierPath.CGPath;
    [self.layer addSublayer:_arrowVerticalLine];
}

-(void)creatBaseCircleLine
{
    _baseCircleLine = [CAShapeLayer layer];
    _baseCircleLine.frame = self.bounds;
    _baseCircleLine.strokeColor = ASArrowLineBaseCircleColor.CGColor;
    _baseCircleLine.lineWidth = ASArrowLineBaseCircleWidth;
    _baseCircleLine.fillColor = [UIColor clearColor].CGColor;
    _baseCircleLine.lineCap = kCALineCapRound;
    _baseCircleLine.lineJoin = kCALineJoinRound;
    _baseCircleLine.path = _pathProduction.beaseCircleLinePath.CGPath;
    [self.layer addSublayer:_baseCircleLine];
}

-(void)creatProgressLabel
{
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - ASArrowLineProgressWidthScale * CGRectGetWidth(self.frame)) / 2, CGRectGetWidth(self.frame) / 2 + 5, ASArrowLineProgressWidthScale * CGRectGetWidth(self.frame), ASArrowLineProgressHeight)];
    _progressLabel.backgroundColor = [UIColor clearColor];
    _progressLabel.textColor = ASArrowLineProgressColor;
    _progressLabel.font = [UIFont systemFontOfSize:ASArrowLineProgressFontSize];
    _progressLabel.adjustsFontSizeToFitWidth = YES;
    _progressLabel.text = @"00%";
    _progressLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)creatProgressTrackPath
{
    _downloadtrackLine = [CAShapeLayer layer];
    _downloadtrackLine.strokeColor = ASDownLoadTrackColor.CGColor;
    _downloadtrackLine.lineJoin = kCALineJoinRound;
    _downloadtrackLine.lineCap = kCALineCapRound;
    _downloadtrackLine.lineWidth = ASArrowLineWidth;
    _downloadtrackLine.fillColor = [UIColor clearColor].CGColor;
    _downloadtrackLine.frame = self.bounds;
    [self.layer addSublayer:_downloadtrackLine];
}

//MARK: ------ Add a click gesture
-(void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelectorToStartDownloadOrPause:)];
    [self addGestureRecognizer:tap];
}

//MARK: ------ tapSelector to start download Or pause
-(void)tapSelectorToStartDownloadOrPause:(UITapGestureRecognizer *)sender
{
    if (!_isDownLoading) {
        //start to downloadAnimation
        self.userInteractionEnabled = NO;
        [self startDownloadAnimation];
        _isDownLoading = YES;
    }else{
        if (_isSuspend) {
            self.continueBtn.hidden = YES;
            self.arrowLine.hidden = NO;
            _isSuspend = NO;
            _progressLabel.hidden = NO;
            if (self.delegate) {
                [self.delegate resumeDownloadAnimation];
            }
        }else{
            self.continueBtn.hidden = NO;
            _isSuspend = YES;
            self.arrowLine.hidden = YES;
            _progressLabel.hidden = YES;
            //pause
            [self pauseDownloadAnimation];
        }
    }
}

//MARK: ----- start downloadAnimation
-(void)startDownloadAnimation
{
    [self startLineToPointAnimationAndBounceAniamtion];
    [self startArrowLineToStraightLine];
}

//MARK: ----- vertical line become point animation and then bounce animation
-(void)startLineToPointAnimationAndBounceAniamtion
{
    CAKeyframeAnimation *lineToPointAnimation = [_pathProduction vertivalLineBecomePointWith:@[(__bridge id)_pathProduction.arrowVerticalBezierPath.CGPath, (__bridge id)_pathProduction.pointLinePath.CGPath]];
    CASpringAnimation *bounceAnimation = [_pathProduction bounceAnimation];
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    groupAnimation.animations = @[lineToPointAnimation, bounceAnimation];
    groupAnimation.repeatCount = 1;
    groupAnimation.duration = 1.5;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_arrowVerticalLine addAnimation:groupAnimation forKey: @"lineToPointAndBounce"];
}

//MARK: ---- start ArrowLine To StraightLine
-(void)startArrowLineToStraightLine
{
    CAKeyframeAnimation *arrowToStraightAnimation = [_pathProduction creatArrowLineToStraightLineAnimation:@[(__bridge id)_pathProduction.arrowlineBezierPath.CGPath, (__bridge id)_pathProduction.arrowLinemiddleEndPath.CGPath]];
    arrowToStraightAnimation.delegate = self;
    [_arrowLine addAnimation:arrowToStraightAnimation forKey:@"arrowToStraightAnimation"];
}

//MARK: ----- Pause downloadAnimation
-(void)pauseDownloadAnimation
{
    if (self.delegate) {
        [self.delegate pauseDownloadAnimation];
    }
}

//MARK: ------ download Progress
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    //Draw the progress
    _downloadtrackLine.path = [_pathProduction drawDownLoadTrackLineWith:progress].CGPath;
    _progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([_arrowVerticalLine animationForKey:@"lineToPointAndBounce"] == anim) {
        self.userInteractionEnabled = YES;
        [_arrowLine removeFromSuperlayer];
        _arrowLine = nil;
        //show progress
        _progressLabel.hidden = NO;
        [self showProgressLabel:YES];
        _wavyTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(wavingAnimation) userInfo:nil repeats:YES];
        if (self.delegate) {
            [self.delegate startAnimation];
        }
    }
}

//MARK: ------ waveAnimation
-(void)wavingAnimation
{
    CGFloat progressWaveHeight = 10.0 * ( _progress - powf(_progress, 2)) ;
    [self waveAnimationWithHeight:_progress < 0.5 ? ASWaveHeight : progressWaveHeight];
}

-(void)waveAnimationWithHeight:(CGFloat)waveHeight
{
    self.offset += self.waveSpeed;
    self.arrowLine.path = [_pathProduction getWavePathWithOffset:self.offset
                                                    WaveHeight:waveHeight
                                                 WaveCurvature:self.waveCurvature].CGPath;
}

-(void)showProgressLabel:(BOOL)show
{
    [self addSubview:_progressLabel];
    //show and hide
    CASpringAnimation *springLabelAnimation = [_pathProduction getProgressAnimationWith:show];
    [_progressLabel.layer addAnimation:springLabelAnimation forKey:@"springLabelAnimation"];
    if (!show) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_progressLabel removeFromSuperview];\
            [_progressLabel.layer removeAllAnimations];
            _progressLabel = nil;
        });
    }
}

//MARK: ------ compliment
-(void)setDownloadSuccessful:(BOOL)downloadSuccessful
{
    _downloadSuccessful = downloadSuccessful;
    if (downloadSuccessful) {//download success
        self.userInteractionEnabled = NO;
        [_wavyTimer invalidate];
        _wavyTimer = nil;
        //line to right line
        [self lineToRightLineAnimation];
        //progressLabel hide
        [self showProgressLabel:NO];
    }else{//download failure
        //Display failure for download
        self.arrowLine.hidden = YES;
        _progressLabel.hidden = YES;
        _downloadtrackLine.hidden = YES;
        self.failedBtn.hidden = NO;
        [self.failedBtn.layer addAnimation:_pathProduction.failedAnimation forKey:@"failedAnimation"];
        _arrowVerticalLine.hidden = YES;
        
        if (_wavyTimer) {
            [_wavyTimer invalidate];
            _wavyTimer = nil;
        }
        [self.arrowLine removeAllAnimations];
        [_arrowVerticalLine removeAllAnimations];
        self.arrowLine.path = _pathProduction.arrowlineBezierPath.CGPath;
        self.progress = 0;
        _downloadtrackLine.path = [_pathProduction drawDownLoadTrackLineWith:self.progress].CGPath;
        _arrowVerticalLine.path = _pathProduction.arrowVerticalBezierPath.CGPath;
        _isDownLoading = NO;
    }
}

-(void)lineToRightLineAnimation
{
    CAKeyframeAnimation *lineToRightAnimation = [_pathProduction lineToRightLineAnimationWithValues:@[(__bridge id)_pathProduction.arrowLinemiddleEndPath.CGPath, (__bridge id)_pathProduction.rightLinePath.CGPath]];
    lineToRightAnimation.delegate = self;
    [self.arrowLine addAnimation:lineToRightAnimation forKey:@"lineToRightAnimation"];
}


-(void)cancelDownload
{
    if (_wavyTimer) {
        [_wavyTimer invalidate];
        _wavyTimer = nil;
    }
    _progressLabel.hidden = YES;
    [self.arrowLine removeAllAnimations];
    [_arrowVerticalLine removeAllAnimations];
    self.arrowLine.path = _pathProduction.arrowlineBezierPath.CGPath;
    self.progress = 0;
    _downloadtrackLine.path = [_pathProduction drawDownLoadTrackLineWith:self.progress].CGPath;
    _arrowVerticalLine.path = _pathProduction.arrowVerticalBezierPath.CGPath;
    _isDownLoading = NO;
}


- (void)drawRect:(CGRect)rect {
    
}


@end
