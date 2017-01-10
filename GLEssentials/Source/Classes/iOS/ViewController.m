//
//  ViewController.m
//  GLEssentials
//
//  Created by developer on 1/6/17.
//  Copyright © 2017 Dan Omachi. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "EAGLView.h"

@interface ViewController ()

@property(strong, nonatomic) AVCaptureSession* captureSession;
@property(strong, nonatomic) EAGLView* glView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCamera];
    [self initGLView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) initCamera
{
    self.captureSession = [AVCaptureSession new];
    
    [self.captureSession beginConfiguration];
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    [self.captureSession addInput:videoInput];
    
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession: self.captureSession];
    preview.frame = self.view.bounds;
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer: preview];
    
    [self.captureSession setSessionPreset:AVCaptureSessionPresetMedium];
    
    [self.captureSession commitConfiguration];
    
    [self.captureSession startRunning];
}

-(void) initGLView
{
    self.glView = [[EAGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    self.glView.backgroundColor = [UIColor clearColor];
    [self.glView startAnimation];
}

@end
