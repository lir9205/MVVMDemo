//
//  ViewController.m
//  MVVMDemo
//
//  Created by 李芮 on 15/12/29.
//  Copyright (c) 2015年 lirui. All rights reserved.
//

#import "ViewController.h"
#import "LRUserViewModel.h"
#import "LRUserInfoCell.h"
#import "LRUser.h"
#import "UIImageView+WebCache.h"
//#import ""
#define kPlaceholder @"placeholder-85"
#define cellIdentifier @"cellId"
//static const NSString *cellIdentifier = @"cellId";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate, HUBasicViewModelDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) LRUserViewModel *userViewModel;
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (nonatomic,strong) LRUserInfoCell *tempCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关注";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"分页" style:UIBarButtonItemStylePlain target:self action:@selector(fenye)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [_tableView registerClass:[LRUserInfoCell class] forCellReuseIdentifier:cellIdentifier];
    
    _offscreenCells = [[NSMutableDictionary alloc] init];
    _tableView.estimatedRowHeight = 60.0f;
    if ([UIDevice currentDevice].systemVersion.integerValue > 7) {
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    LRUser *user = [[LRUser alloc] init];
    user.userId = @142;
    LRUserViewModel *userViewModel = [[LRUserViewModel alloc] initWithModel:user];
    self.userViewModel = userViewModel;
    
    self.userViewModel.loadType = HUViewModelLoadTypeLoadNew;

    self.userViewModel.delegate = self;
    //[self.userViewModel fetchData];
    
//    __weak typeof(self) weakself = self;
//    
//    [userViewModel fetchDataSuccess:^(HUBaskViewModel *viewModel) {
//        [weakself.tableView reloadData];
//    } failure:^(NSString *msg) {
//        
//    }];
    
}

- (void)viewModelDidFetchDataSucceed:(HUBaskViewModel *)viewModel {
    [self.tableView reloadData];
}

- (void)viewModel:(HUBaskViewModel *)viewModel didFailedWithErrorMsg:(NSString *)error {
    
    
}



- (void)fenye {
    self.userViewModel.loadType = HUViewModelLoadTypeLoadMore;
}
- (void)refresh {
    self.userViewModel.loadType = HUViewModelLoadTypeLoadNew;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   // NSLog(@"section:%zd",[self.userViewModel numberOfSections]);
    return [self.userViewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"row:%zd",[self.userViewModel numberOfRowsInSection:section]);
    return [self.userViewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = cellIdentifier;
    LRUserInfoCell *cell = (LRUserInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configCell:(LRUserInfoCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.titleLabel.text = [_userViewModel nameAtIndexPath:indexPath];
    NSString *urlStr = [_userViewModel imaUrlAtIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:kPlaceholder]];
    cell.contentLabel.text = [_userViewModel contentAtIndexPath:indexPath];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
    NSString *resuseIdentifier = cellIdentifier;
//    dispatch_once_t onceToken;
//    if (!_tempCell) {
//        <#statements#>
//    }
//    
//    
    LRUserInfoCell *cell = [self.offscreenCells objectForKey:resuseIdentifier];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:resuseIdentifier forIndexPath:indexPath];
        [self.offscreenCells setObject:cell forKey:cellIdentifier];
    }
    cell.titleLabel.text = [_userViewModel nameAtIndexPath:indexPath];
    NSString *urlStr = [_userViewModel imaUrlAtIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:kPlaceholder]];
    cell.contentLabel.text = [_userViewModel contentAtIndexPath:indexPath];
    //是否修改约束
    [cell setNeedsUpdateConstraints];
    //修改约束
    [cell updateConstraintsIfNeeded];
    //UILayoutFittingCompressedSize
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
