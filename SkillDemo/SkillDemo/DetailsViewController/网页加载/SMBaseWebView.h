//
//  SMBaseWebView.h
//  Image
//
//  Created by pjw on 2021/3/5.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void (^headPersonBlock)(NSString *headIdStr,NSString *headNameStr);

NS_ASSUME_NONNULL_BEGIN

@interface SMBaseWebView : UIViewController

@property (nonatomic,copy) headPersonBlock headPersonBlock;

/**
 请求的url
 */
@property (nonatomic,copy) NSString *urlString;

/**
 要注入的js方法
 */
@property (nonatomic,copy) NSString *jsString;

/**
 富文本url
 */
@property (nonatomic,copy) NSString * richTextString;

/**
 进度条颜色
 */
@property (nonatomic,strong) UIColor *loadingProgressColor;

/**
 是否下拉重新加载
 */
@property (nonatomic, assign) BOOL canDownRefresh;

@property (nonatomic,strong) WKWebView *wkWebView;  //  WKWebView
@property (nonatomic,strong) UIProgressView *progress;  //进度条


@property (nonatomic,copy) NSString *codeString;//工单的code

/**
 
"customer_complain_flow"："客户投诉"
"customer_enquiry_flow"："客户问询"
"customer_repair_flow"："客户报修"
"zypgdlc"："资源派工单流程"
"zyjhgd"："资源计划工单"
"zyxcgd"："资源巡查工单"
*/

@property (nonatomic,copy) NSString *keyString;//工单的key


@property (nonatomic,copy) NSString *proInsId;

@property (nonatomic,copy) NSString *setTitle;


@end

NS_ASSUME_NONNULL_END
