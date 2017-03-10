//
//  ViewController.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "ViewController.h"
#import "FJTimer.h"
#import "FJPhotoLibraryViewController.h"
#import "FJAlbumListViewController.h"
#import "ImageViewController.h"
#import "FJImageModel.h"
#import "FJPhotoMgr.h"
#import "FJDropSheet.h"
#import "SolidLine.h"
#import "HorizontalDotLine.h"
#import "VerticalDotLine.h"
#import "UIView+SVProgress.h"
#import "FJProgressView.h"
#import "NSObject+CRToast.h"
#import "UIView+PromptToast.h"
#import "TestViewController.h"
#import "UIView+DropSheet.h"
#import "FJContacts.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageDataArray;

@property (nonatomic, strong) FJTimer *fjTimer;
@property (nonatomic, weak) IBOutlet UILabel *lb_countdonw;
@property (nonatomic, weak) IBOutlet UIButton *btn_start;
@property (nonatomic, weak) IBOutlet UIButton *btn_stop;
@property (nonatomic, weak) IBOutlet UIButton *btn_pause;
@property (nonatomic, weak) IBOutlet UIButton *btn_resume;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 相机
    [self createUI];
    
    __weak typeof(self) weakSelf = self;
    
    // FJTimer
    FJTimer *timer = [[FJTimer alloc] initWithCoutdown:86460 interval:1 callback:^(int days, int hrs, int mins, int secs) {
        weakSelf.lb_countdonw.text = [NSString stringWithFormat:@"%d Days, %d Hours, %d minutes, %d seconds", days, hrs, mins, secs];
    }];
    
    self.fjTimer = timer;
    
    [self.btn_start addTarget:self action:@selector(tapStart) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_stop addTarget:self action:@selector(tapStop) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_pause addTarget:self action:@selector(tapPause) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_resume addTarget:self action:@selector(tapResume) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapStart {
    [self.fjTimer startTimer];
}

- (void)tapStop {
    [self.fjTimer endTimer];
}

- (void)tapPause {
    [self.fjTimer suspend];
}

- (void)tapResume {
    [self.fjTimer resume];
}

- (IBAction)clear:(id)sender {
    [self.imageDataArray removeAllObjects];
    [self.collectionView reloadData];
}

- (IBAction)presentAlbum:(id)sender {
    FJAlbumListViewController *albumListVC = [[FJAlbumListViewController alloc] init];
    albumListVC.maxSelectCount = 9;
    albumListVC.isAscend = YES;
    albumListVC.rightTitle = @"确定";
    
    __weak ViewController *weakSelf = self;
    
    albumListVC.okClickComplete = ^(NSArray<FJImageModel *> *images){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [images enumerateObjectsUsingBlock:^(FJImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.asset) {
                    [FJPhotoMgr getImageDataWithAsset:obj.asset complete:^(UIImage *image,UIImage*HDImage) {
                        if (image) {
                            [weakSelf.imageDataArray addObject:image];
                        }
                    }];
                    
                }else{
                    [weakSelf.imageDataArray addObject:obj.thumbImage];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.collectionView reloadData];
                });
                
            }];
        });
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:albumListVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)customeTap:(id)sender {
    // [self.view toast:@"Title" message:@"Message"];
    // [self.view toast:nil message:@"Message"];
    // [self CRToastTitle:@"Title" subTitle:@"Message"];
    
    /*
    FJProgressView *progressView = [[FJProgressView alloc] initWithFrame:CGRectMake(100, 100, 200, 10.0) backgroundColor:[UIColor whiteColor] progressTintColor:[UIColor blueColor] borderTintColor:[UIColor blackColor] borderStrokeWidth:@1.0];
    [self.view addSubview:progressView];
    [progressView setProgress:0.88 animated:YES];
    */
    
    /*
    [self.view startLoadingAnimation];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.view stopLoadingAnimation];
    });
    */
    
    [self.view dropSheet:@"This is a demo" tapBlock:^{
        NSLog(@"tapBlock");
    } cancelBlock:^{
        NSLog(@"cancelBlock");
    }];
    
    NSLog(@"hasContactsAccessRight:%ld",(long)[FJContacts getContactAuthorizationStatus]);
    
    [FJContacts getContacts:^(id contact) {
        NSLog(@"%@", contact);
    }];
}

- (IBAction)customTapLetf:(id)sender {
    TestViewController *testVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark - collectionView delegate &datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageDataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageDataArray[indexPath.row]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    cell.backgroundView = imageView;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    ImageViewController *imageVC = [[ImageViewController alloc] init];
    imageVC.clickedView = (UIImageView*)cell.backgroundView;
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (void)createUI{
    
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize =CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:collectionView];
        collectionView;
    });
}

- (NSMutableArray*)imageDataArray
{
    if (!_imageDataArray ) {
        _imageDataArray = [NSMutableArray array];
    }
    return _imageDataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
