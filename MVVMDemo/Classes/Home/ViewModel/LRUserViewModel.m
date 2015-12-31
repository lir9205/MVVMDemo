//
//  LRUserViewModel.m
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import "LRUserViewModel.h"
#import "LRLocalizationApi.h"
#import "LRUser.h"
#import "LRNetworkingApi.h"
#import "LRUserInfoCell.h"
#import "UIImageView+webcache.h"


#define Image_HOST @"http://192.168.0.3:8080/MoJieServer"

#define ImageUrlWithUrl(url) [NSString stringWithFormat:@"%@%@",Image_HOST, url]


@interface LRUserViewModel () {
    NSMutableArray *_names;
    NSMutableArray *_imageUrls;
    NSMutableArray *_contents;
    NSInteger _sections;
}

@property (nonatomic, strong) NSMutableArray *dataArray;




@end

@implementation LRUserViewModel

- (instancetype)initWithModel:(id)model {
    self = [super initWithModel:model];
    if (self) {
        _names = [[NSMutableArray alloc] init];
        _contents = [@[@"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规范化地方和法国恢复规划",
                       @"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规",
                       @"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规范化地方和法国恢复规划",
                       @"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规",
                       @"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规范化地方和法国恢复规划",
                       @"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规",
                       @"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规范化地方和法国恢复规划ghdfig",
                       @"dhsgfdfgh很多附加狗狗会华国锋反对和法国和规范东方化工和规"] mutableCopy];
        
        _imageUrls = [[NSMutableArray alloc] init];
    }
    return self;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)fetchData {
    [self fetchDataSuccess:^(HUBaskViewModel *viewModel) {
        if ([self.delegate respondsToSelector:@selector(viewModelDidFetchDataSucceed:)]) {
            [self.delegate viewModelDidFetchDataSucceed:self];
        }
    } failure:^(NSString *msg) {
        NSLog(@"errorMsg:%@",msg);
        //        failure(error.description);
    }];
}

- (void)fetchDataSuccess:(void (^)(HUBaskViewModel *))success failure:(void (^)(NSString *))failure {
    [super fetchDataSuccess:success failure:failure];
    //判断网络
    BOOL isnetworkingReachable = self.networkingReachable;
    //本地取
    if (!isnetworkingReachable) {
        self.model = [LRLocalizationApi querry:self.model];
        if (self.model) {
            success(self);
        } else {
            failure(@"没有信息");
        }
        return;
    }
    NSString *url = @"FriendsServlet";
    LRUser *user = (LRUser *)self.model;
    NSDictionary *parameters = @{@"user_id":user.userId,@"tag":@"attens"};
    [LRNetworkingApi POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"responseObj:%@",responseObject);
        NSArray * resultArray = responseObject[@"friends"];
        
        switch (self.loadType) {
            case HUViewModelLoadTypeLoadNew:
                self.dataArray = [resultArray mutableCopy];
                break;
                
            case HUViewModelLoadTypeLoadMore:
                [self.dataArray addObjectsFromArray:resultArray];
                break;
        }
        
        _sections = 1;
        [_names removeAllObjects];
        [_imageUrls removeAllObjects];
        [_contents removeAllObjects];
        for (NSDictionary *userDic in _dataArray) {
            [_names addObject: userDic[@"nickName"]];
            
            NSString *imageUrl = ImageUrlWithUrl(userDic[@"headUrl"]);
            [_imageUrls addObject: imageUrl];
            [_contents addObject: userDic[@"phone"]];
        }
        
        //一定记得回调
        if (success) {
            success(self);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSString *error) {
         NSLog(@"errorMsg:%@",error);
        failure(error.description);
    }];
   
}

- (NSInteger)numberOfSections {
    return _sections;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return _names.count;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath {
    if (_names) {
        return _names[indexPath.row];
    }
    return nil;
}

- (NSString *)contentAtIndexPath:(NSIndexPath *)indexPath{
    if (_contents) {
        return _contents[indexPath.row];
    }
    return nil;
}

- (NSString *)imaUrlAtIndexPath:(NSIndexPath *)indexPath{
    if (_imageUrls) {
        return _imageUrls[indexPath.row];
    }
    return nil;
}


@end
