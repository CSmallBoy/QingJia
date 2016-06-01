//
//  SCSwipeTableViewCell.m
//  SCSwipeTableViewCell
//
//  Created by Sunc on 15/12/17.
//  Copyright © 2015年 Sunc. All rights reserved.
//

#import "HCNotifiMessageCenterCell.h"

#define SC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define INTERVAL 10

// ------------------------------------信息中心cell-------------------------------------------

@interface HCNotifiMessageCenterCell()<UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
    BOOL isShow;
    
    BOOL  isTwo;
}


@property (nonatomic,strong) UIImageView *headIV;
@property (nonatomic,strong) UIButton  *headBtn;;
@property (nonatomic,strong) UILabel   *NameSexAgeLB;
@property (nonatomic,strong) UILabel   *sendLabel;
@property (nonatomic,strong) UILabel   *missLabel;


@property (nonatomic, retain)UIView  *cellContentView;
@property (nonatomic, retain)UIPanGestureRecognizer *panGersture;
@property (nonatomic, assign)CGFloat judgeWidth;
@property (nonatomic, assign)CGFloat rightfinalWidth;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, assign,readwrite)BOOL isRightBtnShow;
@property (nonatomic, assign)BOOL otherCellIsOpen;
@property (nonatomic, assign)BOOL isHiding;
@property (nonatomic, assign)BOOL isShowing;
@end

@implementation HCNotifiMessageCenterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     withBtns:(NSArray *)arr
          tableView:(UITableView *)tableView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rightBtnArr = [NSArray arrayWithArray:arr];
        self.superTableView = tableView;
        [self prepareForCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//set default select style
    }
    return self;
}

- (void)prepareForCell{
    [self setBtns];
    [self setScrollView];
    [self addObserverEvent];
    [self addGesture];
    [self addNotify];
}

-(void)setInfo:(HCNotificationCenterInfo *)info
{
    _info = info;

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@ %@岁",info.trueName,info.sex,info.age]];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor lightGrayColor]} range:NSMakeRange(info.trueName.length,attStr.length -info.trueName.length)];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} range:NSMakeRange(0, attStr.length-info.trueName.length)];
    self.NameSexAgeLB.attributedText = attStr;
    
    self.sendLabel.text = [NSString stringWithFormat:@"发布时间：%@",info.createTime];

    self.missLabel.text = [NSString stringWithFormat:@"走失描述：%@",info.lossDesciption];
    
    NSURL *url = [readUserInfo originUrl:self.info.imageName :kkObject];
    
    UIImageView *imageIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.headBtn.frame.size.width, self.headBtn.frame.size.height)];
    [imageIV sd_setImageWithURL:url placeholderImage:IMG(@"Head-Portraits")];
    [self.headBtn addSubview:imageIV];
    
}

// 头像的宽度为60

- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame =CGRectMake(INTERVAL, INTERVAL, 60, 60);
        [_headBtn setBackgroundImage:IMG(@"Head-Portraits") forState:UIControlStateNormal];
    }
    return _headBtn;
}





// 姓名 性别 年龄 的宽度  150
- (UILabel *)NameSexAgeLB
{
    if(!_NameSexAgeLB){
        _NameSexAgeLB = [[UILabel alloc]initWithFrame:CGRectMake(80, INTERVAL, 150, 30)];
    }
    return _NameSexAgeLB;
}

// 发布时间 宽度  150
- (UILabel *)sendLabel
{
    if(!_sendLabel){
        _sendLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -160, INTERVAL, 150, 20)];
        _sendLabel.font = [UIFont systemFontOfSize:11];
        _sendLabel.textColor = [UIColor lightGrayColor];
        _sendLabel.textAlignment = NSTextAlignmentRight;
    }
    return _sendLabel;
}


- (UILabel *)missLabel
{
    if(!_missLabel){
        _missLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, SCREEN_WIDTH-80, 30)];
        _missLabel.font = [UIFont systemFontOfSize:14];
        _missLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _missLabel;
}


#pragma mark prepareForReuser
- (void)prepareForReuse
{
    [self hideBtn];
    [super prepareForReuse];
}

#pragma mark initCell

- (void)setBtns{
    if (_rightBtnArr.count>0) {
        [self processBtns];
    }
    else{
        return;
    }
}

- (void)processBtns{
    CGFloat lastWidth = 0;
    int i = 0;
    NSIndexPath *indexPath = [_superTableView indexPathForCell:self];
     self.cellHeight = [_superTableView rectForRowAtIndexPath:indexPath].size.height;
    
    for (UIButton *temBtn in _rightBtnArr)
    {
        temBtn.tag = i;
        CGRect temRect = temBtn.frame;
        temRect.origin.x = SC_SCREEN_WIDTH - temRect.size.width - lastWidth;
        temBtn.frame = temRect;
        lastWidth = lastWidth + temBtn.frame.size.width;
        if (!_judgeWidth) {
            _judgeWidth = lastWidth;
        }
        if (_cellHeight != temBtn.frame.size.height) {
            CGRect frame = temBtn.frame;
            frame.size.height = _cellHeight;
            temBtn.frame = frame;
        }
        [temBtn addTarget:self action:@selector(cellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:temBtn];
        i++;

    }
    _rightfinalWidth = lastWidth;
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setScrollView{
    _SCContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SC_SCREEN_WIDTH, _cellHeight)];
    _SCContentView.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self.contentView addSubview:_SCContentView];
}



-(void)addSubviews
{
    for (UIView *view in _SCContentView.subviews) {
        [view removeFromSuperview];
    }

    
    [_SCContentView addSubview:self.headBtn];
    [_SCContentView addSubview:self.NameSexAgeLB];
    [_SCContentView addSubview:self.sendLabel];
    [_SCContentView addSubview:self.missLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isRightBtnShow) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SC_CELL_SHOULDCLOSE" object:nil userInfo:@{@"action":@"closeCell"}];
    }
    else{
        [self hideBtn];
    }
}

#pragma mark events,gesture and observe

- (void)addNotify{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotify:)
                                                 name:@"SC_CELL_SHOULDCLOSE"
                                               object:nil];
}

- (void)handleNotify:(NSNotification *)notify{
    if ([[notify.userInfo objectForKey:@"action"] isEqualToString:@"closeCell"]) {
        [self hideBtn];
        _otherCellIsOpen = NO;
    }
    else if ([[notify.userInfo objectForKey:@"action"] isEqualToString:@"otherCellIsOpen"]){
        _otherCellIsOpen = YES;
    }
    else if ([[notify.userInfo objectForKey:@"action"] isEqualToString:@"otherCellIsClose"])
    {
        _otherCellIsOpen = NO;
    }
}

- (void)addObserverEvent{
    [_superTableView addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                         context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint oldpoint = [[change objectForKey:@"old"] CGPointValue];
        CGPoint newpoint = [[change objectForKey:@"new"] CGPointValue];
        if (oldpoint.y!=newpoint.y) {
            NSLog(@"---sueperTabelViewMoves---");
            if ((_SCContentView.frame.origin.x == -_judgeWidth)) {
                [self hideBtn];
            }
        }
    }
}

- (void)addGesture{
    
    _panGersture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    _panGersture.delegate = self;
    [self.SCContentView addGestureRecognizer:_panGersture];

    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.SCContentView addGestureRecognizer:tap];
}

-(void)tap:(UITapGestureRecognizer *)tap
{
     NSLog(@"%lf",_SCContentView.frame.origin.x );
     if (_SCContentView.frame.origin.x == -180)
    {

        [self hideBtn];
        
    }
    else
    {
        NSDictionary *dic = @{@"info" : self.info.callId};
     [[NSNotificationCenter defaultCenter] postNotificationName:@"ToNextOtherController" object:nil userInfo:dic];
    }
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)recognizer{

    CGPoint translation = [_panGersture translationInView:self];
    CGPoint location = [_panGersture locationInView:self];
    NSLog(@"translation----(%f)----loaction(%f)",translation.x,location.y);
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            if (fabs(translation.x)<fabs(translation.y)) {
                _superTableView.scrollEnabled = YES;
                return;
            }else{
                _superTableView.scrollEnabled = NO;
            }
            if (_otherCellIsOpen&&!(_SCContentView.frame.origin.x == -_judgeWidth)) {
                return;
            }
            //contentoffse changed
            if (translation.x<0) {
                //SCContentView is moving towards left
                if (_SCContentView.frame.origin.x == -_judgeWidth) {
                    //close cell
                    [self hideBtn];
                }
                else if (_SCContentView.frame.origin.x > -_judgeWidth){
                    //open cell
                    [self moveSCContentView:translation.x];
            
                }
            }
            else if (translation.x>0){
                //SCContentView is moving towards right
                [self hideBtn];

            }
            break;
            
        case UIGestureRecognizerStateEnded:
            _superTableView.scrollEnabled = YES;
            if (_otherCellIsOpen&&!(_SCContentView.frame.origin.x == -_judgeWidth)) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"SC_CELL_SHOULDCLOSE" object:nil userInfo:@{@"action":@"closeCell"}];
                return;
            }
            //end pan
            [self SCContentViewStop];
            break;
            
        case UIGestureRecognizerStateCancelled:
            _superTableView.scrollEnabled = YES;
            //cancell
            [self SCContentViewStop];
            break;
            
        default:
            break;
    }

       [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}

- (void)moveSCContentView:(CGFloat)offset{
    CGRect temRect = _SCContentView.frame;
    temRect.origin.x = (temRect.origin.x + offset);//adjust touch offset with your finger movement
    if (temRect.origin.x+(SC_SCREEN_WIDTH)/2.0<0) {
        temRect.origin.x = -SC_SCREEN_WIDTH/2.0;
    }
    if (temRect.origin.x>SC_SCREEN_WIDTH/2.0) {
        temRect.origin.x = SC_SCREEN_WIDTH/2.0;
    }
    _SCContentView.frame = temRect;
}

- (void)SCContentViewStop{
    if ((_SCContentView.frame.origin.x == -_judgeWidth)) {
        //btn is shown
        if (_SCContentView.frame.origin.x + _judgeWidth<0) {
            [self showBtn];
        }
        else
        {
            [self hideBtn];
        }
    }
    else{
        if (_SCContentView.frame.origin.x+10>0) {
            [self hideBtn];
        }
        else{
            [self showBtn];
        }
    }
}

#pragma mark showBtn hideBtn

- (void)showBtn{
    if (!(_SCContentView.frame.origin.x == -_judgeWidth)) {
        if (!_isShowing) {
            [self cellWillShow];
            _isShowing = YES;
        }
    }
    _superTableView.scrollEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect temRect = _SCContentView.frame;
        temRect.origin.x = -_rightfinalWidth;
        _SCContentView.frame = temRect;
    } completion:^(BOOL finished) {
        if (!_isRightBtnShow) {
            [self cellDidShow];
            _isShowing = NO;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SC_CELL_SHOULDCLOSE" object:nil userInfo:@{@"action":@"otherCellIsOpen"}];
        _superTableView.scrollEnabled = YES;
    }];
}

- (void)hideBtn{
    if ((_SCContentView.frame.origin.x == -_judgeWidth)) {
        if (!_isHiding) {
            [self cellWillHide];
            _isHiding = YES;
        }
    }
    _superTableView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect temRect = _SCContentView.frame;
        temRect.origin.x = 0;
        _SCContentView.frame = temRect;
    } completion:^(BOOL finished) {
        if (_isRightBtnShow) {
            [self cellDidHide];
            _isHiding = NO;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SC_CELL_SHOULDCLOSE" object:nil userInfo:@{@"action":@"otherCellIsClose"}];
        _superTableView.userInteractionEnabled = YES;
    }];
}

#pragma delegate

- (void)cellWillHide{
    if ([_delegate respondsToSelector:@selector(cellOptionBtnWillHide)]) {
        [_delegate cellOptionBtnWillHide];
    }
}

- (void)cellWillShow{
    if ([_delegate respondsToSelector:@selector(cellOptionBtnWillShow)]) {
        [_delegate cellOptionBtnWillShow];
    }
}

- (void)cellDidShow{
    if ([_delegate respondsToSelector:@selector(cellOptionBtnDidShow)]) {
        [_delegate cellOptionBtnDidShow];
    }
}

- (void)cellDidHide{
    if ([_delegate respondsToSelector:@selector(cellOptionBtnDidHide)]) {
        [_delegate cellOptionBtnDidHide];
    }
}

- (void)cellBtnClicked:(UIButton *)sender{
    NSIndexPath *indexPath = [self.superTableView indexPathForCell:self];
    if ([_delegate respondsToSelector:@selector(SCSwipeTableViewCelldidSelectBtnWithTag:andIndexPath:)]) {
        [_delegate SCSwipeTableViewCelldidSelectBtnWithTag:sender.tag andIndexPath:indexPath];
    }
    [self hideBtn];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)dealloc{
    [_superTableView removeObserver:self forKeyPath:@"contentOffset"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SC_CELL_SHOULDCLOSE" object:nil];
}
@end
