//
//  ZYDownLoaderManager.h
//  ZYDownLoader
//
//  Created by ZhouYong on 2017/1/14.
//  Copyright © 2017年 ZhouYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYDownLoader.h"

@interface ZYDownLoaderManager : NSObject

+ (instancetype)shareInstance;

// 单例
// 1. 无论通过怎样的方式, 创建出来, 只有一个实例(alloc  copy mutableCopy)
// 2. 通过某种方式, 可以获取同一个对象,但是, 也可以通过其他方式, 创建出来新的对象

- (void)downLoader:(NSURL *)url downLoadInfo:(DownLoadInfoType)downLoadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;


- (void)pauseWithURL:(NSURL *)url;
- (void)resumeWithURL:(NSURL *)url;
- (void)cancelWithURL:(NSURL *)url;


- (void)pauseAll;
- (void)resumeAll;


@end
