#import "UIViewController+KSGuid.h"
#import <objc/runtime.h>
#import "UIView+Extension.h"

#define CollectionView_Tag 1500
#define RemoveBtn_tag 1600
#define Control_tag 1700

#define FIRST_IN_KEY @"FIRST_IN_KEY"

@interface KSGuidViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, strong) UIImageView* imageView;
@end
@implementation KSGuidViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;
}
- (void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        _imageName = [imageName copy];
    }
    _imageView.image = [UIImage imageNamed:imageName];
}
@end

/************************以上是KSGuidViewCell,以下才是UIViewController+KSGuid******************************/
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";
static void * MyObjectMyCustomPorpertyKey1 = (void *)@"MyObjectMyCustomPorpertyKey1";


@implementation UIViewController (KSGuid)


- (UIPageControl *)control {
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey);
}

- (void)setControl:(UIPageControl *)control{
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey, control, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//- (NSMutableArray *)imgs {
//    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey1);
//}
//
//- (void)setImgs:(NSMutableArray *)imgs {
//    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey1, imgs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

#pragma mark-
#pragma mark 这里填充图片的名称
- (NSArray<NSString*>*)imageArray{
    return ImageArray;
}

#pragma mark-
#pragma mark 这里是退出的按钮
- (UIButton*)removeBtn{
    //移除按钮样式
    UIButton* removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat btnW = 60;
    CGFloat btnH = 60;
    CGFloat btnX = CGRectGetMidX(self.view.frame) - btnW / 2;
    CGFloat btnY = CGRectGetMaxY(self.view.frame) - 100;
    removeBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    removeBtn.backgroundColor = RGB(87, 210, 210);
    [removeBtn setImage:[UIImage imageNamed:@"go"] forState:UIControlStateNormal];
    removeBtn.layer.cornerRadius = btnH / 2;
    //    removeBtn.layer.borderColor = [UIColor colorWithRed:32./255. green:210./255. blue:245./255. alpha:1.].CGColor;
    //    removeBtn.layer.borderWidth = 1.;
    //
    //    [removeBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    //    [removeBtn setTitleColor:[UIColor colorWithRed:32./255. green:210./255. blue:245./255. alpha:1.] forState:UIControlStateNormal];
    //    removeBtn.titleLabel.font = [UIFont systemFontOfSize:20.];
    
    [removeBtn addTarget:self action:@selector(removeGuidView) forControlEvents:UIControlEventTouchUpInside];
    
    removeBtn.hidden = (self.imageArray.count != 1);
    
    removeBtn.tag = RemoveBtn_tag;      //注意这里的tag
    
    return removeBtn;
}

+ (void)load{
    
    NSString* versoin = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString* versionCache = [[NSUserDefaults standardUserDefaults] objectForKey:FIRST_IN_KEY];
    //启动时候首先判断是不是第一次
    
    if ([versoin isEqualToString:versionCache]) {
        return;
    }
    
    //以下代码只在程序安装初次运行时候执行
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method1 = class_getInstanceMethod(self.class, @selector(viewDidLoad));
        Method method2 = class_getInstanceMethod(self.class, @selector(guidViewDidLoad));
        
        BOOL didAddMethod =
        class_addMethod(self.class,
                        @selector(viewDidLoad),
                        method_getImplementation(method2),
                        method_getTypeEncoding(method2));
        
        if (didAddMethod) {
            class_replaceMethod(self.class,
                                @selector(guidViewDidLoad),
                                method_getImplementation(method1),
                                method_getTypeEncoding(method1));
        } else {
            method_exchangeImplementations(method1, method2);
        }
    });
}

- (void)guidViewDidLoad{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这里的代码只在程序安装初次打开，并且在第一个控制器里面执行
        //初始化视图
        [self setupSubViews];
    });
    
    //这是调用工程里面的viewDidLoad
    [self guidViewDidLoad];
}

#pragma mark-
#pragma mark 初始化视图

- (void)setupSubViews{
    
    //界面样式
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView* collectionView = [[UICollectionView alloc]
                                        initWithFrame:self.view.bounds
                                        collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[KSGuidViewCell class] forCellWithReuseIdentifier:@"KSGuidViewCell"];
    
    collectionView.tag = CollectionView_Tag;
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.removeBtn];
    
    UIPageControl* control = [[UIPageControl alloc] init];
    CGFloat controlW = 170;
    CGFloat controlH = 20;
    CGFloat controlX = CGRectGetMidX(self.view.frame) - controlW / 2;
    CGFloat controlY = CGRectGetMaxY(self.view.frame) - 38;
    control.frame = CGRectMake(controlX, controlY, controlW, controlH);
    control.numberOfPages = self.imageArray.count;
    control.pageIndicatorTintColor = RGB(150, 234, 232);
    //[UIColor colorWithRed:234./255. green:234./255. blue:234./255. alpha:1.];
    control.currentPageIndicatorTintColor = [UIColor whiteColor  ];
    //[UIColor colorWithRed:125./255. green:153./255. blue:255./255. alpha:1.];
    control.tag = Control_tag;
    [self.view addSubview:control];
    self.control = control;
}

#pragma mark-
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KSGuidViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSGuidViewCell" forIndexPath:indexPath];
    cell.imageName = self.imageArray[indexPath.row];
    
    return cell;
}
//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
    [self.view viewWithTag:RemoveBtn_tag].hidden = (index != self.imageArray.count - 1);
    
    UIPageControl* control =[self.view viewWithTag:Control_tag];
    control.currentPage = index;
    
}

- (void)removeGuidView{
    
    NSString* versoin = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [[NSUserDefaults standardUserDefaults] setObject:versoin forKey:FIRST_IN_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[self.view viewWithTag:Control_tag] removeFromSuperview];
    [[self.view viewWithTag:RemoveBtn_tag] removeFromSuperview];
    [[self.view viewWithTag:CollectionView_Tag] removeFromSuperview];
}


@end
