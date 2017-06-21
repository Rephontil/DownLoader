//
//  ZYDownLoader.h
//  ZYDownLoader
//
//  Created by ZhouYong on 2017/1/8.
//  Copyright © 2017年 ZhouYong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZYDownLoadState) {
    ZYDownLoadStatePause,
    ZYDownLoadStateDownLoading,
    ZYDownLoadStatePauseSuccess,
    ZYDownLoadStatePauseFailed
};


typedef void(^DownLoadInfoType)(long long totalSize);
typedef void(^ProgressBlockType)(float progress);
typedef void(^SuccessBlockType)(NSString *filePath);
typedef void(^FailedBlockType)();
typedef void(^StateChangeType)(ZYDownLoadState state);


// 一个下载器, 对应一个下载任务
// ZYDownLoader -> url
@interface ZYDownLoader : NSObject



- (void)downLoader:(NSURL *)url downLoadInfo:(DownLoadInfoType)downLoadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
/**
 根据URL地址下载资源, 如果任务已经存在, 则执行继续动作
 @param url 资源路径
 */
- (void)downLoader:(NSURL *)url;
- (void)resumeCurrentTask;
/**
 暂停任务
 注意:
 - 如果调用了几次继续
 - 调用几次暂停, 才可以暂停
 - 解决方案: 引入状态
 */
- (void)pauseCurrentTask;

/**
 取消任务
 */
- (void)cacelCurrentTask;

/**
 取消任务, 并清理资源
 */
- (void)cacelAndClean;



/// 数据
/// 事件&数据
@property (nonatomic, assign, readonly) ZYDownLoadState state;
@property (nonatomic, assign, readonly) float progress;

@property (nonatomic, copy) DownLoadInfoType downLoadInfo;
@property (nonatomic, copy) StateChangeType stateChange;
@property (nonatomic, copy) ProgressBlockType progressChange;
@property (nonatomic, copy) SuccessBlockType successBlock;
@property (nonatomic, copy) FailedBlockType faildBlock;
@property (nonatomic, copy) void(^taskBlock)(NSString *taskName);
    
    
    
// delegate

@end
