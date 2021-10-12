# iOS-FFmpegTools

这是一个基于FFmpeg4.2版本编译好的FFmpeg库，并集成了命令行工具的配置，导入iOS项目后可以直接使用FFmpeg代码或在业务代码中直接使用FFmpeg命令操作。

下载仓库代码后将整个FFmpeg-iOS目录直接拖进项目工程(仓库代码clone下来之后会发现FFmpeg-iOS/lib/libavcodec.a这个文件很小，这是不对的，这个文件需要单独下载下来，大概有120MB，然后替换一下)，然后添加工程配置
1. 添加依赖的系统库 Build Phases — Link Binary With Libraries，添加 libz.tbd、libbz2.tbd、libiconv.tbd、CoreMedia.framework、VideoToolbox.framework、AudioToolbox.framework；
2. 设置 Header Search Paths 路径，指向项目中include目录 e.g. $(SRCROOT)/HESwiftProject/Third/FFmpeg-iOS/include；
3. 针对命令工具的使用封装了一个函数，请看FFmpeg-iOS/fftools/HEFFmpegTools.h这个文件，处理过程的进度回调请看FFmpeg-iOS/fftools/HEFFmpegBridge.m这个文件。

使用命令工具的示例代码：
```
//视频旋转90度并保存到相册
let videoPath =  NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/tempvideo.mp4"
let video = "\(Bundle.main.bundlePath)/ffm_video2.mp4"
let transformCmd = "ffmpeg -i \(video) -y -vf rotate=PI/2 \(videoPath)";
HEFFmpegTools.runCmd(transformCmd) { (result) in
    if FileManager.default.fileExists(atPath: videoPath) {
        print("保存到相册");
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil)
    }
}
```

具体生成过程请看这里：[简书](https://www.jianshu.com/p/67348e253787)
