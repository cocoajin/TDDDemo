//
//  ViewController.h
//  VideoCAMPTest
//
//  Created by jinkeke@techshino.com on 15/6/1.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

{
    __weak IBOutlet UIImageView *capVideoBACK;
    __weak IBOutlet UIImageView *showCapingIMG;
    
    AVCaptureVideoPreviewLayer *videoPlayer;
    

}


@end

