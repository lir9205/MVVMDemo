//
//  LaunchTripViewController.m
//  
//
//  Created by 李芮 on 15/12/24.
//
//

#import "LaunchTripViewController.h"
#import "MADAnnounceCell.h"
#import "LaunchTripViewModel.h"

#define MAColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define kTABLEVIEW_BACKGROUND MAColor(238.0f, 238.0f, 243.0f, 1) //tableview背景色

static  NSString *announceCellIdentifier = @"announceCellIdentifier";
static  NSString *textfieldCellIdentifier = @"announceCellIdentifier";

@interface LaunchTripViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
//@property (nonatomic, strong) NSDictionary *contentdescs;

@end

@implementation LaunchTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布旅拍";
    self.view.backgroundColor = kTABLEVIEW_BACKGROUND;
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerClass:[MADAnnounceCell class] forCellReuseIdentifier:announceCellIdentifier];
    
    
    
}


#pragma mark - tableViewDataSource tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 5 : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    switch (indexPath.section) {
//        case 0:
//        {
            MADAnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier:announceCellIdentifier forIndexPath:indexPath];
            cell.textField.tag = indexPath.row;
            switch (indexPath.row) {
                case 0:
                    cell.textField.placeholder = _viewModel.theme;
                    break;
                case 1:
                    cell.textField.placeholder = _viewModel.time;
                    break;
                case 2:
                    cell.textField.placeholder = _viewModel.destination;
                    break;
                case 3:
                    cell.textField.placeholder = _viewModel.funds;
                    break;
                case 4:
                    cell.textField.placeholder = _viewModel.award;
                    break;
                default:
                    break;
            }
            [cell.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
            return cell;

//        }
//            break;
//            
//        default:
//            break;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.01 : 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return section == 0 ? @"" : section == 1 ? @"个人作品展示" : @"旅拍备注";
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        UIView * view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, self.view.frame.size.width - 16, 40)];
        label.text = section == 1 ? @"个人作品展示" : @"旅拍备注";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        return view;
    }else
        return nil;
}
- (void)textFieldValueChanged: (UITextField *)tf{    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tf.tag inSection:0];
    [_viewModel textFieldValueDidChanged:tf atIndexPath:indexPath];
}
- (void)save {
    NSMutableDictionary *requestDic = [_viewModel save];
    NSLog(@"requestDic:%@",requestDic);
}

@end
