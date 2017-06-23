//
//  ZYDownLoaderManager.m
//  ZYDownLoader
//
//  Created by ZhouYong on 2016/8/14.
//  Copyright © 2017年 ZhouYong. All rights reserved.
//

#import "ZYDownLoaderManager.h"
#import "NSString+SZ.h"
@interface ZYDownLoaderManager()<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSMutableDictionary *downLoadInfo;

@end


@implementation ZYDownLoaderManager

static ZYDownLoaderManager *_shareInstance;
+ (instancetype)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [[self alloc] init];
    }
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_shareInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _shareInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _shareInstance;
}

// key: md5(url)  value: ZYDownLoader
- (NSMutableDictionary *)downLoadInfo {
    if (!_downLoadInfo) {
        _downLoadInfo = [NSMutableDictionary dictionary];
    }
    return _downLoadInfo;
}


- (void)downLoader:(NSURL *)url downLoadInfo:(DownLoadInfoType)downLoadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    
    // 1. url
    NSString *urlMD5 = [url.absoluteString md5];
    
    // 2. 根据 urlMD5 , 查找相应的下载器
    ZYDownLoader *downLoader = self.downLoadInfo[urlMD5];
    if (downLoader == nil) {
        downLoader = [[ZYDownLoader alloc] init];
        self.downLoadInfo[urlMD5] = downLoader;
    }
        
    __weak typeof(self) weakSelf = self;
    [downLoader downLoader:url downLoadInfo:downLoadInfo progress:progressBlock success:^(NSString *filePath) {
        
        // 下载完成之后, 移除下载器
        [weakSelf.downLoadInfo removeObjectForKey:urlMD5];
        // 拦截block
        successBlock(filePath);
    } failed:failedBlock];
    
}

- (void)pauseWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    ZYDownLoader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader pauseCurrentTask];
}

- (void)resumeWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    ZYDownLoader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader resumeCurrentTask];
}

- (void)cancelWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    ZYDownLoader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader cancelCurrentTask];
}

- (void)cancelAndCleanWithURL:(NSURL *)url{
    NSString *urlMD5 = [url.absoluteString md5];
    ZYDownLoader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader cacelAndClean];
}

- (void)pauseAll {
    [self.downLoadInfo.allValues performSelector:@selector(pauseCurrentTask) withObject:nil];
}

- (void)cancelAll{
    [self.downLoadInfo.allKeys performSelector:@selector(cancelCurrentTask) withObject:nil];
}

- (void)resumeAll {
     [self.downLoadInfo.allValues performSelector:@selector(resumeCurrentTask) withObject:nil];
}

- (void)cancelAndCleanAll{
    [self.downLoadInfo.allKeys performSelector:@selector(cacelAndClean) withObject:nil];
}


@end
