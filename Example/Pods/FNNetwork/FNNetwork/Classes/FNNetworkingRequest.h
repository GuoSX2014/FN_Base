//
//  FNNetworkingRequest.h
//  FNCommon
//
//  Created by 毕杰涛 on 2018/5/23.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FNResponseDataKeyType) {
    /** 包含*/
    FNResponseHaveDataKey = 0,
    /** 不包含*/
    FNResponseNotHaveDataKey,
};


typedef NS_ENUM(NSUInteger, FNNetworkStatusType) {
    /** 未知网络*/
    FNNetworkStatusUnknown = 0,
    /** 无网络*/
    FNNetworkStatusNotReachable,
    /** 手机网络*/
    FNNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    FNNetworkStatusReachableViaWiFi
};
/** 网络状态的Block*/
typedef void(^FNNetworkStatus)(FNNetworkStatusType status);

/**
 *  请求成功时的回调
 *
 *  @param returnData 回调的对象
 *  @param code           回调的code
 *  @param msg            回调的信息
 */
typedef void (^FNRequestSuccessBlock)(id returnData, NSInteger code, NSString *msg);

/**
 *  缓存的Block
 *
 *  @param responseCache 回调的对象
 *  @param code           回调的code
 *  @param msg            回调的信息
 */
typedef void(^FNRequestCacheSuccessBlock)(id responseCache, NSInteger code,NSString *msg);
/**
 *  网络层 - 请求错误的回调
 *
 *  @param error 错误回调的对象
 */
typedef void (^FNRequestFailureBlock)(NSError *error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^FNHttpProgress)(NSProgress *progress);


#define  kTokenExpiredNotification @"kTokenExpiredNotification"

@interface FNNetworkingRequest : NSObject
/**
 开启日志打印 (Debug级别)
 */
+ (void)openLog;

/**
 关闭日志打印,默认关闭
 */
+ (void)closeLog;

/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)

 @param networkStatus networkStatus
 */
+ (void)startMonitoring:(FNNetworkStatus)networkStatus;

/**
 设置header头

 @param value 值
 @param field key
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


/**
 取消所有的网路
 */
+ (void)cancelAllRequest;

/**
 取消某一个网络

 @param URL 固定网络的URL
 */
+ (void)cancelRequestWithURL:(NSString *)URL;

/**
 *  POST请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(FNRequestSuccessBlock)success
                   failure:(FNRequestFailureBlock)failure;


/**
 *  POST请求-业务特殊需求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param dataKeyType 是否含有data层
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                  dataKeyType:(FNResponseDataKeyType)dataKeyType
                   success:(FNRequestSuccessBlock)success
                   failure:(FNRequestFailureBlock)failure;
/**
 *  GET请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(FNRequestSuccessBlock)success
                  failure:(FNRequestFailureBlock)failure;


/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(FNHttpProgress)progress
                              success:(FNRequestSuccessBlock)success
                              failure:(FNRequestFailureBlock)failure;

/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadFileWithURL:(NSString *)URL  parameters:(id)parameters name:(NSString *)name  filePath:(NSString *)filePath progress:(FNHttpProgress)progress success:(FNRequestSuccessBlock)success failure:(FNRequestFailureBlock)failure;

/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL parameters:(id)parameters  name:(NSString *)name images:(NSArray<UIImage *> *)images fileNames:(NSArray<NSString *> *)fileNames  imageScale:(CGFloat)imageScale imageType:(NSString *)imageType progress:(FNHttpProgress)progress success:(FNRequestSuccessBlock)success failure:(FNRequestFailureBlock)failure;

@end
