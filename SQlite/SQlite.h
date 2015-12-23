//
//  SQlite.h
//  SQlite
//
//  Created by 冯麟 on 15/12/19.
//  Copyright (c) 2015年 Lusyfa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;

@interface SQlite : NSObject

+(instancetype)shareDataBase;

-(void)openDB;
-(void)addMesage:(Student *)model;
-(void)deleteDB:(int) num;
-(void)editDB:(Student *)model;
-(NSArray *)getDB;

@end
