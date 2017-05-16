//
//  FJRegionViewController.m
//  FJTool
//
//  Created by Jeff on 2017/5/16.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJRegionViewController.h"
#import "FJRegion.h"
#import "FJRegionModel.h"
#import <BlocksKit/BlocksKit+UIKit.h>
#import <Masonry/Masonry.h>

@interface FJRegionViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionDataSource;
@property (nonatomic, strong) NSArray *codeDataSource;
@property (nonatomic, strong) NSArray *nameDataSource;

@property (nonatomic,strong) NSMutableArray *searchResult;
@property (nonatomic,strong) NSMutableArray *searchDetailResult;
@property (nonatomic,strong) UITableView *searchTableView;
@property (nonatomic,strong) UIView *bgView;

@end

@implementation FJRegionViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"选择国家";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:NO];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0, 20.0)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn bk_addEventHandler:^(id sender) {
        [weakSelf dismissMySelf];
    } forControlEvents:UIControlEventTouchUpInside];
    
    // 准备数据
    [self loadData];
    
    // 准备UI
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    self.tableView.sectionIndexBackgroundColor = self.sectionIndexBackgroundColor != nil ? self.sectionIndexBackgroundColor : [UIColor clearColor];
    self.tableView.sectionIndexColor = self.sectionIndexColor != nil ? self.sectionIndexColor : [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (NSMutableArray *)searchResult
{
    if (_searchResult == nil) {
        _searchResult = [NSMutableArray array];
    }
    return _searchResult;
}

- (NSMutableArray *)searchDetailResult
{
    if (_searchDetailResult == nil) {
        _searchDetailResult = [NSMutableArray array];
    }
    return _searchDetailResult;
}

- (UITableView *)searchTableView
{
    if (_searchTableView == nil) {
        _searchTableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStylePlain];
        _searchTableView.dataSource = self;
        _searchTableView.delegate = self;
        _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.searchTableView];
        
    }
    return _searchTableView;
}

#pragma mark - hide search table view
- (void)hideSearchTableView
{
    self.searchTableView.hidden = YES;
    [self.searchResult removeAllObjects];
    [self.searchTableView reloadData];
}

#pragma mark - load data
- (void)loadData
{
    if (self.isHot == YES) {
        self.codeDataSource = [FJRegion hotCountryCodes];
        self.nameDataSource = [FJRegion hotCountries];
    }else{
        self.sectionDataSource = [FJRegion countrySections];
        self.codeDataSource = [FJRegion allCountryCodes];
        self.nameDataSource = [FJRegion allCountries];
    }
}

#pragma mark - delegate table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isHot == YES) {
        if (tableView == self.tableView) {
            return 1;
        }else{
            return 1;
        }
    }else{
        if (tableView == self.tableView) {
            return [self.sectionDataSource count];
        }else
        {
            return 1;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isHot == YES) {
        if (tableView == self.tableView) {
            return [self.nameDataSource count];
        }else{
            return self.searchResult.count;
        }
    }else{
        if (tableView == self.tableView) {
            return [(NSArray*)[self.nameDataSource objectAtIndex:section] count];
        }else
        {
            return self.searchResult.count;
        }
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellID = @"CountryTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UILabel *lb_regionCode = [[UILabel alloc] init];
        [cell addSubview:lb_regionCode];
        __weak typeof(cell) weakCell = cell;
        [lb_regionCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakCell.mas_centerY);
            make.right.equalTo(weakCell).offset(-20.0);
        }];
        lb_regionCode.backgroundColor = [UIColor clearColor];
        lb_regionCode.font = self.regionCodeFont != nil ? self.regionCodeFont : [UIFont systemFontOfSize:12.0];
        lb_regionCode.textColor = self.regionCodeColor != nil ? self.regionCodeColor : [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = self.regionTextFont != nil ? self.regionTextFont : [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = self.regionTextColor != nil ? self.regionTextColor : [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    }
    if (tableView == self.tableView) {
        if (self.isHot) {
            NSString *countryName = [self.nameDataSource objectAtIndex:indexPath.row];
            cell.textLabel.text = countryName;
            NSString *code = [self.codeDataSource objectAtIndex:indexPath.row];
            UILabel *lb_regionCode = [cell.subviews lastObject];
            lb_regionCode.text = [NSString stringWithFormat:@"+%@",code];
        }else{
            NSString *countryName = [[self.nameDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.textLabel.text = countryName;
            NSInteger index = 0;
            for (int i =0; i < indexPath.section; i++) {
                index += [(NSArray*)[self.nameDataSource objectAtIndex:i] count];
            }
            index += indexPath.row;
            UILabel *lb_regionCode = [cell.subviews lastObject];
            lb_regionCode.text = [NSString stringWithFormat:@"%@%@",@"+",[self.codeDataSource objectAtIndex:index]];
        }
        
        return cell;
    }else{
        NSString *countryName = [self.searchResult objectAtIndex:indexPath.row];
        cell.textLabel.text = countryName;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        UILabel *lb_regionCode = [cell.subviews lastObject];
        lb_regionCode.text = [NSString stringWithFormat:@"%@%@",@"+",self.searchDetailResult[indexPath.row]];
        return cell;
    }
}

// 自定义header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (self.isHot) {
        return nil;
    }else{
        
        static NSString * headerViewID = @"CountryHeaderViewID";
        UITableViewHeaderFooterView *customHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
        if (customHeaderView == nil) {
            
            customHeaderView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerViewID];
            customHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 24);
            UIView *backgroudnView = [[UIView alloc] initWithFrame:customHeaderView.bounds];
            backgroudnView.backgroundColor = self.sectionHeaderBackgroundColor != nil ? self.sectionHeaderBackgroundColor : [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
            [customHeaderView addSubview:backgroudnView];
            
            UILabel *lb_header = [[UILabel alloc] init];
            __weak typeof(customHeaderView) weakCustomHeaderView = customHeaderView;
            [customHeaderView addSubview:lb_header];
            [lb_header mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakCustomHeaderView.mas_centerY);
                make.left.equalTo(weakCustomHeaderView).offset(10.0);
            }];
            lb_header.textColor = self.sectionHeaderTextColor != nil ? self.sectionHeaderTextColor : [UIColor blackColor];
            lb_header.font = self.sectionHeaderTextFont != nil ? self.sectionHeaderTextFont : [UIFont systemFontOfSize:12.0];
            if (section == 0) {
                lb_header.text = @"热门国家";
            }else {
                lb_header.text = [self.sectionDataSource objectAtIndex:section];
            }
            [customHeaderView addSubview:lb_header];
        }
        return customHeaderView;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isHot == YES) {
        return nil;
    }else{
        
        if (tableView == self.tableView) {
            return [self.sectionDataSource objectAtIndex:section];
        }else
        {
            return nil;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isHot == YES) {
        return 0;
    }else{
        if (tableView == self.tableView) {
            
            return 24;
        }else
        {
            return 0;
        }
    }
}


- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isHot == YES) {
        return nil;
    }else{
        if (tableView == self.tableView) {
            
            return self.sectionDataSource;
        }else
        {
            return nil;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.isHot == YES) {
        return 0;
    }else{
        if (tableView == self.tableView) {
            
            return index;
        }else
        {
            return 0;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *regionCode = nil;
    NSString *regionName = nil;
    if (self.isHot == YES) {
        if (tableView == self.tableView) {
            
            regionCode = [self.codeDataSource objectAtIndex:indexPath.row];
            regionName = [self.nameDataSource objectAtIndex:indexPath.row];
        }
    }else{
        if (tableView == self.tableView) {
            
            NSInteger index = 0;
            for (int i =0; i < indexPath.section; i++) {
                index += [(NSArray*)[self.nameDataSource objectAtIndex:i] count];
            }
            index += indexPath.row;
            
            regionCode = [self.codeDataSource objectAtIndex:index];
            regionName = [[self.nameDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
        }else
        {
            regionCode = [self.searchDetailResult objectAtIndex:indexPath.row];
            regionName = [self.searchResult objectAtIndex:indexPath.row];
        }
    }
    
    if (self.selectCountryBlock != nil) {
        self.selectCountryBlock(regionCode, regionName);
    }
    [self dismissMySelf];
}

- (void)dismissMySelf {
    if (self.navigationController) {
        if ([self.navigationController.viewControllers count] == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
