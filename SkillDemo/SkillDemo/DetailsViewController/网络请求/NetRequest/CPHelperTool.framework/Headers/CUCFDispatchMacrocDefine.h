//
//  CUCFDispatchMacrocDefine.h
//  CatPaw
//
//  Created by lk on 2017/6/19.
//  Copyright © 2017年 lk. All rights reserved.
//

/**
 *  文件描述
 *
 *  这个工具类宏可以方便在各种队列中执行block,提供便捷的使用方法
 *  是对GCD的一个简单封装
 */

#import "CUCFDispatchCenterUitil.h"

/**
 *  主线程异步执行block
 */
#define CUCFAsyncMainQueue(block) [CUCFDispatchCenterUitil asyncMainQueue:block]

/**
 *  主线程延迟second秒异步执行block
 */
#define CUCFAsyncMainQueueDelay(second,block) [CUCFDispatchCenterUitil asyncMainQueue:block delay:second]

/**
 *  全局后台线程异步执行block
 */
#define CUCFAsyncGlobalBackgroundQueue(block) [CUCFDispatchCenterUitil asyncGlobalBackgroundQueue:block]

/**
 *  全局后台线程延迟second秒异步执行block
 */
#define CUCFAsyncGlobalBackgroundQueueDelay(second,block) [CUCFDispatchCenterUitil asyncGlobalBackgroundQueue:block delay:second]

/**
 *  全局高优先级线程异步执行block
 */
#define CUCFAsyncGlobalHighQueue(block) [CUCFDispatchCenterUitil asyncGlobalHighQueue:block]

/**
 *  全局高优先级线程延迟second秒异步执行block
 */
#define CUCFAsyncGlobalHighQueueDelay(second,block) [CUCFDispatchCenterUitil asyncGlobalHighQueue:block delay:second]

/**
 *  全局低优先级线程异步执行block
 */
#define CUCFAsyncGlobalLowQueue(block) [CUCFDispatchCenterUitil asyncGlobalLowQueue:block]

/**
 *  全局低优先级线程延迟second秒异步执行block
 */
#define CUCFAsyncGlobalLowQueueDelay(second,block) [CUCFDispatchCenterUitil asyncGlobalLowQueue:block delay:second]

/**
 *  全局默认线程异步执行block
 */
#define CUCFAsyncGlobalDefaultQueue(block) [CUCFDispatchCenterUitil asyncGlobalDefaultQueue:block]

/**
 *  全局默认线程延迟second秒异步执行block
 */
#define CUCFAsyncGlobalDefaultQueueDelay(second,block) [CUCFDispatchCenterUitil asyncGlobalDefaultQueue:block delay:second]

/**
 *  在queue线程队列异步执行block
 */
#define CUCFAsync(queue,block)  [CUCFDispatchCenterUitil asyncQueue:queue action:block]

/**
 *  在queue线程序延迟second秒异步执行block
 */
#define CUCFAsyncDelay(queue,second,block)  [CUCFDispatchCenterUitil asyncQueue:queue action:block delay:second]

/**
 *  只执行一次block,创建单例使用
 */
#define CUCFDispatchOnce(onceToken,block) [CUCFDispatchCenterUitil dispatchOnce:onceToken action:block]

/**
 *  主线程异步
 */
#define CUCFAsyncMainThread(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
/**
 *  全局异步执行
 */
#define CUCFAsyncOpenGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
