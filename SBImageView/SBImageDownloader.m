//
//  SBImageDownloader.m
//  SBImageViewDemo
//
//  Created by 孙士博 on 2018/9/21.
//  Copyright © 2018年 com.Instagram. All rights reserved.
//

#import "SBImageDownloader.h"

@implementation SBImageDownloader

+(id)sharedImageDownloader{
    static SBImageDownloader *imageDownloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageDownloader = [[self alloc]init];
    });
    return imageDownloader;
}

-(void)downloadImageWithURL:(NSURL *)url complete:(ImageDownloadedBlock)completeBlock {
    SBImageStoreManager *storeManager = [SBImageStoreManager sharedInstance];
    NSString *imageUrl = [url absoluteString];
    UIImage *image = [storeManager getImageFromMemoryForkey:imageUrl];
    // 先从内存中取
    if (image) {
        if (completeBlock) {
            NSLog(@"image exists in memory");
            completeBlock(image,nil,imageUrl);
        }
        
        return;
    }
    //从文件中取
    image = [storeManager getImageFromFileForkey:imageUrl];
    if (image) {
        if (completeBlock) {
            NSLog(@"image exists in file");
            completeBlock(image,nil,imageUrl);
        }
        
        [storeManager storeImageToMemory:image forKey:imageUrl];
        
        return;
    }
    
    //网络下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        NSData *imgData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imgData];
            
            if (image) {
                // 先缓存图片到内存
                [storeManager storeImageToMemory:image forKey:imageUrl];
                
                // 再缓存图片到文件系统
                NSString *extension = [[imageUrl substringFromIndex:imageUrl.length-3] lowercaseString];
                NSString *imageType = @"jpg";
                
                if ([extension isEqualToString:@"jpg"]) {
                    imageType = @"jpg";
                }else{
                    imageType = @"png";
                }
                
                [storeManager storeImageToFile:image forKey:imageUrl forType:imageType];
            }
            
            if (completeBlock) {
                completeBlock(image,error,imageUrl);
            }
        });
    });
    
}

@end
