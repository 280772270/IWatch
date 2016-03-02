//
//  messageViewController.m
//  I Watch
//
//  Created by 陈萍 on 15/11/2.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "messageViewController.h"
#import "AFNetworking.h"
//#import "videoModel.h"
#import "UIImageView+WebCache.h"
#import "MovieViewController.h"
#define screenFrame [UIScreen mainScreen].bounds
@interface messageViewController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)CGRect cutFrame;
@property(nonatomic,assign)CGPoint cent;
@property(nonatomic,strong)NSDictionary *playInfoDic;
@property(nonatomic,strong)UILabel *shoucangLabel;
@property(nonatomic,assign)BOOL isShoucang;
@property(nonatomic,assign)BOOL isShared;
@property(nonatomic,assign)double shoucangCount;
@property(nonatomic,assign)double sharedCount;
@property(nonatomic,strong)UIImage *shoucangImage;
@property(nonatomic,strong)UIButton *shoucangButton;
@end

@implementation messageViewController

-(void)loadView{
    [super loadView];
    
    [self allFrame];
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor cyanColor];
//    self.dataArr = [NSMutableArray new];
    _isShared = 0;
    _isShoucang = 0;
    
    // Do any additional setup after loading the view from its nib.
}


-(void)allFrame{
    //高斯效果视图
    UIImageView *blurimage  =[[UIImageView alloc] initWithFrame:CGRectMake(0, screenFrame.size.height - 264, screenFrame.size.width, 200)];
    [self.view addSubview:blurimage];
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.width, 200)];
    blurimage.userInteractionEnabled = YES;
    blurView.backgroundColor = [UIColor blackColor];
    blurView.alpha = 0.65;
    [blurimage addSubview:blurView];
    //视频视图
    UIImageView *MVview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height - 200)];
    //按比例调整大小 UIImage 然后裁剪
    MVview.clipsToBounds = YES;
    [MVview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    MVview.contentMode =  UIViewContentModeScaleAspectFill;
    MVview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //MVview.frame = CGRectMake(0, 0, screenFrame.size.width, 160*screenFrame.size.width/320);
    MVview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:MVview];
    //播放按钮视图
    UIView *bofangButtonView = [[UIView alloc] init];
    bofangButtonView.backgroundColor = [UIColor clearColor];
    [MVview addSubview:bofangButtonView];
    //播放button
    UIButton *bofangButton = [[UIButton alloc] init];
    bofangButton.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height - 264);
    //bofangButton.center = MVview.center;
    //[bofangButton setBackgroundImage:[UIImage imageNamed:@"播放.png"]  forState:UIControlStateNormal];
//    [bofangButton setImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
//    bofangButton.backgroundColor = [UIColor clearColor];
    UIImage *oii = [UIImage imageNamed:@"播放大.png"];
    CGSize size = CGSizeMake(64, 64);
    UIImageView *bofangImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    bofangImage.image = oii;
    bofangImage.center = CGPointMake(screenFrame.size.width/2, (screenFrame.size.height - 264)/2);
    [bofangButton addSubview:bofangImage];
    [bofangButton addTarget:self action:@selector(bofangButtonBackGroundHighlighted:) forControlEvents:UIControlEventTouchUpInside];
    
    //[bofangButtonView addSubview:bofangButton];
    [self.view addSubview:bofangButton];
    //视频主题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, screenFrame.size.width - 10, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.text = @"哈哈";
    [blurView addSubview:titleLabel];
    //分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, screenFrame.size.width - 120, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [blurView addSubview:line];
    
    //种类label
    UILabel *kindLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 45, 25)];
    kindLabel.text = @"#种类";
    kindLabel.font = [UIFont systemFontOfSize:14];
    kindLabel.textColor = [UIColor whiteColor];
    [blurView addSubview: kindLabel];
    //侧分割线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, 5, 25)];
    lineLabel.text = @"/";
    lineLabel.font = [UIFont systemFontOfSize:14];
    lineLabel.textColor = [UIColor whiteColor];
    [blurView addSubview:lineLabel];
    //时间label
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 40, 45, 25)];
    timeLabel.text = @"00'00\"";
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor whiteColor];
    [blurView addSubview:timeLabel];
    //描述label
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 70, screenFrame.size.width - 10, 65)];
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:13];
//    detailLabel.text = @"asdasdasdasdadasdasgdfgsgsfsdfsdgdadfgbsdffsbddggdsdfdhsdfvdbhfghsfgdfhfghsfdgdhdfgfdssshfngfdkasuhdkhsdckhakusdhaiuhgiusdhgfishifghsidfhihsfishgdfiahgdifghsidufgisu";
    detailLabel.backgroundColor = [UIColor blackColor];
    detailLabel.textColor = [UIColor grayColor];
    //收藏button
    _shoucangButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 150, 25, 25)];
    _shoucangImage = [UIImage imageNamed:@"未收藏.png"];
    [_shoucangButton setBackgroundImage:_shoucangImage forState:UIControlStateNormal];
    [_shoucangButton addTarget:self action:@selector(shoucanButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_shoucangButton setShowsTouchWhenHighlighted:1];
    _sharedCount = _model.consumption.shareCount;
//    [shoucangButton addTarget:self action:@selector(shoucanButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [blurView addSubview:_shoucangButton];
    //收藏label
    _shoucangLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 150, 50, 25)];
    _shoucangLabel.font = [UIFont systemFontOfSize:13];
    _shoucangLabel.textColor = [UIColor whiteColor];
    _shoucangCount = [self.playInfoDic[@"collectionCount"] doubleValue];
    _shoucangCount = _model.consumption.collectionCount;
    _shoucangLabel.text = [NSString stringWithFormat:@"%.0f", _shoucangCount];
    [blurView addSubview:_shoucangLabel];
    //上传button
    UIButton *shangchuanButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 25, 25)];
    [shangchuanButton setBackgroundImage:[UIImage imageNamed:@"上传.png"] forState:UIControlStateNormal];
    [shangchuanButton setShowsTouchWhenHighlighted:1];
    [shangchuanButton setUserInteractionEnabled:0];
    [blurView addSubview:shangchuanButton];
    //上传label
    UILabel *shangchuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 150, 35, 25)];
    shangchuanLabel.font = [UIFont systemFontOfSize:13];
    shangchuanLabel.textColor = [UIColor whiteColor];
    
    shangchuanLabel.text = [NSString stringWithFormat:@"%.0f",_sharedCount];
    [blurView addSubview:shangchuanLabel];
    //下载button
    UIButton *xiazaiButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 150, 25, 25)];
    [xiazaiButton setBackgroundImage:[UIImage imageNamed:@"下载1.png"] forState:UIControlStateNormal];
//    [xiazaiButton addTarget:self action:@selector(xiazai:) forControlEvents:UIControlEventTouchUpInside];
    //xiazaiButton.backgroundColor = [UIColor redColor];
//    [ setShowsTouchWhenHighlighted:1];
    //下载Label
    UILabel *xiazaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 150, 35, 25)];
    xiazaiLabel.font = [UIFont systemFontOfSize:13];
    xiazaiLabel.textColor = [UIColor whiteColor];
    xiazaiLabel.text = [NSString stringWithFormat:@"缓存"];
//    [blurView addSubview:xiazaiLabel];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back.png" target:self action:@selector(leftMenuClick:)];
    
    
    //初始化控件
    
//    _model = [[ZZVideoList alloc]init];
//    _model = self.dataArr[3];
    titleLabel.text = _model.title;
    kindLabel.text = _model.category;
    timeLabel.text = [self getTime:_model.duration ];
    detailLabel.text = _model.videoListDescription;
    //裁剪的小View
    UIImageView *cutView = [[UIImageView alloc]init];
    [cutView sd_setImageWithURL:[NSURL URLWithString:_model.coverForDetail]];
    
    [blurimage sd_setImageWithURL:[NSURL URLWithString:_model.coverBlurred]];
    self.cutFrame = MVview.frame;
    self.cent = MVview.center;
    cutView = [self imageWithImageView:cutView scaledToSize:self.cutFrame.size];
    CGPoint poin = CGPointMake(MVview.center.x, MVview.frame.origin.y + cutView.frame.size.height/2 - 64 );
    cutView.center = poin;
    //[MVview addSubview:cutView];
    
    [MVview sd_setImageWithURL: [NSURL URLWithString:_model.coverForDetail] ];
    
    
    [blurView addSubview:detailLabel];
//    [blurView addSubview:xiazaiButton];

    
}

-(void)shoucanButtonDidClicked:(UIButton *)sender
{
    [sender setShowsTouchWhenHighlighted:1];
    if (!_isShoucang) {
        _shoucangCount++;
        NSString *shoucangText = [NSString stringWithFormat:@"%.0f",_shoucangCount];
        _shoucangLabel.text = [NSString stringWithFormat:@"%@", shoucangText];
        _shoucangImage = [UIImage imageNamed:@"已收藏"];
        [_shoucangButton setBackgroundImage:_shoucangImage forState:UIControlStateNormal];
        _isShoucang = 1;
    }else{
        _shoucangCount--;
        NSString *shoucangText = [NSString stringWithFormat:@"%.0f",_shoucangCount];
        _shoucangLabel.text = [NSString stringWithFormat:@"%@", shoucangText];
        _shoucangImage = [UIImage imageNamed:@"未收藏"];
        [_shoucangButton setBackgroundImage:_shoucangImage forState:UIControlStateNormal];
        _isShoucang = 0;
    }
//    NSLog(@"点击了");
    
}
-(void)bofangButtonBackGroundHighlighted:(UIButton *)sender{
    MovieViewController *mo = [[MovieViewController alloc]init];
    mo.UrlString = _model.playUrl;
    mo.receiveModel = _model;
    [self showDetailViewController:mo sender:nil];
    [[dataBaseHelper shareInstance]addCollectiObject:_model];
    
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIImageView*)imageWithImageView:(UIImageView*)imageView
              scaledToSize:(CGSize)newSize;
{
    UIImage *image = imageView.image;
    UIGraphicsBeginImageContext( newSize );
    
    [image drawInRect:CGRectMake(-self.cent.x/2,-self.cent.y/3 + 40,newSize.width + screenFrame.size.width / 2  ,newSize.height + screenFrame.size.height/ 3)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *newView = [[UIImageView alloc]initWithImage:newImage];
    UIGraphicsEndImageContext();
    
    return newView;
}
-(void)leftMenuClick:(id)sender{
    [self.navigationController popViewControllerAnimated:1];
}
-(NSString *)getTime:(NSInteger)time {
    NSInteger min;
    NSInteger sec;
    min = time / 60;
    sec = time % 60;
    return [NSString stringWithFormat:@"%.2ld'%.2ld\"",min,sec];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    /*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
}
@end
