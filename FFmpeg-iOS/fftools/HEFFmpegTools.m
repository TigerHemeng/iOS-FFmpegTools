//
//  HEFFmpegTools.m
//  HESwiftProject
//
//  Created by HeMeng on 2021/10/8.
//  Copyright © 2021 hemeng. All rights reserved.
//

#import "HEFFmpegTools.h"
#import "ffmpeg.h"

@implementation HEFFmpegTools

+ (void)runCmd:(NSString *)commandStr completionBlock:(void(^)(int result))completionBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 根据 " " 将指令分割为指令数组
        NSArray *argv_array = [commandStr componentsSeparatedByString:(@" ")];
        // 将OC对象转换为对应的C对象
        int argc = (int)argv_array.count;
        char** argv = (char**)malloc(sizeof(char*)*argc);
        for(int i=0; i < argc; i++) {
            argv[i] = (char*)malloc(sizeof(char)*1024);
            strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
        }

        // 打印日志
//        NSString *finalCommand = @"运行参数:";
//        for (NSString *temp in argv_array) {
//            finalCommand = [finalCommand stringByAppendingFormat:@"%@",temp];
//        }
//        NSLog(@"%@",finalCommand);
        
        // 传入指令数及指令数组,result==0表示成功
        int result = ffmpeg_main(argc,argv);
        NSLog(@"执行FFmpeg命令：%@，result = %d",commandStr,result);

        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(result);
        });
    });
}

@end
