//
//  HCPromisedCommentController.m
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

// -----------------------发现线索 控制器----------------------------


#import "HCPromisedCommentController.h"
#import "ZLPhotoPickerViewController.h"


#import "HCPromisedCommentCell.h"

#import "HCPromisedCommentFrameInfo.h"
#import "HCPromisedCommentInfo.h"

#import "HCAvatarMgr.h"
#import "ZLPhotoAssets.h"

@interface HCPromisedCommentController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSInteger   _photoCount;
    UIButton  * _addPhotoBtn;
    CGRect      _startFrame;
    BOOL        _startEdit;
}
@property (nonatomic,strong) UIView        *inputView;
@property (nonatomic,strong) UIView        * photoView;
@property (nonatomic,strong) UIButton      *imageBtn;
@property (nonatomic,strong) UIButton      *sendBtn;
@property (nonatomic,strong) UITableView   *myTableView;
@property (nonatomic,strong) UITextField   *textField;
@property (nonatomic,strong) NSMutableArray    *images;



@end

@implementation HCPromisedCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现线索";
    _photoCount = 0;
    self.tableView.hidden = YES;
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    [self requestData];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.inputView];
    [self setupBackItem];
}

#pragma mark --- tableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        HCPromisedCommentCell *cell = [HCPromisedCommentCell cellWithTableView:tableView];
        cell.block = ^(UIButton *button){
            
            
            if (_startEdit)
            {
                [self.view endEditing:YES];
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                }completion:^(BOOL finished) {
                    [self.photoView removeFromSuperview];
                }];
            }else
            {
                _startFrame = [button convertRect:button.bounds toView:self.view];
                UIImageView *imageview = [[UIImageView alloc]initWithFrame:_startFrame];
                imageview.image = [button backgroundImageForState:UIControlStateNormal];
                imageview.backgroundColor = [UIColor blackColor];
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBigImageView:)];
                [imageview addGestureRecognizer:tap];
                imageview.contentMode = UIViewContentModeScaleAspectFit;
                [self.view addSubview:imageview];
                [UIView animateWithDuration:0.4 animations:^{
                    
                    imageview.frame = self.view.frame;
                    
                }];
            }
        };
        cell.commnetFrameInfo = self.dataSource[indexPath.row];
        cell.selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCPromisedCommentFrameInfo *frameCell = self.dataSource[indexPath.row];
    return frameCell.cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }completion:^(BOOL finished) {
       [self.photoView removeFromSuperview];
    }];
    
}

#pragma mark --- textFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _startEdit = YES;
    [self.photoView removeFromSuperview];
    self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _startEdit = NO;
}

#pragma mark ---- UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            [[picker navigationBar] setTintColor:[UIColor whiteColor]];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
            
        case 1:
        {
            ZLPhotoPickerViewController *zlpVC = [[ZLPhotoPickerViewController alloc]init];
            zlpVC.callBack = ^(NSArray *arr){
                
                for (ZLPhotoAssets *zl in arr)
                {
                    UIImage  *image = zl.originImage;
                    [self.images addObject:image];
                }
                for (int i = 0; i< self.images.count; i++)
                {
                    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, SCREEN_WIDTH/3)];
                    imageView.userInteractionEnabled = YES;
                    imageView.image = self.images[i];
                    UILongPressGestureRecognizer  *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deletePhoto:)];
                    [imageView addGestureRecognizer:longPress];
                    [self.photoView addSubview:imageView];
                }
                [UIView animateWithDuration:0.05 animations:^{
                    
                        self.view.bounds = CGRectMake(0,SCREEN_WIDTH/3, SCREEN_WIDTH, SCREEN_HEIGHT);
                
                }completion:^(BOOL finished) {
                    
                        [self.view addSubview:self.photoView];
                    
                }];
            };
            [self presentViewController:zlpVC animated:YES completion:nil];
        }
            break;
        default:
            break;
       }

}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.images addObject: image];

    for (int i = 0; i< self.images.count; i++)
    {
        UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, SCREEN_WIDTH/3)];
        imageView.image = self.images[i];
        [self.photoView addSubview:imageView];
    }

     [UIView animateWithDuration:0.05 animations:^{
        
        self.view.bounds = CGRectMake(0,SCREEN_WIDTH/3, SCREEN_WIDTH, SCREEN_HEIGHT);
         
     }completion:^(BOOL finished) {
         
        [self.view addSubview:self.photoView];
         
     }];
    
     UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3 * (_photoCount-1), 0,  SCREEN_WIDTH/3, SCREEN_WIDTH/3)];
        imageView.image = image;
    [self.photoView addSubview:imageView];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- private mothods


-(void)deletePhoto:(UILongPressGestureRecognizer *)longPress
{
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3-20,0, 20, 20)];
    view.backgroundColor = [UIColor redColor];
    [longPress.view addSubview:view];
 
}

-(void)removeBigImageView:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    [UIView animateWithDuration:0.4 animations:^{
        imageView.frame = _startFrame;
    }completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];

}

-(void)clickImageBtn:(UIButton *) button
{
    UIActionSheet  *sheet = [[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
    [sheet  showInView:self.view];
    [self.textField endEditing:YES];


}

//添加图片
-(void)addPhoto:(UIButton *)button
{
    UIActionSheet  *sheet = [[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选取", nil];
    [sheet  showInView:self.view];
}


#pragma mark --- getter Or setter


- (UIView *)inputView
{
    if(!_inputView){
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH,44)];
        _inputView.backgroundColor = [UIColor redColor];
        _inputView.backgroundColor =COLOR(222, 35, 46, 1);
        [_inputView addSubview:self.textField];
        [_inputView addSubview:self.imageBtn];
        [_inputView addSubview:self.sendBtn];
    }
    return _inputView;
}


- (UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


- (UITextField *)textField
{
    if(!_textField){
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(60,7,SCREEN_WIDTH-120, 30)];
        _textField.backgroundColor = [UIColor whiteColor];
        ViewRadius(_textField, 4);
        _textField.delegate = self;
    }
    return _textField;
}

- (UIButton *)sendBtn
{
    if(!_sendBtn){
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 2, 60, 40);
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    }
    return _sendBtn;
}

- (UIButton *)imageBtn
{
    if(!_imageBtn){
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn.frame = CGRectMake(10,7 , 30, 30);
        [_imageBtn addTarget:self action:@selector(clickImageBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_imageBtn setBackgroundImage:IMG(@"cam-0") forState:UIControlStateNormal];
    }
    return _imageBtn;
}

- (UIView *)photoView
{
    if(!_photoView){
        _photoView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH, SCREEN_WIDTH/3)];
        _photoView.backgroundColor = [UIColor whiteColor];
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside ];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, SCREEN_WIDTH/3);
        [button setImage:IMG(@"Classinfo_but_plus") forState:UIControlStateNormal];
        _addPhotoBtn = button;
        [_photoView addSubview:_addPhotoBtn];
    }
    return _photoView;
}

- (NSMutableArray *)images
{
    if(!_images){
        _images = [[NSMutableArray alloc]init];
    }
    return _images;
}



#pragma mark ---  network

-(void)requestData
{
    for (int i= 0; i<20; i++)
    {
        HCPromisedCommentFrameInfo *commentFrameInfo = [[HCPromisedCommentFrameInfo alloc]init];
        HCPromisedCommentInfo *commentInfo = [[HCPromisedCommentInfo alloc]init];
        commentInfo.nickName  = [NSString stringWithFormat:@"用户昵称%d",i ];
        commentInfo.comment = @"我看到一个小孩子跟你描述的小孩子很像，在人民广场，你看看是不是你家小孩子";
        commentInfo.time = @"一分钟前";
        commentFrameInfo.commentInfo = commentInfo;
        [self.dataSource addObject:commentFrameInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
