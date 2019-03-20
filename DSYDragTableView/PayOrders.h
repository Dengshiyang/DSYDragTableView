//
//  PayOrders.h
//  DSYDragTableView
//
//  Created by 邓石阳 on 2019/3/20.
//  Copyright © 2019 邓石阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayOrders : NSObject

@property (nonatomic, copy) NSString *name;


-(id)initWithDic:(NSDictionary*)dic;
+(id)ordersWithDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
