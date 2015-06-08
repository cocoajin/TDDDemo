//
//  ViewController.m
//  VideoCAMPTest
//
//  Created by jinkeke@techshino.com on 15/6/1.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import "ViewController.h"
#import "MovieRecorder.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface ViewController ()<MovieRecorderDelegate>

{
    AVCaptureSession *_captureSession;
    AVCaptureDevice *_videoDevice;
    AVCaptureConnection *_audioConnection;
    AVCaptureConnection *_videoConnection;
    NSDictionary *_videoCompressionSettings;
    NSDictionary *_audioCompressionSettings;
    dispatch_queue_t _sessionQueue;
    dispatch_queue_t _videoDataOutputQueue;
    NSURL *_recordingURL;
    
    NSInteger mvSTATE;

}

@property(nonatomic, retain) __attribute__((NSObject)) CVPixelBufferRef currentPreviewPixelBuffer;

@property(nonatomic, retain) __attribute__((NSObject)) CMFormatDescriptionRef outputVideoFormatDescription;
@property(nonatomic, retain) __attribute__((NSObject)) CMFormatDescriptionRef outputAudioFormatDescription;
@property(nonatomic, retain) MovieRecorder *recorder;
@property(nonatomic, readwrite) AVCaptureVideoOrientation videoOrientation;



@end

@implementation ViewController

//开始
- (IBAction)startAction:(id)sender {
    [self startRECORD];
}

//结束
- (IBAction)stopAction:(id)sender {
    [self stopRecording];
}

//默认在 Documents 目录下
- (NSString *)defaultVideoFilePath
{
    NSString *vdPath = [NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"abc"];
    return vdPath;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[self defaultVideoFilePath]);
    
    //fileOutPUT = [[AVCaptureMovieFileOutput alloc]init];
    //[avCaptureSession addOutput:fileOutPUT];
    //recordFILE_URL = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"mov"]]];  //文件名的设置
    //NSLog(@"文件 %@",recordFILE_URL);

    

#pragma mark url
    _recordingURL = [[NSURL alloc] initFileURLWithPath:[NSString pathWithComponents:@[NSTemporaryDirectory(), @"Movie.MOV"]]];
    _sessionQueue = dispatch_queue_create( "com.apple.sample.capturepipeline.session", DISPATCH_QUEUE_SERIAL );
    _videoDataOutputQueue = dispatch_queue_create( "com.apple.sample.capturepipeline.video", DISPATCH_QUEUE_SERIAL );
    dispatch_set_target_queue( _videoDataOutputQueue, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0 ) );

    
#pragma mark audio set
    _captureSession = [[AVCaptureSession alloc] init];
    /* Audio */
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioIn = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:nil];
    if ( [_captureSession canAddInput:audioIn] ) {
        [_captureSession addInput:audioIn];
    }
    [audioIn release];
    
    AVCaptureAudioDataOutput *audioOut = [[AVCaptureAudioDataOutput alloc] init];
    // Put audio on its own queue to ensure that our video processing doesn't cause us to drop audio
    dispatch_queue_t audioCaptureQueue = dispatch_queue_create( "com.apple.sample.capturepipeline.audio", DISPATCH_QUEUE_SERIAL );
    [audioOut setSampleBufferDelegate:self queue:audioCaptureQueue];
    [audioCaptureQueue release];
    
    if ( [_captureSession canAddOutput:audioOut] ) {
        [_captureSession addOutput:audioOut];
    }
    _audioConnection = [audioOut connectionWithMediaType:AVMediaTypeAudio];
    [audioOut release];

    
#pragma mark video set
    /* Video */
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _videoDevice = videoDevice;
    AVCaptureDeviceInput *videoIn = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:nil];
    if ( [_captureSession canAddInput:videoIn] ) {
        [_captureSession addInput:videoIn];
    }
    [videoIn release];
    AVCaptureVideoDataOutput *videoOut = [[AVCaptureVideoDataOutput alloc] init];
    videoOut.videoSettings = @{ (id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]};
    [videoOut setSampleBufferDelegate:self queue:_videoDataOutputQueue];
    videoOut.alwaysDiscardsLateVideoFrames = NO;
    
    if ( [_captureSession canAddOutput:videoOut] ) {
        [_captureSession addOutput:videoOut];
    }
    _videoConnection = [videoOut connectionWithMediaType:AVMediaTypeVideo];
    _captureSession.sessionPreset =  AVCaptureSessionPreset640x480;
    CMTime frameDuration = CMTimeMake( 1, 30);
    NSError *error = nil;
    if ( [videoDevice lockForConfiguration:&error] ) {
        videoDevice.activeVideoMaxFrameDuration = frameDuration;
        videoDevice.activeVideoMinFrameDuration = frameDuration;
        [videoDevice unlockForConfiguration];
    }
    else {
        NSLog( @"videoDevice lockForConfiguration returned error %@", error );
    }

    _audioCompressionSettings = [[audioOut recommendedAudioSettingsForAssetWriterWithOutputFileType:AVFileTypeQuickTimeMovie] copy];
    _videoCompressionSettings = [[videoOut recommendedVideoSettingsForAssetWriterWithOutputFileType:AVFileTypeQuickTimeMovie] copy];

    [videoOut release];

    
#pragma mark layer set
    //展现视图
    videoPlayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    videoPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoPlayer.frame = capVideoBACK.frame;
    videoPlayer.connection.videoOrientation = (AVCaptureVideoOrientation)[UIApplication sharedApplication].statusBarOrientation;
    [capVideoBACK.layer addSublayer:videoPlayer];


    
    [_captureSession startRunning];
    
    


}

#pragma start RECORD

- (void)startRECORD
{
    NSLog(@"********* START");
    
    MovieRecorder *recorder = [[[MovieRecorder alloc] initWithURL:_recordingURL] autorelease];
    [recorder addAudioTrackWithSourceFormatDescription:self.outputAudioFormatDescription settings:_audioCompressionSettings];
    CGAffineTransform videoTransform = [self transformFromVideoBufferOrientationToOrientation:(AVCaptureVideoOrientation)UIDeviceOrientationPortrait withAutoMirroring:NO]; // Front camera recording shouldn't be mirrored
    
    [recorder addVideoTrackWithSourceFormatDescription:self.outputVideoFormatDescription transform:videoTransform settings:_videoCompressionSettings];
    
    dispatch_queue_t callbackQueue = dispatch_queue_create( "com.apple.sample.capturepipeline.recordercallback", DISPATCH_QUEUE_SERIAL ); // guarantee ordering of callbacks with a serial queue
    [recorder setDelegate:self callbackQueue:callbackQueue];
    [callbackQueue release];
    self.recorder = recorder;
    
    [recorder prepareToRecord]; // asynchronous, will call us back with recorderDidFinishPreparing: or recorder:didFailWithError: when done

 
}

- (void)stopRecording
{
    NSLog(@"********* STOP");
    mvSTATE = 0;
    [self.recorder finishRecording]; // asynchronous, will call us back with recorderDidFinishRecording: or recorder:didFailWithError: when done

}

- (void)movieRecorderDidFinishPreparing:(MovieRecorder *)recorder
{
    NSLog(@"开始准备录制。。。");
    mvSTATE = 1;
}

- (void)movieRecorder:(MovieRecorder *)recorder didFailWithError:(NSError *)error
{
    NSLog(@"录制错误。。。%@",error);
    mvSTATE = 0;
}

- (void)movieRecorderDidFinishRecording:(MovieRecorder *)recorder
{
    NSLog(@"录制结束。。。");
    self.recorder = nil;
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:_recordingURL completionBlock:^(NSURL *assetURL, NSError *error) {
    
        [[NSFileManager defaultManager] removeItemAtURL:_recordingURL error:NULL];
        
    }];
    
    [library release];

}


#pragma mark Utilities

// Auto mirroring: Front camera is mirrored; back camera isn't
- (CGAffineTransform)transformFromVideoBufferOrientationToOrientation:(AVCaptureVideoOrientation)orientation withAutoMirroring:(BOOL)mirror
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    // Calculate offsets from an arbitrary reference orientation (portrait)
    CGFloat orientationAngleOffset = angleOffsetFromPortraitOrientationToOrientation( orientation );
    CGFloat videoOrientationAngleOffset = angleOffsetFromPortraitOrientationToOrientation( self.videoOrientation );
    
    // Find the difference in angle between the desired orientation and the video orientation
    CGFloat angleOffset = orientationAngleOffset - videoOrientationAngleOffset;
    transform = CGAffineTransformMakeRotation( angleOffset );
    
    if ( _videoDevice.position == AVCaptureDevicePositionFront )
    {
        if ( mirror ) {
            transform = CGAffineTransformScale( transform, -1, 1 );
        }
        else {
            if ( UIInterfaceOrientationIsPortrait( orientation ) ) {
                transform = CGAffineTransformRotate( transform, M_PI );
            }
        }
    }
    
    return transform;
}

static CGFloat angleOffsetFromPortraitOrientationToOrientation(AVCaptureVideoOrientation orientation)
{
    CGFloat angle = 0.0;
    
    switch ( orientation )
    {
        case AVCaptureVideoOrientationPortrait:
            angle = 0.0;
            break;
        case AVCaptureVideoOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case AVCaptureVideoOrientationLandscapeRight:
            angle = -M_PI_2;
            break;
        case AVCaptureVideoOrientationLandscapeLeft:
            angle = M_PI_2;
            break;
        default:
            break;
    }
    
    return angle;
}



#pragma mark 数据流输出
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{



    //在这里进行数据实时任务
    //下面的是buffer 保存本地文件

    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription( sampleBuffer );
    
    if ( connection == _videoConnection )
    {
        self.outputVideoFormatDescription = formatDescription;
        if (mvSTATE ==1 ) {
            [self.recorder appendVideoSampleBuffer:sampleBuffer];
        }
    }
    else if ( connection == _audioConnection )
    {
        self.outputAudioFormatDescription = formatDescription;
        if (mvSTATE ==1 ) {
            [self.recorder appendAudioSampleBuffer:sampleBuffer];

        }
    }


    
    
}



//UIImage *capedIMG = [self imageFromSampleBuffer:sampleBuffer];
//int frontCameraImageOrientation = UIImageOrientationLeftMirrored;
//capedIMG = [UIImage imageWithCGImage:capedIMG.CGImage scale:1.0 orientation:frontCameraImageOrientation];
//showCapingIMG.image = capedIMG;

//sambleBuffer 转 UIImage
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    CGImageRelease(quartzImage);
    
    return (image);
}



- (AVCaptureDeviceInput *)inputDeviceWithPosition:(AVCaptureDevicePosition )position
{
    NSError *error = nil;
    //输入设备
    NSArray *allDevices = [AVCaptureDevice
                           devicesWithMediaType:AVMediaTypeVideo];
    if (allDevices.count <1) {
        NSLog(@"设置错误：没有发现任何可用摄像头");
        return nil;
    }
    AVCaptureDevice *device = nil;
    for (AVCaptureDevice *theDevice in allDevices) {
        if (theDevice.position==position) {
            device = theDevice;
        }
    }
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    if (!input) {
        NSLog(@"摄像头打开错误 %@",error);
        return nil;
    }
    
    return input;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
