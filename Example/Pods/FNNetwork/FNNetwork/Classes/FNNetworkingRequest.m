//
//  FNNetworkingRequest.m
//  FNCommon
//
//  Created by 毕杰涛 on 2018/5/23.
//

#import "FNNetworkingRequest.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "Reachability.h"

@interface FNNetworkingRequest()

@end

static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;
static BOOL _isOpenLog;   // 是否已开启日志打印
@implementation FNNetworkingRequest

#pragma mark - 所有的HTTP请求共享一个AFHTTPSessionManager
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.requestSerializer  = [AFJSONRequestSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/png", @"text/plan",@"text/plain",nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // 2.设置非校验证书模式
    _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _sessionManager.securityPolicy.allowInvalidCertificates = YES;
    [_sessionManager.securityPolicy setValidatesDomainName:NO];
    [self openLog];
}

#pragma mark - 开始监听网络
+ (void)startMonitoring:(FNNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(FNNetworkStatusUnknown) : nil;
                    if (_isOpenLog) NSLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(FNNetworkStatusNotReachable) : nil;
                    if (_isOpenLog) NSLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(FNNetworkStatusReachableViaWWAN) : nil;
                    if (_isOpenLog) NSLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(FNNetworkStatusReachableViaWiFi) : nil;
                    if (_isOpenLog) NSLog(@"WIFI");
                    break;
            }
        }];
        [manager startMonitoring];
    });
    
}

#pragma mark - 有网无网
+ (BOOL)haveNetwork {
    BOOL isExistenceNetwork = NO;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            isExistenceNetwork=FALSE;
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            NSLog(@"正在使用wifi网络");
            break;
    }
    
    return isExistenceNetwork;
}

#pragma mark - 打开网络log
+ (void)openLog {
    _isOpenLog = YES;
}

#pragma mark - 关闭log
+ (void)closeLog {
    _isOpenLog = NO;
}
#pragma mark - 取消所有的网路
+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

#pragma mark - 取消某一个网络
+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - 存储着所有的请求task数组
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 设置header
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}


#pragma mark  POST请求
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(FNRequestSuccessBlock)success
                   failure:(FNRequestFailureBlock)failure{
   return [FNNetworkingRequest POST:URL parameters:parameters dataKeyType:FNResponseHaveDataKey success:success failure:failure];
}

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
               dataKeyType:(FNResponseDataKeyType)dataKeyType
                   success:(FNRequestSuccessBlock)success
                   failure:(FNRequestFailureBlock)failure{
    NSLog(@"URL %@ request back parameters = %@", URL,[self jsonToString:parameters]);
    if (![self haveNetwork]) {
        NSError *error = [NSError errorWithDomain:@"网络有问题" code:10001 userInfo:nil];
        failure ? failure(error) : nil;
        return nil;
    }
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog){
            NSLog(@"URL %@ request back responseObject = %@", URL,responseObject);
        }
        [[self allSessionTask] removeObject:task];
        NSInteger status = (![responseObject[@"code"] isKindOfClass:[NSNull class]]) ? [responseObject[@"code"] integerValue] : 10000;
        NSString *msgString = ([responseObject[@"msg"] isKindOfClass:[NSString class]]) ? responseObject[@"msg"]:@"服务器异常";
        if (status == 200) {//成功
            if (dataKeyType == FNResponseHaveDataKey) {
                success ? success(responseObject[@"data"], status, msgString) : nil;
            }else{
                success ? success(responseObject, status, msgString) : nil;
            }
        }else if (status == 401) {//token过期
            [[NSNotificationCenter defaultCenter] postNotificationName:kTokenExpiredNotification object:nil];
            NSError *error = [NSError errorWithDomain:msgString code:status userInfo:nil];
            failure ? failure(error) : nil;
        } else{//全局错误处理
            NSError *error = [NSError errorWithDomain:msgString code:status userInfo:nil];
            failure ? failure(error) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {
            NSLog(@"error = %@",error);
        }
        [[self allSessionTask] removeObject:task];
        NSError *error1 = [NSError errorWithDomain:@"网络有问题" code:error.code userInfo:nil];
        failure ? failure(error1) : nil;
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}


#pragma mark  GET请求
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(FNRequestSuccessBlock)success
                  failure:(FNRequestFailureBlock)failure{
     NSLog(@"URL %@ request back parameters = %@", URL,[self jsonToString:parameters]);
    if (![self haveNetwork]) {
        NSError *error = [NSError errorWithDomain:@"网络有问题" code:10001 userInfo:nil];
        failure ? failure(error) : nil;
        return nil;
    }
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog){
            NSLog(@"URL %@ request back responseObject = %@", URL,responseObject);
        }
        [[self allSessionTask] removeObject:task];
        NSInteger status = (![responseObject[@"code"] isKindOfClass:[NSNull class]]) ? [responseObject[@"code"] integerValue] : 10000;
        NSString *msgString = ([responseObject[@"msg"] isKindOfClass:[NSString class]]) ? responseObject[@"msg"]:@"服务器异常";
        if (status == 200) {//成功
            success ? success(responseObject[@"data"], status, msgString) : nil;
        }else if (status == 401) {//token过期
            [[NSNotificationCenter defaultCenter] postNotificationName:kTokenExpiredNotification object:nil];
            NSError *error = [NSError errorWithDomain:msgString code:status userInfo:nil];
            failure ? failure(error) : nil;
        }else{//全局错误处理
            NSError *error = [NSError errorWithDomain:msgString code:status userInfo:nil];
            failure ? failure(error) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {
            NSLog(@"error = %@",error);
        }
        [[self allSessionTask] removeObject:task];
        NSError *error1 = [NSError errorWithDomain:@"网络有问题" code:error.code userInfo:nil];
        failure ? failure(error1) : nil;
        
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}


#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(FNHttpProgress)progress
                              success:(FNRequestSuccessBlock)success
                              failure:(FNRequestFailureBlock)failure {
    if (![self haveNetwork]) {
        NSError *error = [NSError errorWithDomain:@"网络有问题" code:10001 userInfo:nil];
        failure ? failure(error) : nil;
        return nil;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"=======%@", downloadProgress);
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success( filePath.absoluteString, error.code, response.suggestedFilename) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    //添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(FNHttpProgress)progress
                                success:(FNRequestSuccessBlock)success
                                failure:(FNRequestFailureBlock)failure {
    if (![self haveNetwork]) {
        NSError *error = [NSError errorWithDomain:@"网络有问题" code:10001 userInfo:nil];
        failure ? failure(error) : nil;
        return nil;
    }
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        [formData appendPartWithFileData:data name:@"file" fileName:@"file.zip" mimeType:@"multipart/form-data"];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog){
            NSLog(@"URL %@ request back responseObject = %@", URL,responseObject);
        }
        [[self allSessionTask] removeObject:task];
        NSInteger status = (![responseObject[@"code"] isKindOfClass:[NSNull class]]) ? [responseObject[@"code"] integerValue] : 10000;
        NSString *msgString = ([responseObject[@"msg"] isKindOfClass:[NSString class]]) ? responseObject[@"msg"]:@"服务器异常";
        if (status == 200) {//成功
            success ? success(responseObject[@"data"], status, msgString) : nil;
        }else{//全局错误处理
            NSError *error = [NSError errorWithDomain:msgString code:status userInfo:nil];
            failure ? failure(error) : nil;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {
            NSLog(@"error = %@",error);
        }
        [[self allSessionTask] removeObject:task];
        NSError *error1 = [NSError errorWithDomain:@"网络有问题" code:error.code userInfo:nil];
        failure ? failure(error1) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark  上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(FNHttpProgress)progress
                                  success:(FNRequestSuccessBlock)success
                                  failure:(FNRequestFailureBlock)failure {
    
    if (![self haveNetwork]) {
        NSError *error = [NSError errorWithDomain:@"网络有问题" code:10001 userInfo:nil];
        failure ? failure(error) : nil;
        return nil;
    }
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parametersDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSMutableString *currentTimeString = [NSMutableString stringWithString:[formatter stringFromDate:[NSDate date]]];
            [currentTimeString appendString:[NSString stringWithFormat:@"-%zd.jpg",i]];
            [formData appendPartWithFileData:imageData name:name fileName:currentTimeString mimeType:@"multipart/form-data"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {NSLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject, [responseObject[@"code"] integerValue], responseObject[@"msg"]) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {NSLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}


/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
