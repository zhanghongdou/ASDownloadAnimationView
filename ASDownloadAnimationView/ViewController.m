//
//  ViewController.m
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "ASDownLoadAnimationView.h"
#import "ASDownLoadManager.h"
@interface ViewController ()<ASDownLoadAnimationViewDelegate>
@property (nonatomic, strong) ASDownLoadManager *manager;
@property (nonatomic, strong) ASDownLoadAnimationView * downloadView;
@end

@implementation ViewController
- (ASDownLoadManager *)manager{
    
    if (!_manager) {
        _manager = [[ASDownLoadManager alloc] init];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.1961 green:0.6275 blue:0.9255 alpha:1];
    self.downloadView = [[ASDownLoadAnimationView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 100 / 2, 200, 100, 100)];
    
    self.downloadView.backgroundColor = [UIColor colorWithRed:0.1961 green:0.6275 blue:0.9255 alpha:1];
    self.downloadView.delegate = self;
    [self.view addSubview:self.downloadView];
}

- (IBAction)cancelDownLoad:(id)sender {
    [self.manager cancel];
    [self.downloadView cancelDownload];
}


- (void)downTask{
    NSString*url = @"http://obh6cwxkc.bkt.clouddn.com/1iStat%20Menus.app.zip";
    [self.manager downLoadWithURL:url progress:^(NSProgress *downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *progressString  = [NSString stringWithFormat:@"%.2f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount];
            self.downloadView.progress = progressString.floatValue;
        });
    } path:^NSURL *(NSURL *targerPath, NSURLResponse *response) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            //download success
            if (!error) {
              self.downloadView.downloadSuccessful = YES;
            }
        }else{
            //download failure
            self.downloadView.downloadSuccessful = NO;
        }
    }];
}

-(void)startAnimation
{
    [self downTask];
}

-(void)pauseDownloadAnimation
{
    [self.manager suspend];
}
-(void)resumeDownloadAnimation
{
    [self.manager resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
