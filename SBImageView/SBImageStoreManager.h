//
//  SBImageStoreManager.h
//  SBImageViewDemo
//
//  Created by 孙士博 on 2018/9/20.
//  Copyright © 2018年 com.Instagram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SBImageStoreManager : NSObject{
    @private
    NSCache *cache;
    NSFileManager *fileManager;
    NSString *cacheDir; //储存地址
    dispatch_queue_t downloadQueue; //下载队列
    
}

//单例模式
+(SBImageStoreManager*)sharedInstance;

//内存写入
-(void)storeImageToMemory:(UIImage*)image forKey:(NSString*)key;
//内存读取
-(UIImage*)getImageFromMemoryForkey:(NSString*)key;

//文件写入
-(void)storeImageToFile:(UIImage*)image forKey:(NSString*)key forType:(NSString*)imageType;
//文件读取
-(UIImage*)getImageFromFileForkey:(NSString*)key;

@end
