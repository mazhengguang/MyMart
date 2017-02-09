#import <UIKit/UIKit.h>

@interface UIViewController (KSGuid)<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)  UIPageControl* control;
//@property (nonatomic,strong)   NSMutableArray * imgs;

//运行时的控制器，外部不用调用即可实现GuidView,可以修改下面的图片

@end

//这里是要展示的图片，修改即可
#define ImageArray @[@"欢迎页01-闲置交易",@"欢迎页02-义拍",@"欢迎页03-白送"]
