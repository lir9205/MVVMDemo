//
//  LRNetworkingApi.h
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSString *error);

@interface LRNetworkingApi : NSObject

+ (instancetype)sharedNetworkingApi;

+ (void)cancel;

+ (void)GET:(NSString *)URLString
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;

+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(SuccessBlock)success
     failure:(FailureBlock)failure;


+ (void)uploadWithPOST:(NSString *)URLString
            parameters:(id)parameters
                 datas:(NSArray *)datas
              fileName:(NSArray *)fileName
               success:(SuccessBlock)success
               failure:(FailureBlock)failure;

@end


