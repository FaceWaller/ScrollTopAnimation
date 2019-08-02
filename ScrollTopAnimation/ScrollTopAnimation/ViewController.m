//
//  ViewController.m
//  吸顶动画
//
//  Created by jpz on 2019/8/1.
//  Copyright © 2019 jpz. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

static CGFloat navHeight = 60;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIView *navView;
@property(nonatomic,weak)UIImageView *iconView;
@property(nonatomic,weak)UIImageView *animationIconView;
@property(nonatomic,assign)CGFloat iconBeginY;

@property(nonatomic,weak)UIButton *followBtn;
@property(nonatomic,weak)UIButton *animationFollowBtn;
@property(nonatomic,assign)CGFloat followBeginY;
@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,assign)CGFloat iconMinY;
@property(nonatomic,assign)CGFloat followMinY;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSubviews];
    
    [self.tableView reloadData];
    [self.view layoutIfNeeded];
    [self.tableView layoutIfNeeded];
    
    [self addAnimationIconView];
    [self addAnimationFollowBtn];
}

- (void)setupSubviews {
    self.view.backgroundColor = [UIColor colorWithRed:127/255.f green:227/255.f blue:240/255.f alpha:1];
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, navHeight + [UIApplication sharedApplication].statusBarFrame.size.height)];
    self.navView = navView;
    navView.backgroundColor = [UIColor colorWithRed:175/255.f green:219/255.f blue:228/255.f alpha:1];
    navView.alpha = 0.f;
    [self.view addSubview:navView];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(navView.mas_bottom);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectZero];
    headerView.backgroundColor = [UIColor colorWithRed:127/255.f green:227/255.f blue:240/255.f alpha:1];
    
    UIImageView *iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    iconView.layer.cornerRadius = 25.f;
    iconView.layer.masksToBounds = YES;
    iconView.image = [UIImage imageNamed:@"icon"];
    [headerView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
        make.width.height.equalTo(@50);
    }];
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = UIColor.whiteColor;
    textLabel.font = [UIFont systemFontOfSize:18.f];
    textLabel.text = @"FaceWaller";
    [headerView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(10);
        make.centerY.equalTo(iconView.mas_centerY);
    }];
    
    UILabel *followLabel = [[UILabel alloc]init];
    followLabel.textColor = UIColor.whiteColor;
    followLabel.text = @"关注数:100";
    followLabel.font = [UIFont systemFontOfSize:12.f];
    [headerView addSubview:followLabel];
    [followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView);
        make.top.equalTo(iconView.mas_bottom).offset(10);
    }];
    
    UILabel *infoLabel = [[UILabel alloc]init];
    infoLabel.textColor = UIColor.whiteColor;
    infoLabel.text = @"一句话介绍自己!";
    infoLabel.font = [UIFont systemFontOfSize:14.f];
    [headerView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(followLabel);
        make.top.equalTo(followLabel.mas_bottom).offset(10);
    }];
    
    UIButton * followBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 80, 60, 20)];
    [followBtn setTitle:@"关注" forState:UIControlStateNormal];
    followBtn.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:247/255.f alpha:1];
    [followBtn setTitleColor:[UIColor colorWithRed:33/255.f green:196/255.f blue:255/255.f alpha:1] forState:UIControlStateNormal];
    followBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    followBtn.layer.cornerRadius = 10.f;
    [followBtn.layer masksToBounds];
    [headerView addSubview:followBtn];
    self.followBtn = followBtn;
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)addAnimationIconView {
    self.iconView.hidden = YES;
    if (self.animationIconView) return;
    UIImageView *animationIconView = [[UIImageView alloc]init];
    self.animationIconView = animationIconView;
    animationIconView.layer.cornerRadius = self.iconView.layer.cornerRadius;
    animationIconView.layer.masksToBounds = self.iconView.layer.masksToBounds;
    animationIconView.image =self.iconView.image;
    [self.view addSubview:animationIconView];
    CGRect newFrame = [self.view convertRect:self.iconView.frame fromView:self.tableView];
    animationIconView.frame = newFrame;
    self.iconBeginY = newFrame.origin.y;
    self.iconMinY = (navHeight - newFrame.size.height)/2 + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (void)addAnimationFollowBtn {
    self.followBtn.hidden = YES;
    if (self.animationFollowBtn) return;
    UIButton *animationFollowBtn = [[UIButton alloc]init];
    self.animationFollowBtn = animationFollowBtn;
    animationFollowBtn.layer.cornerRadius = self.followBtn.layer.cornerRadius;
    [animationFollowBtn setTitleColor:self.followBtn.currentTitleColor forState:UIControlStateNormal];
    animationFollowBtn.backgroundColor = self.followBtn.backgroundColor;
    [animationFollowBtn setTitle:self.followBtn.titleLabel.text forState:UIControlStateNormal];
    animationFollowBtn.titleLabel.font = self.followBtn.titleLabel.font;
    [self.view addSubview:animationFollowBtn];
    CGRect newFrame = [self.view convertRect:self.followBtn.frame fromView:self.tableView];
    animationFollowBtn.frame = newFrame;
    self.followBeginY = newFrame.origin.y;
    self.followMinY = (navHeight - newFrame.size.height)/2 + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect iconFrame = self.animationIconView.frame;
    CGFloat newIconY = self.iconBeginY - scrollView.contentOffset.y;
    if (newIconY < self.iconMinY) {
        newIconY = self.iconMinY;
    }
    iconFrame.origin.y = newIconY;
    self.animationIconView.frame = iconFrame;
    
    
    CGRect followBtnFrame = self.animationFollowBtn.frame;
    CGFloat newFollowBtnY = self.followBeginY - scrollView.contentOffset.y;
    if (newFollowBtnY < self.followMinY) {
        newFollowBtnY = self.followMinY;
    }
    followBtnFrame.origin.y = newFollowBtnY;
    self.animationFollowBtn.frame = followBtnFrame;
    
    CGFloat alpha = scrollView.contentOffset.y / (self.iconBeginY - self.iconMinY);
    self.navView.alpha = alpha;
}

@end
