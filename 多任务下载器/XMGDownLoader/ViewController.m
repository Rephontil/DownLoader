//
//  ViewController.m
//  ZYDownLoader
//
//  Created by ZhouYong on 2016/8/8.
//  Copyright © 2017年 ZhouYong. All rights reserved.
//

#import "ViewController.h"
#import "ZYDownLoaderManager.h"

@interface ViewController ()


@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ViewController

- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}


- (void)update {
//    NSLog(@"----%zd", self.downLoader.state);
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self timer];
  
}

- (IBAction)download:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://free2.macx.cn:8281/tools/photo/SnapNDragPro418.dmg"];
    NSURL *url2 = [NSURL URLWithString:@"http://free2.macx.cn:8281/tools/photo/Sip44.dmg"];
    
    [[ZYDownLoaderManager shareInstance] downLoader:url2 downLoadInfo:^(long long totalSize) {
        NSLog(@"下载信息--%lld", totalSize);
    } progress:^(float progress) {
        NSLog(@"下载进度--%f", progress);
    } success:^(NSString *filePath) {
        NSLog(@"下载成功--路径:%@", filePath);
    } failed:^{
        NSLog(@"下载失败了");
    }];
    
    [[ZYDownLoaderManager shareInstance] downLoader:url downLoadInfo:^(long long totalSize) {
        NSLog(@"下载信息--%lld", totalSize);
    } progress:^(float progress) {
        NSLog(@"下载进度--%f", progress);
    } success:^(NSString *filePath) {
        NSLog(@"下载成功--路径:%@", filePath);
    } failed:^{
        NSLog(@"下载失败了");
    }];
    
}

- (IBAction)pause:(id)sender {
    [[ZYDownLoaderManager shareInstance] pauseAll];
}
- (IBAction)cancel:(id)sender {
//    [self.downLoader cancelCurrentTask];
}
- (IBAction)cancelClean:(id)sender {
//    [self.downLoader cacelAndClean];
}
    

@end
