//
//  HEFFmpegBridge.h
//  HESwiftProject
//
//  Created by HeMeng on 2021/10/11.
//  Copyright © 2021 hemeng. All rights reserved.
//

///获取输入源文件的时长
void setDuration(long long duration);

///获取当前的处理进度
void setCurrentTimeFromProgressInfo(char *progressInfo);
