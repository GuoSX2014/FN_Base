//
//  FNContentsMacros.h
//  FNYunWei
//  内容路径
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#ifndef FNContentsMacros_h
#define FNContentsMacros_h

#pragma mark - *************************  本地文档相关  *************************
/** 获取Tmp目录 */
#define     kTmpPath                         NSTemporaryDirectory()

/** 获取Documents目录 */
#define     kDocumentsPath                  ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject])

/** 获得Documents下指定文件名的文件路径 */
#define     kFilePath(filename)             ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:filename])

/** 获取Library目录 */
#define     kLibraryPath                    ([NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject])

/** 获取Caches目录 */
#define     kCachesPath                      ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject])

#define     kFolderCachesPath(folderName)   ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:folderName])

#define     kFileCachesPath(fileName)       ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName])


/** 获取APP名称 */
#define kAppName                ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
/** 获取APP版本 */
#define kAppVersion             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
/** 获取APP build版本 */
#define kAppBuildVersion        ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#endif /* FNContentsMacros_h */
