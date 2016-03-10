//
//  ShouCangViewController.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "ShouCangViewController.h"
#import "ShouCangTableViewCell.h"
#import "Shoucang.h"
#import "Model.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShouCangViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *array;


@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self backBtn];
    self.navigationController.navigationBar.barTintColor = mainColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"收藏";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.rowHeight = 120;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Shoucang *cang = [Shoucang sharedInstance];
    self.array = [NSMutableArray new];
    self.array  = [cang select];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouCangTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShouCangTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];

    Model *model = self.array[indexPath.row];
    cell.title.text = model.title;
    cell.subTitle.text = model.subTitle;
    [cell.imagetop sd_setImageWithURL:[NSURL URLWithString:model.Titleimage] placeholderImage:nil];
    
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
