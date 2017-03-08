//
//  ViewController.m
//  WebServiceTest
//
//  Created by cocoa on 17/3/1.
//  Copyright © 2017年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

    //SOAP 1.1
- (void)soapv11Request
{
    NSURL *url = [NSURL URLWithString:@"http://ws.webxml.com.cn/WebServices/MobileCodeWS.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"POST";
    [req setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"" forKey:@""];
    [req setValue:@"http://WebXml.com.cn/getMobileCodeInfo" forHTTPHeaderField:@"SOAPAction"];
    
    NSString *reqBody = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                         <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                         <soap:Body>\
                         <getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\">\
                         <mobileCode>%@</mobileCode>\
                         <userID></userID>\
                         </getMobileCodeInfo>\
                         </soap:Body>\
                         </soap:Envelope>",self.phoneNumTF.text];

    NSData *reqData = [reqBody dataUsingEncoding:NSUTF8StringEncoding];
    req.HTTPBody = reqData;
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"Error:%@",connectionError);
        }
        else
        {
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        }
        
        
    }];
}


//SOAP 1.2
- (void)soapv12Request
{
    NSURL *url = [NSURL URLWithString:@"http://ws.webxml.com.cn/WebServices/MobileCodeWS.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"POST";
    [req setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *reqBody = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                         <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\
                         <soap12:Body>\
                         <getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\">\
                         <mobileCode>%@</mobileCode>\
                         <userID></userID>\
                         </getMobileCodeInfo>\
                         </soap12:Body>\
                         </soap12:Envelope>",self.phoneNumTF.text];
    
    NSData *reqData = [reqBody dataUsingEncoding:NSUTF8StringEncoding];
    req.HTTPBody = reqData;
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"Error:%@",connectionError);
        }
        else
        {
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        }
        
        
    }];
}

- (IBAction)checkPhontNumAction:(id)sender {
    
    
    //webwervcie soap 1.1
    //[self soapv11Request];
    

    //webservice soap 1.2
    [self soapv12Request];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
