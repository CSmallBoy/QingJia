//
//  HCSavePhotoToAblumMgr.m
//  钦家
//
//  Created by Tony on 16/6/2.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCSavePhotoToAblumMgr.h"

static HCSavePhotoToAblumMgr *_shareManager = nil;

@implementation HCSavePhotoToAblumMgr

+ (HCSavePhotoToAblumMgr *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[HCSavePhotoToAblumMgr alloc] init];
    });
    return _shareManager;
}

- (NSString *)saveImageToAblum:(UIImage *)image
{
    __block NSString *createdAssetId = nil;
    // 添加图片到【相机胶卷】
    // 同步方法,直接创建图片,代码执行完,图片没创建完,所以使用占位ID (createdAssetId)
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    
    // 在保存完毕后取出图片
    PHFetchResult<PHAsset *> *createdAssets = [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetId] options:nil];
    
    // 获取软件的名字作为相册的标题
    //如果用普通plist文件创建方法创建是错误的,如
    //[NSDictionary dictionaryWithContensOfFile:[[NSBundle mainBundle] pathForResource:@"Test"ofType:@"plist"]];
    // 系统的plist文件只能使用以下方法调用
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    // 已经创建的自定义相册
    PHAssetCollection *createdCollection = nil;
    
    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            createdCollection = collection;
            break;
        }
    }
    
    if (!createdCollection) { // 没有创建过相册
        __block NSString *createdCollectionId = nil;
        // 创建一个新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        } error:nil];
        
        // 创建完毕后再取出相册
        createdCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
    }
    
    if (createdAssets == nil || createdCollection == nil) {
        return @"保存失败";
    }
    
    // 将刚才添加到【相机胶卷】的图片，引用（添加）到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        // 自定义相册封面默认保存第一张图,所以使用以下方法把最新保存照片设为封面
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 保存结果
    if (error) {
        return @"保存失败";
    } else {
        return @"保存成功";
    }

}

@end
