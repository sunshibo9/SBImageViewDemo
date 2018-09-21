//
//  SBImageDownloader.h
//  SBImageViewDemo
//
//  Created by 孙士博 on 2018/9/21.
//  Copyright © 2018年 com.Instagram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBImageStoreManager.h"
//定义回调函数
typedef void(^ImageDownloadedBlock)(UIImage *image, NSError *error, NSString *imageURL);

@interface SBImageDownloader : NSObject
//单例模式
+(id)sharedImageDownloader;
//下载图片
-(void)downloadImageWithURL:(NSURL *)url complete:(ImageDownloadedBlock)completeBlock;


@end
