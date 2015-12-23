//
//  AddViewController.m
//  SQlite
//
//  Created by 冯麟 on 15/12/19.
//  Copyright (c) 2015年 Lusyfa. All rights reserved.
//

#import "AddViewController.h"
#import "Student.h"
#import "SQlite.h"

@interface AddViewController ()

@end

@implementation AddViewController{
    UITextField * tf1;
    UITextField * tf2;
    UITextField * tf3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"添加学生信息";
    
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(60, 200, 50, 30)];
    name.text = @"姓名:";
    [self.view addSubview:name];
    
    tf1 = [[UITextField alloc]initWithFrame:CGRectMake(150, 200, 150, 30)];
    tf1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tf1];
    
    
    UILabel * age = [[UILabel alloc]initWithFrame:CGRectMake(60, 250, 50, 30)];
    age.text = @"年龄:";
    [self.view addSubview:age];
    tf2 = [[UITextField alloc]initWithFrame:CGRectMake(150, 250, 150, 30)];
    tf2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tf2];


    UILabel * sex = [[UILabel alloc]initWithFrame:CGRectMake(60, 300, 50, 30)];
    sex.text = @"性别:";
    [self.view addSubview:sex];
    tf3 = [[UITextField alloc]initWithFrame:CGRectMake(150, 300, 150, 30)];
    tf3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tf3];


    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    btn.frame = CGRectMake(160, 400, 50, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"添加" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];

    
    // Do any additional setup after loading the view.
}

-(void)save{
    
    Student * s = [[Student alloc]init];
    s.name = tf1.text;
    s.age = tf2.text;
    s.sex = tf3.text;
    
    [[SQlite shareDataBase]openDB];
    [[SQlite shareDataBase]addMesage:s];
    
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
