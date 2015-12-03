//
//  BusinessTableViewController.m
//  greenTeaLawyer
//
//  Created by Herron on 15/7/15.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BusinessTableViewController.h"
#import "BusinessAreaCellTableViewCell.h"

#define KBusinessAreaCellIdentifier @"businessCell"



@interface BusinessTableViewController ()

@property (nonatomic, copy) NSArray *businessAreaArray;

@end

@implementation BusinessTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.businessAreaArray = @[@"公司法律事务", @"银行与金融", @"公司收购、兼并与重组", @"房地产与建筑工程", @"知识产权", @"劳动争议", @"民商事合同诉讼与仲裁", @"刑事案件", @"证券与资本市场", @"私募股权与投资基金"];
    self.businessAreaArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J"];

    [self.tableView registerClass:[BusinessAreaCellTableViewCell class] forCellReuseIdentifier:KBusinessAreaCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.businessAreaArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KBusinessAreaCellIdentifier forIndexPath:indexPath];
    
    [cell.textLabel setText:[self.businessAreaArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate sendBusinessToCaseList:[self.businessAreaArray objectAtIndex:indexPath.row]];
    NSLog(@"1");

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
