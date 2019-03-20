//
//  PayOrders.m
//  DSYDragTableView
//
//  Created by 邓石阳 on 2019/3/20.
//  Copyright © 2019 邓石阳. All rights reserved.
//

#import "PayOrders.h"

@implementation PayOrders


-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.name = [dic objectForKey:@"name"];
    }
    return self;
}

+(id)ordersWithDic:(NSDictionary *)dic
{
    PayOrders *payOrder = [[PayOrders alloc] initWithDic:dic];
    return payOrder;
}

@end
