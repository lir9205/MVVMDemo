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
#import "MARTextfieldCell.h"
#import "HUAddSportViewController.h"
#import "MADPickImageView.h"
//#import "ZLPicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Extension.h"

#define MAColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define kTABLEVIEW_BACKGROUND MAColor(238.0f, 238.0f, 243.0f, 1) //tableview背景色

static  NSString *announceCellIdentifier = @"announceCellIdentifier";
static  NSString *textfieldCellIdentifier = @"textfieldCellIdentifier";

@interface LaunchTripViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,MADPickImageViewDidTapImageDelegate>
{
    NSMutableArray *_images;
    NSArray *_HDimages;
    NSMutableArray *_imageDatas;
    NSMutableArray *_HDimageDatas;
    NSMutableArray *_imageNames;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) MADPickImageView *pickerImageView;
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
    //self.tableView.allowsSelection = NO;
    
    [self.tableView registerClass:[MADAnnounceCell class] forCellReuseIdentifier:announceCellIdentifier];
    [self.tableView registerClass:[MARTextfieldCell class] forCellReuseIdentifier:textfieldCellIdentifier];
    
    
}


#pragma mark - tableViewDataSource tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 5 : section == 1 ? 0 : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            MADAnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier:announceCellIdentifier forIndexPath:indexPath];
            [self configCell:cell atIndexPath:indexPath];
            return cell;
            
        }
            break;
        case 1:
        case 2:
        {
            MARTextfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textfieldCellIdentifier forIndexPath:indexPath];
            [self configCell:cell atIndexPath:indexPath];
            return cell;
        }
            
    }
    return nil;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        MADAnnounceCell *newCell = (MADAnnounceCell *)cell;
        newCell.textField.tag = indexPath.row;
        newCell.textField.placeholder = [_viewModel placeholderForRow:indexPath.row inSection:indexPath.section];
        if (indexPath.row == 4)    newCell.textField.enabled = NO;
        [newCell.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }else if (indexPath.section == 2) {
        MARTextfieldCell *newCell = (MARTextfieldCell *)cell;
        newCell.placeholder = [_viewModel placeholderForRow:indexPath.row inSection:indexPath.section];
        newCell.shouleMutableTextView = YES;
        newCell.textField.enabled =  NO;
        newCell.textView.delegate = self;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 50 : 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.01 : 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? 100 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [[UIView alloc] init];
    
    UIView * view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, [UIScreen mainScreen].bounds.size.width - 16, 40)];
    label.text = [_viewModel titleForHeaderInSection:section];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    return view;
   
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 2) return [[UIView alloc] init];
    
    MADPickImageView *picker = [[MADPickImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    [picker addTarget:self action:@selector(pickImages)];
    picker.images = nil;
    picker.delegate = self;
    self.pickerImageView = picker;
    return picker;
}

- (void)pickImages {
//    ZLPickerViewController *pickerVc = [[ZLPickerViewController alloc] init];
//    // 默认显示相册里面的内容SavePhotos
//    pickerVc.status = PickerViewShowStatusCameraRoll;
//    // 选择图片的最大数
//    pickerVc.minCount = 6;
//    pickerVc.delegate = self;
//    [pickerVc show];
    
}


#pragma mark - ZLPickerViewController delegate

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    //[SVProgressHUD dismiss];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:assets.count];
    _imageDatas = [NSMutableArray arrayWithCapacity:assets.count];
    _HDimages = [NSMutableArray arrayWithCapacity:assets.count];
    _images = [NSMutableArray arrayWithCapacity:assets.count];
    _imageNames = [NSMutableArray arrayWithCapacity:assets.count];
    _HDimageDatas = [NSMutableArray arrayWithCapacity:assets.count];
    
    for (NSInteger i=0; i<assets.count; i++) {
        ALAsset *asset = assets[i];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [images addObject:image];
        
        CGImageRef thum1 =[assets[i] thumbnail];
        UIImage *normalImage = [UIImage imageWithCGImage:thum1];
        [_images addObject:normalImage];
        
        
        NSData *hdImage = UIImageJPEGRepresentation([image fixOrientation], 1);
        if (hdImage.length > 800) {
            hdImage = UIImageJPEGRepresentation([image fixOrientation], 0.1);
        }
        [_HDimageDatas addObject:hdImage]; //高清图
        
        NSData *imageData = [image imageByScalingAndCroppingForSize:CGSizeMake(270*2, 200*2) withMaxLength:200];
        [_imageDatas addObject:imageData];
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:[NSString stringWithFormat:@"yyMMddHHmmss"]];
        [_imageNames addObject:[NSString stringWithFormat:@"%@_%zd", [formatter stringFromDate:date],i]];
        
        //NSLog(@"iamge: %zd, hd: %zd", imageData.length, hdImage.length);
    }
    
    //    self.pickerImageView.images = images;
    _HDimages = images;
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark UItextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [_viewModel textViewValueDidChanged:textView.text];
}

- (void)textFieldValueChanged: (UITextField *)tf{
    [_viewModel textFieldValueDidChanged:tf.text forRow:tf.tag inSection:0];
}

- (void)save {
    NSMutableDictionary *requestDic = [_viewModel save];
    NSLog(@"requestDic:%@",requestDic);
    
    //清空数据库
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 4) {
        HUAddSportViewController *vc = [[HUAddSportViewController alloc] initWithViewModel:self.viewModel.userViewModel];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
