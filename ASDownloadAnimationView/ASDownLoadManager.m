//
//  ASDownLoadManager.m
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/25.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASDownLoadManager.h"
#import "AFNetworking.h"
@interface ASDownLoadManager ()
{
    NSURLSessionDownloadTask *_downloadTask;
}
@end
@implementation ASDownLoadManager
-(void)downLoadWithURL:(NSString *)url progress:(ASDownloadProgressBlock)downloadProgressBlock path:(ASDestinationBlock)destinationBlock completion:(ASCompletionHanderBlock)completionHanderBlock{
    NSURL *requestURL = [NSURL URLWithString:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        downloadProgressBlock(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return destinationBlock(targetPath, response);
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completionHanderBlock(response, filePath, error);
    }];
    [self resume];
}

- (void)cancel{
    
    [_downloadTask cancel];
}

- (void)resume{
    
    [_downloadTask resume];
}

- (void)suspend{
    
    [_downloadTask suspend];
}

@end
