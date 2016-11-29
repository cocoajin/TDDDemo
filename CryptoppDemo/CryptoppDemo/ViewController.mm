//
//  ViewController.m
//  CryptoppDemo
//
//  Created by cocoa on 16/11/28.
//  Copyright © 2016年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "md5.h"
#import "randpool.h"
#import "rsa.h"
#import "cryptlib.h"
#import "hex.h"
#import "files.h"
#import "osrng.h"
#import "filters.h"
#import "validate.h"
#import "modes.h"

//#import "secblock.h"
//static CryptoPP::OFB_Mode<CryptoPP::AES>::Encryption s_globalRNG;
//
//CryptoPP::RandomNumberGenerator & GlobalRNG()
//{
//    return s_globalRNG;
//}

@interface ViewController ()

@end

@implementation ViewController

-(NSData*)getMD5Value:(NSData*)data {
    CryptoPP::MD5 md5;
    byte digest[ CryptoPP::MD5::DIGESTSIZE ];
    
    md5.CalculateDigest(digest, (const byte*)[data bytes], [data length]);
    
    NSData * hashVale = [NSData dataWithBytes:digest length:sizeof digest];
    return hashVale;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    //MD5
//    NSString *testStr = @"hello world md5";
//    NSData *testDAT = [testStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *md5Dat = [self getMD5Value:testDAT];
//    NSLog(@"%lu",md5Dat.length);
//    NSMutableString *s = [NSMutableString string];
//    unsigned char * hashValue = (byte *)[md5Dat bytes];
//    
//    int i;
//    for (i = 0; i < [md5Dat length]; i++) {
//        [s appendFormat:@"%02x", hashValue[i]];
//    }
//    NSLog(@"%@",s);

    
    /*
    //RSA 生成密钥对
    char seed[1024]={1};
    unsigned int keyLength = 1024;
    char *privFilename = "/Users/cocoajin/Desktop/priKey.txt";
    char *pubFilename = "/Users/cocoajin/Desktop/pubKey.txt";
    
    CryptoPP::RandomPool randPool;
    randPool.IncorporateEntropy((byte *)seed, strlen(seed));
    
    CryptoPP::RSAES_OAEP_SHA_Decryptor priv(randPool, keyLength);
    CryptoPP::HexEncoder privFile(new CryptoPP::FileSink(privFilename));
    priv.DEREncode(privFile);
    privFile.MessageEnd();
    
    CryptoPP::RSAES_OAEP_SHA_Encryptor pub(priv);
    CryptoPP::HexEncoder pubFile(new CryptoPP::FileSink(pubFilename));
    pub.DEREncode(pubFile);
    pubFile.MessageEnd();
    
     */
    
   
    /*
    //RSA 加密
    char seed[1024]={2};
    char *pubFilename = "/Users/cocoajin/Desktop/pubKey.txt";
    char *message = "hello ios cryptopp";
    printf("%s\n",message);
    CryptoPP::FileSource pubFile(pubFilename, true, new CryptoPP::HexDecoder);
    CryptoPP::RSAES_OAEP_SHA_Encryptor pub(pubFile);
    
    CryptoPP::RandomPool randPool;
    randPool.IncorporateEntropy((byte *)seed, strlen(seed));
    
    std::string encresult;
    CryptoPP::StringSource(message, true, new CryptoPP::PK_EncryptorFilter(randPool, pub, new CryptoPP::HexEncoder(new CryptoPP::StringSink(encresult))));
    std::cout << encresult << std::endl;
    
    
    //RSA 解密
    char *privFilename = "/Users/cocoajin/Desktop/priKey.txt";

    CryptoPP::FileSource privFile(privFilename, true, new CryptoPP::HexDecoder);
    CryptoPP::RSAES_OAEP_SHA_Decryptor priv(privFile);
    
    CryptoPP::AutoSeededRandomPool _rng;
    CryptoPP::RSAES_OAEP_SHA_Decryptor tpriv(_rng, 1024);

    std::string decresult;
    CryptoPP::StringSource(encresult.c_str(), true, new CryptoPP::HexDecoder(new CryptoPP::PK_DecryptorFilter(_rng, priv, new CryptoPP::StringSink(decresult))));
    std::cout << decresult << std::endl;
     
     */

    
    /*
    //RSA 签名与较验签名
    char *privFilename = "/Users/cocoajin/Desktop/priKey.txt";
    char *pubFilename = "/Users/cocoajin/Desktop/pubKey.txt";

    char *signatureFilename = "/Users/cocoajin/Desktop/sin.txt";
    char *messageFileName = "/Users/cocoajin/Desktop/NOTES.txt";
    CryptoPP::FileSource privFile(privFilename, true, new CryptoPP::HexDecoder);

    
    //GlobalRNG
    CryptoPP::AutoSeededRandomPool _rng;
    CryptoPP::RSAES_OAEP_SHA_Decryptor tpriv(_rng, 1024);

    
    CryptoPP::RSASSA_PKCS1v15_SHA_Signer priv(privFile);
    CryptoPP::FileSource f(messageFileName, true, new CryptoPP::SignerFilter(_rng, priv, new CryptoPP::HexEncoder(new CryptoPP::FileSink(signatureFilename))));

     
    
    //验证签名
    CryptoPP::FileSource pubFile(pubFilename, true, new CryptoPP::HexDecoder);
    CryptoPP::RSASSA_PKCS1v15_SHA_Verifier pub(pubFile);
    
    CryptoPP::FileSource signatureFile(signatureFilename, true, new CryptoPP::HexDecoder);
    if (signatureFile.MaxRetrievable() != pub.SignatureLength())
    {
        printf("\nNO\n");
        return;
    }
    CryptoPP::SecByteBlock signature(pub.SignatureLength());
    signatureFile.Get(signature, signature.size());
    
    CryptoPP::VerifierFilter *verifierFilter = new CryptoPP::VerifierFilter(pub);
    verifierFilter->Put(signature, pub.SignatureLength());
    CryptoPP::FileSource ff(messageFileName, true, verifierFilter);
    printf("\n%d\n",verifierFilter->GetLastResult());
     
      */
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
