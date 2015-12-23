//
//  ViewController.m
//  SQlite
//
//  Created by 冯麟 on 15/12/19.
//  Copyright (c) 2015年 Lusyfa. All rights reserved.
//

#import "ViewController.h"
#import "SQlite.h"
#import "AddViewController.h"
#import "Student.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController{
    UITableView * table;
    NSArray * arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"学生信息";
    NSLog(@"呵呵");
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(right)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    table = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)right{

    AddViewController * add = [[AddViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * idcell = @"FL";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idcell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:idcell];
    }
    
    Student * student = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = student.name;
    cell.detailTextLabel.text = student.age;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
