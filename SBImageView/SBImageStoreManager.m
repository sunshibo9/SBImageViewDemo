//
//  SBImageStoreManager.m
//  SBImageViewDemo
//
//  Created by 孙士博 on 2018/9/20.
//  Copyright © 2018年 com.Instagram. All rights reserved.
//

#import "SBImageStoreManager.h"

@implementation SBImageStoreManager

+(SBImageStoreManager*)sharedInstance {
    static SBImageStoreManager *storeManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        storeManger = [[self alloc] init];
    });
    return storeManger;
}

-(id)init {
    if (self ==[super init]) {
        downloadQueue = dispatch_queue_create("com.downloadqueue", DISPATCH_QUEUE_SERIAL);
        cache = [[NSCache alloc]init];
        cache.name = @"image_cache";
        
        fileManager = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cacheDir = [paths objectAtIndex:0];
    }
    return self;
}

-(void)storeImageToMemory:(UIImage*)image forKey:(NSString*)key {
    if(image) {
        [cache setObject:image forKey:key];
    }
}

-(UIImage*)getImageFromMemoryForkey:(NSString*)key {
    return [cache objectForKey:key];
}

-(void)storeImageToFile:(UIImage*)image forKey:(NSString*)key forType:(NSString*)imageType {
    if (!image || !key ||!imageType) {
        return;
    }
    dispatch_async(downloadQueue, ^{
        NSRange range = [key rangeOfString:@"/" options:NSBackwardsSearch];
        NSString *filename = [key substringFromIndex:range.location+1];
        NSString *filepath = [self->cacheDir stringByAppendingPathComponent:filename];
        NSData *data = nil;
        
        if ([imageType isEqualToString:@"jpg"]) {
            data = UIImageJPEGRepresentation(image, 1.0);
        }else{
            data = UIImagePNGRepresentation(image);
        }
        
        if (data) {
            [data writeToFile:filepath atomically:YES];
        }
    });
}

-(UIImage*)getImageFromFileForkey:(NSString *)key {
    if (!key) {
        return nil;
    }
    
    NSRange range = [key rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *filename = [key substringFromIndex:range.location+1];
    NSString *filepath = [cacheDir stringByAppendingPathComponent:filename];
    
    if ([fileManager fileExistsAtPath:filepath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filepath];
        return image;
    }
    
    return nil;
}

@end
