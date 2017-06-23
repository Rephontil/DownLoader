//
//  ZYDownLoaderManager.h
//  ZYDownLoader
//
//  Created by ZhouYong on 2016/8/14.
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


/**
 暂停url链接的资源下载

 @param url 下载链接
 */
- (void)pauseWithURL:(NSURL *)url;
/**
 继续url链接的资源下载
 
 @param url 下载链接
 */

- (void)resumeWithURL:(NSURL *)url;
/**
 取消url链接的资源下载
 
 @param url 下载链接
 */
- (void)cancelWithURL:(NSURL *)url;
/**
 取消url链接的资源下载并清空该链接已下载内容
 
 @param url 下载链接
 */

- (void)cancelAndCleanWithURL:(NSURL *)url;

/**
 暂停所有任务
 */
- (void)pauseAll;

/**
 取消所有任务
 */
- (void)cancelAll;

/**
 继续所有任务
 */
- (void)resumeAll;
/**
 取消全部url链接的资源下载并清空链接已下载内容
  */
- (void)cancelAndCleanAll;

@end
