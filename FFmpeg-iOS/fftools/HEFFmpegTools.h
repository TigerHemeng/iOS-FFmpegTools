//
//  HEFFmpegTools.h
//  HESwiftProject
//
//  Created by HeMeng on 2021/10/8.
//  Copyright © 2021 hemeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HEFFmpegTools : NSObject
/***
 执行ffmpeg指令，" "为分割标记符，也可以使用其他代替
 示例：
 let image = "\(Bundle.main.bundlePath)/image%d.JPG"
 let compositionCmd = "ffmpeg -f image2 -i \(image) \(videoPath)"
 */
+ (void)runCmd:(NSString *)commandStr completionBlock:(void(^)(int result))completionBlock;
@end

NS_ASSUME_NONNULL_END
