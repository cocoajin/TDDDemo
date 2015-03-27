//
//  BookListTableViewController.m
//  ComicBook
//
//  Created by jinkeke@techshino.com on 15/3/17.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import "BookListTableViewController.h"
#import "SVHTTPRequest.h"
#import "ChapterListTableViewController.h"

@interface BookListTableViewController ()

@end

@implementation BookListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Book List";
    _listDataArray = [[NSMutableArray alloc] initWithCapacity:1];
    [self getListData];
    

}

- (void)getListData{
    NSString *listApi = @"http://test4.ishuhui.net/ComicBooks/GetAllBook";
    [SVHTTPRequest GET:listApi parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (error) {
            [self alertTextWith:[error localizedDescription]];
        }
        else
        {
            //NSLog(@"%@",response);
            [_listDataArray removeAllObjects];
            NSDictionary *jsonDic = [NSDictionary dictionaryWithDictionary:response];
            [_listDataArray addObjectsFromArray:[[jsonDic objectForKey:@"Return"] objectForKey:@"List"]];
            [self.tableView reloadData];
            
            if ([_listDataArray count]==0) {
                [self alertTextWith:@"列表为空！"];
            }
        }
        
    }];
}

- (void)alertTextWith:(NSString *)text
{
    UIAlertView *alertText = [[UIAlertView alloc]initWithTitle:nil message:text delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertText show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *oneDic = [_listDataArray objectAtIndex:indexPath.row];
    ChapterListTableViewController *chapList = [ChapterListTableViewController new];
    chapList.bookID = oneDic[@"Id"];
    [self.navigationController pushViewController:chapList animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_listDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *oneDic = [_listDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = oneDic[@"Title"];
    cell.detailTextLabel.text = oneDic[@"Explain"];
    
    
    return cell;
}


@end
