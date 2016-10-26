//
//  ASDownLoadManager.h
//  ASDownloadAnimationView
//
//  Created by haohao on 16/10/25.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ASDownloadProgressBlock)(NSProgress * downloadProgress);
typedef NSURL* (^ASDestinationBlock)(NSURL *targerPath, NSURLResponse *response);
typedef void (^ASCompletionHanderBlock)(NSURLResponse *response, NSURL *filePath, NSError *error);
@interface ASDownLoadManager : NSObject
-(void)downLoadWithURL:(NSString *)url progress:(ASDownloadProgressBlock)downloadProgressBlock path:(ASDestinationBlock)destinationBlock completion:(ASCompletionHanderBlock)completionHanderBlock;
/**
 *  取消
 */
- (void)cancel;
/**
 *  开始
 */
- (void)resume;
/**
 *  暂停
 */
- (void)suspend;

@end
