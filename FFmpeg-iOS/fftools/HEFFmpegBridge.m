//
//  HEFFmpegBridge.m
//  HESwiftProject
//
//  Created by HeMeng on 2021/10/11.
//  Copyright © 2021 hemeng. All rights reserved.
//

#import "HEFFmpegBridge.h"
#import <Foundation/Foundation.h>

static long long totalDuration = 0;

void setDuration(long long duration) {
    
    //duration的精度到微秒
    //比如视频长度 00:00:24.53，duration会是24533333
    //比如视频长度 00:01:16.10，duration会是76100000
    printf("\n fileDuration = %lld\n",duration);
    totalDuration = duration;
}

void setCurrentTimeFromProgressInfo(char *progressInfo) {
    //progressInfo
    //e.g. frame= 1968 fps=100 q=31.0 size=    4864kB time=00:01:06.59 bitrate= 598.3kbits/s speed=3.38x
    //printf("\n ctime = %s\n",progressInfo);
    
    NSString *progressStr = [NSString stringWithCString:progressInfo encoding:NSUTF8StringEncoding];
    NSArray *infoArray = [progressStr componentsSeparatedByString:@" "];
    NSString *timeString = @"";
    for (NSString *info in infoArray) {
        if ([info containsString:@"time"]) {
            timeString = [info componentsSeparatedByString:@"="].lastObject;//e.g. 00:01:16.10，精确到十毫秒
        }
    }
    NSArray *hmsArray = [timeString componentsSeparatedByString:@":"];
    if (hmsArray.count != 3) {
        return;
    }
    long long hours = [hmsArray[0] longLongValue];
    long long minutes = [hmsArray[1] longLongValue];
    long long seconds = 0;
    long long mseconds = 0;
    NSArray *tempArr = [hmsArray[2] componentsSeparatedByString:@"."];
    if (tempArr.count == 2) {
        seconds = [tempArr.firstObject longLongValue];
        mseconds = [tempArr.lastObject longLongValue];
    }
    long long currentTime = (hours * 3600 + minutes * 60 + seconds) * 1000000 + mseconds * 10000;
    double progress = [[NSString stringWithFormat:@"%.2f",currentTime * 1.0 / totalDuration] doubleValue];
    NSLog(@"progress = %.2f",progress);
//    //ffmpeg操作是在子线程中执行的
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //更新进度UI
//    });
}
