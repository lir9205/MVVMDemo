//
//  LRNetworkingApi.m
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import "LRNetworkingApi.h"
#import <AFNetworking/AFNetworking.h>

@interface LRNetworkingApi ()


@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) NSString *basicURL;

@end

@implementation LRNetworkingApi

+ (instancetype)sharedNetworkingApi {
    static LRNetworkingApi *networkingApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkingApi = [[LRNetworkingApi alloc] init];
    });
    return networkingApi;
}
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    AFHTTPSessionManager *httpSessionManager = [AFHTTPSessionManager manager];
    httpSessionManager.requestSerializer.timeoutInterval = 30.0f;
    httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript", nil];
    _httpSessionManager = httpSessionManager;
    _basicURL = @"http://192.168.0.3:8080/MoJieServer/";
    return self;
    
}
+ (void)GET:(NSString *)URLString success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",[LRNetworkingApi sharedNetworkingApi].basicURL,URLString];
    [[LRNetworkingApi sharedNetworkingApi].httpSessionManager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [task cancel];
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error:%@",error);
        NSString *errorMsg = [self errorMsgFromError:error.userInfo[NSLocalizedDescriptionKey]];
        failure(task,errorMsg);
    }];
}
+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",[LRNetworkingApi sharedNetworkingApi].basicURL,URLString];
    [[LRNetworkingApi sharedNetworkingApi].httpSessionManager POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [task cancel];
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error:%@",error);
        NSString *errorMsg = [self errorMsgFromError:error.userInfo[NSLocalizedDescriptionKey]];
        failure(task,errorMsg);
    }];
}
#warning 上传图片
+ (void)uploadWithPOST:(NSString *)URLString
            parameters:(id)parameters
                 datas:(NSArray *)datas
              fileName:(NSArray *)fileName
               success:(SuccessBlock)success
               failure:(FailureBlock)failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[LRNetworkingApi sharedNetworkingApi].basicURL,URLString];
    [[LRNetworkingApi sharedNetworkingApi].httpSessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [datas enumerateObjectsUsingBlock:^(NSData *data, NSUInteger idx, BOOL *stop) {
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyMMddHHmmss";
            
            NSString *fileName = [NSString stringWithFormat:@"%@%zd.png",[formatter stringFromDate:date],idx];
            [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/png"];
        }];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *errorMsg = [self errorMsgFromError:error.userInfo[NSLocalizedDescriptionKey]];
        failure(task,errorMsg);
    }];
}
+(void)cancel {
    [[LRNetworkingApi sharedNetworkingApi].httpSessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
+ (NSString *)errorMsgFromError:(NSString *)errorMsg {
    NSString *error = @"连接超时";
    if ([errorMsg isEqualToString:@"The request timed out."]) {
        error = @"连接超时";
    }
    else if ([errorMsg isEqualToString:@"Could not connect to the server."]) {
        error = @"服务器开了点小差，先休息下吧";
    }
    
    return error;
}
@end