//
//  MovieViewController.m
//  I Watch
//
//  Created by 陈萍 on 15/11/10.
//  Copyright © 2015年 陈萍. All rights reserved.
//

#import "MovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "SVProgressHUD.h"
@interface MovieViewController ()<stop>
@property(nonatomic,strong)AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *movieView;
//遮罩层
@property (weak, nonatomic) IBOutlet UIView *shadeView;
@property(nonatomic,assign)BOOL isCollect;
@property(nonatomic,strong)UIView *ControlView;
@property(nonatomic,strong)UIButton *CollectButton;
@property(nonatomic,assign)BOOL isPause;
@property(nonatomic,strong)UIButton *pauseButton;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UILabel *startTimeLabel;
@property(nonatomic,strong)UIButton *volumeDownbutton;
@property(nonatomic,strong)UISlider *timeSlider;
@property(nonatomic,strong)UIButton *uploadButton;
@property(nonatomic,strong)UIButton *volumeUpbutton;
@property(nonatomic,strong)UILabel *allTimeLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIProgressView *progress;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)CGFloat currentTime;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
@property(nonatomic,strong)UIProgressView *buffer;
@property(nonatomic,strong)UIWebView *lodingGif;

@property(nonatomic,strong)UIView *adView;

/** 缓冲进度条 */
@property(nonatomic,strong)UIView *bufferView;
/** playItem时间刻度 */
@property(nonatomic,assign)int timeScale;

///时间后台
@property(nonatomic,strong) id obj;
//自动布局用的字典
@property(nonatomic,strong)NSDictionary *views;
#define screenFrame [UIScreen mainScreen].bounds
@end

@implementation MovieViewController
-(void)stopPlay{
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateActive ) {
        
        [self.player play];
    }
    else{
        [self.player pause];
    }
}
-(void)play{
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateActive ) {
        
        [self.player play];
    }
    else{
        [self.player pause];
    }
}
- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopPlay) name:@"stop" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(play) name:@"stop" object:nil];
//    self.delegate = self;
    [super viewDidLoad];
        self.adView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
        _adView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        CGSize siz = _adView.size;
        UILabel *adLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, siz.width, siz.height)];
        adLabel.text =@"Champion Fighting";
        adLabel.textAlignment = 1;
        [_adView addSubview:adLabel];
        adLabel.textColor = [UIColor lightGrayColor];
        _adView.center = CGPointMake(screenFrame.size.height/2 , screenFrame.size.width/2 - 50);
    
        [self.view addSubview:_adView];
        _adView.hidden = 1;
    
        self.movieView.backgroundColor = [UIColor blackColor];
    //网络
    NSURL *playURl = [NSURL URLWithString:self.UrlString];
    AVAsset *asset = [AVAsset assetWithURL:playURl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    _player = [AVPlayer playerWithPlayerItem:item];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, screenFrame.size.height, screenFrame.size.width);
    _shadeView.frame = CGRectMake(0, 0, screenFrame.size.height, screenFrame.size.width);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.movieView.layer addSublayer:_playerLayer];
    [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];//监听属性
    [_player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self setUpControllView];
    _ControlView.hidden = 1;
    _shadeView.hidden = 1;
    _isCollect = 0;
    [SVProgressHUD show];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
        // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
        [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
-(void)setUpControllView{
    _ControlView = [[UIView alloc]init];
    _player.volume = 2;
    //_timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(refondContr:) userInfo:nil repeats:NO];
    _ControlView.frame = CGRectMake(0, 0, screenFrame.size.height, screenFrame.size.width);
    
    [self.view addSubview:_ControlView];
    //播放进度条
    _timeSlider = [[UISlider alloc] init];
    UIImage *imaga = [UIImage imageNamed:@"slider@2x.png"];
    
    [_timeSlider setThumbImage:imaga forState:UIControlStateNormal];
    _timeSlider.minimumTrackTintColor = [UIColor whiteColor];
    _timeSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
    _timeSlider.translatesAutoresizingMaskIntoConstraints = NO;
    ///关闭了交互
    //    [_timeSlider setUserInteractionEnabled:0];
    [_timeSlider addTarget:self action:@selector(changeProgress:)
          forControlEvents:UIControlEventValueChanged];
    _timeSlider.maximumValue = _receiveModel.duration;
    NSLog(@"%f",_receiveModel.duration);
    //    [_timeSlider addTarget:self action:@selector(StartDrag:) forControlEvents:UIControlEventTouchDown];
    [_ControlView addSubview:_buffer];
    [_ControlView addSubview:_timeSlider];
    //开始时间
    _startTimeLabel = [[UILabel alloc] init];
    _startTimeLabel.text = @"00:00";
    _startTimeLabel.textColor = [UIColor lightGrayColor];
    _startTimeLabel.font = [UIFont systemFontOfSize:15];
    [_ControlView addSubview:_startTimeLabel];
    _startTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //总时间
    _allTimeLabel = [[UILabel alloc] init];
    _allTimeLabel.text = @"00:00";
    _allTimeLabel.textColor = [UIColor lightGrayColor];
    _allTimeLabel.font = [UIFont systemFontOfSize:15];
    [_ControlView addSubview:_allTimeLabel];
    _allTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //返回button
    
    _backButton = [[UIButton alloc] init];
    _backButton.frame = CGRectMake(20, 0, 350,50);
    //[_backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(BackButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_ControlView addSubview:_backButton];
//    _backButton.backgroundColor = [UIColor redColor];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    image.frame = CGRectMake(0, 10, 20, 20);
    [_backButton addSubview:image];
    //__titleLabel
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(20, 10, 400, 20);
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = _receiveModel.title;
    [_backButton addSubview:_titleLabel];
    //音量加button
    _volumeUpbutton = [[UIButton alloc] init];
    _volumeUpbutton.frame = CGRectMake(25, 90, 15, 15);
    [_volumeUpbutton setImage:[UIImage imageNamed:@"音量大.png"] forState:UIControlStateNormal];
    [_ControlView addSubview:_volumeUpbutton];
    [_volumeUpbutton addTarget:self action:@selector(volumeUp:) forControlEvents:UIControlEventTouchUpInside];
    //声音进度条
    self.progress = [[UIProgressView alloc]initWithProgressViewStyle: UIProgressViewStyleBar];
    _progress.backgroundColor = [UIColor grayColor];
    _progress.progressTintColor = [UIColor whiteColor];
    _progress.progress = 1;
    _progress.frame = CGRectMake(-26, 175, 110, 15);
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI/2 * 3);
    _progress.transform = trans;
    [_ControlView addSubview:_progress];
    //音量减button
    _volumeDownbutton = [[UIButton alloc] init];
    _volumeDownbutton.frame = CGRectMake(25, 242, 15, 15);
    [_volumeDownbutton setImage:[UIImage imageNamed:@"音量小.png"] forState:UIControlStateNormal];
    [_ControlView addSubview:_volumeDownbutton];
    [_volumeDownbutton addTarget:self action:@selector(volumeDown:) forControlEvents:UIControlEventTouchUpInside];
    //收藏Button
    self.CollectButton = [[UIButton alloc] init];
    [self.CollectButton setImage:[UIImage imageNamed:@"未收藏白.png"] forState:UIControlStateNormal];
    [self.CollectButton addTarget:self action:@selector(collectButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.CollectButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_ControlView addSubview:self.CollectButton];
    //上传Button
    _uploadButton = [[UIButton alloc] init];
    [_uploadButton setImage:[UIImage imageNamed:@"上传白.png"] forState:UIControlStateNormal];
    _uploadButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_ControlView addSubview:_uploadButton];
    //暂停button
    _pauseButton = [[UIButton alloc] init];
    [_pauseButton setImage:[UIImage imageNamed:@"暂停白.png"] forState:UIControlStateNormal];
    _pauseButton.frame = CGRectMake(screenFrame.size.height/2-22, screenFrame.size.width/2-22, 44, 44);
    [_pauseButton addTarget:self action:@selector(pauseButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_ControlView addSubview:_pauseButton];
    //自动布局用的字典
    self.views = NSDictionaryOfVariableBindings(_timeSlider,_startTimeLabel,_allTimeLabel,_CollectButton,_uploadButton);
    //纯代码自动布局
    //_timeSlider
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_timeSlider]-50-|" options:0 metrics:nil views:_views]];
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_timeSlider(20.0)]-15-|" options:0 metrics:nil views:_views]];
    //startTimeLabel
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_startTimeLabel]" options:0 metrics:nil views:_views]];
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_startTimeLabel(30.0)]-10-|" options:0 metrics:nil views:_views]];
    //_allTimeLabel
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_allTimeLabel]-5-|" options:0 metrics:nil views:_views]];
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_allTimeLabel(30.0)]-10-|" options:0 metrics:nil views:_views]];
    //collectButton
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_CollectButton(25.0)]-90-|" options:0 metrics:nil views:_views]];
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_CollectButton(25.0)]" options:0 metrics:nil views:_views]];
    //_uploadButton
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_uploadButton(20.0)]-30-|" options:0 metrics:nil views:_views]];
    [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-17-[_uploadButton(20.0)]" options:0 metrics:nil views:_views]];
    //在控件层加手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
    //需要手指的个数
    tapGR.numberOfTouchesRequired = 1;
    [_ControlView addGestureRecognizer:tapGR];
    //在视频层加手势
    UITapGestureRecognizer *movietapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movietapGRAction:)];
    movietapGR.numberOfTouchesRequired = 1;
    [_movieView addGestureRecognizer:movietapGR];
    
    
    //初始化控件
    
    //    videoModel *model = [[videoModel alloc]init];
    _allTimeLabel.text = [self getTtime:_receiveModel.duration ];
}
//在控件层加手势
- (void)tapGRAction:(UITapGestureRecognizer *)sender{
    //    NSLog(@"2");
    _ControlView.hidden = 1;
    _shadeView.hidden = 1;
}
//在视频层加手势
- (void)movietapGRAction:(UITapGestureRecognizer *)sender{
    _ControlView.hidden = 0;
    _shadeView.hidden = 0;
}

//收藏button点击事件
-(void)collectButtonDidClicked:(UIButton *)sender{
    [sender setShowsTouchWhenHighlighted:1];
    if (!_isCollect) {
        //_CollectImage = [UIImage imageNamed:@"已收藏白.png"];
        [_CollectButton setBackgroundImage:[UIImage imageNamed:@"已收藏白.png"] forState:UIControlStateNormal];
        _isCollect = 1;
    }else{
        [_CollectButton setBackgroundImage:[UIImage imageNamed:@"未收藏白.png"] forState:UIControlStateNormal];
        _isCollect = 0;
    }
    NSLog(@"点击了");
}
//返回Button点击事件
-(void)BackButtonDidClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:1 completion:^{
        NSLog(@"Back");
    }];
}
//音量加
-(void)volumeUp:(UIButton *)sender{
    [sender setShowsTouchWhenHighlighted:1];
    if(_player.volume < 2){
        _player.volume += 0.1;
    }else{
        _player.volume = 2;
    }
    _progress.progress = _player.volume/2;
}
//声音减
-(void)volumeDown:(UIButton *)sender{
    [sender setShowsTouchWhenHighlighted:1];
    if (_player.volume > 0) {
        _player.volume-=0.1;
    }else{
        _player.volume = 0;
    }
    _progress.progress = _player.volume/2;
    
    
}
//暂停Button点击事件
-(void)pauseButtonDidClicked:(UIButton *)sender{
    [sender setShowsTouchWhenHighlighted:1];
    if (!_isPause) {
        [_pauseButton setImage:[UIImage imageNamed:@"播放白.png"] forState:UIControlStateNormal];
        [_player pause];
        self.adView.hidden = 0;
        _isPause = 1;



    }else{
        [_pauseButton setImage:[UIImage imageNamed:@"暂停白.png"] forState:UIControlStateNormal];
        [_player play];
        self.adView.hidden = 1;
        _isPause = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(refondContr:) userInfo:nil repeats:NO];
    }
}
//收回控制器
-(void)refondContr:(NSTimer *)sender{
    _ControlView.hidden = 1 ;
    _shadeView.hidden = 1;
    
}
//timeSlider更新
-(void)UpdateTimeSlider:(NSTimer *)sender{
}
//监听player属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
//            [self pauseButtonDidClicked:nil];
            if( [UIApplication sharedApplication].applicationState == UIApplicationStateActive ||  [UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
                [SVProgressHUD dismiss];
                [self.player play];
            }
            else {
                [self.player pause];
            }
            _ControlView.hidden = 1;
            _shadeView.hidden = 1;
            [self monitoringPlayback:_player.currentItem];
            
            self.timeScale = playerItem.currentTime.timescale;
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval result = startSeconds + durationSeconds;
        
        float bufferProgress = (float)result / self.player.currentItem.duration.value * self.player.currentItem.duration.timescale;
        self.buffer.progress = bufferProgress;
    }
}
- (void)monitoringPlayback:(AVPlayerItem *)playerItem
{
    ///破坏怪圈  甲里引用乙，乙里引用甲，就会导致 “retain cycle” -- “形成怪圈”的错误
    __weak MovieViewController *blockSelf = self;
    _obj = [_player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0 / 60.0, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time)
            {
                CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;
                _currentTime = currentSecond;
                double t = CMTimeGetSeconds(blockSelf.player.currentTime);
                //                   blockSelf.timeSlider.value = _currentTime/_receiveModel.duration;
                blockSelf.timeSlider.value = t;
                
                blockSelf. startTimeLabel.text = [blockSelf getTtime:blockSelf.currentTime];
            }];
    if (_obj) {
        return;
    }
    
    
}
//timeSlider绑定事件
-(void)changeProgress:(UISlider *)sender{
    [self.player pause];
    //
    //    CGFloat speedTime = sender.value * self.player.currentItem.duration.value * self.player.currentItem.duration.timescale;
    ////    NSLog(@"%d",sender.value);
    //    CMTime cmtime = CMTimeMake(speedTime * self.timeScale, self.timeScale);
    //    NSLog(@"%d", self.timeScale);
    //
    CMTime cmtime= CMTimeMakeWithSeconds(sender.value, self.player.currentTime.timescale);
    
    [self.player seekToTime:cmtime completionHandler:^(BOOL finished) {
        //
        if (finished) {
            [self.player play];
            [_pauseButton setImage:[UIImage imageNamed:@"暂停白.png"] forState:UIControlStateNormal];
            [_player play];
            self.adView.hidden = 1;
            _isPause = 0;
            
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
-(NSString *)getTtime:(NSInteger)time {
    NSInteger min;
    NSInteger sec;
    min = time / 60;
    sec = time % 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld",min,sec];
}
-(NSString *)getTime:(NSInteger)time {
    NSInteger min;
    NSInteger sec;
    min = time / 60;
    sec = time % 60;
    return [NSString stringWithFormat:@"%.2ld'%.2ld\"",min,sec];
}
-(void)viewWillDisappear:(BOOL)animated{
    [_player pause];
    [_player setRate:0];
    [_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [_player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_timer invalidate];
    _timer = nil;
    self.player = nil;
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(remove:) userInfo:nil repeats:NO];
    _timer = time;
}
-(void)remove:(NSTimer *)sender{
    [self.timer invalidate];
    self.timer = nil;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - 懒加载
-(UIProgressView *)buffer{
    if (_buffer == nil) {
        _buffer = [[UIProgressView alloc]init];
        //_buffer.backgroundColor = [UIColor clearColor];
        _buffer.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        _buffer.trackTintColor = [UIColor clearColor];
        [self.ControlView insertSubview:_buffer belowSubview:_timeSlider];
        _buffer.translatesAutoresizingMaskIntoConstraints = NO;
        self.views = NSDictionaryOfVariableBindings(_buffer);
        [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_buffer]-50-|" options:0 metrics:nil views:_views]];
        [_ControlView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_buffer(2.0)]-23-|" options:0 metrics:nil views:_views]];
        
    }
    return _buffer;
}
@end
