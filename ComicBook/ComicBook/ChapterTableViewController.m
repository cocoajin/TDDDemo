//
//  ChapterTableViewController.m
//  ComicBook
//
//  Created by jinkeke@techshino.com on 15/3/17.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import "ChapterTableViewController.h"
#import "SVHTTPRequest.h"
#import "PageViewController.h"

@interface ChapterTableViewController ()

@end

@implementation ChapterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chapter";
    _chapImageArray = [[NSMutableArray alloc]initWithCapacity:1];
    self.tableView.rowHeight = 95;
    [self getChapData];
}

- (void)getChapData
{
    NSString *chapAPI = @"http://test4.ishuhui.net/ComicBooks/GetChapter";
    [SVHTTPRequest GET:chapAPI parameters:[NSDictionary dictionaryWithObject:self.chapID forKey:@"id"] completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (error) {
            [self alertTextWith:[error localizedDescription]];
        }
        else
        {
            //NSLog(@"%@",response);
            [_chapImageArray removeAllObjects];
            NSDictionary *jsonDic = [NSDictionary dictionaryWithDictionary:response];
            [_chapImageArray addObjectsFromArray:[[jsonDic objectForKey:@"Return"] objectForKey:@"Images"]];
            [self.tableView reloadData];
            
            if ([_chapImageArray count]==0) {
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
    NSDictionary *oneDic = [_chapImageArray objectAtIndex:indexPath.row];
    PageViewController *pageVC = [PageViewController new];
    pageVC.imgUrl = oneDic[@"Url"];
    [self.navigationController pushViewController:pageVC animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_chapImageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *oneDic = [_chapImageArray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"[%ld]  %@",indexPath.row+1,oneDic[@"Url"]];
    
    return cell;
}

@end
